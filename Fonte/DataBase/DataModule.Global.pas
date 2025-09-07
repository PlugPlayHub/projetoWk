unit DataModule.Global;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, Vcl.Dialogs,

  System.JSON, FireDAC.DApt,

  DataSet.Serialize.Config, DataSet.Serialize,
  UntINIfileManager,

  FireDAC.Phys.FBDef, FireDAC.Phys.FB,
  FireDAC.Phys.IBBase ,
  System.Generics.Collections, System.Variants, Data.DB, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL ;

type
  TLinhaDinamica = TDictionary<string, Variant>;
  TListaLinhas = TList<TLinhaDinamica>;
  type_obj = (nsRecord, nsSubForm, nsDescriptor, nsDataset );

  TDmbase = class(TDataModule)

    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    DBMySQL: TFDConnection;

    procedure DataModuleCreate(Sender: TObject);

  private
    // credencias database
    BaseDados, PORTA,  USER, PASS, SERVER, Bibliotecadll  :string;

    // Acesso database
    function CarregarConfigDBMySQL:boolean;

  public
    function conectarbse:boolean;
    function Desconectarbse:boolean;

    // montar comandos SQL
    Function RetornarSQLInsert( Fd:TFDMemTable; Tab, FieldPK:string ) :string;
    Function RetornarSQLUpdate( Fd:TFDMemTable; Tab, FieldPK:string  ):string;

    // aplciar comandos Insert e Update simples
    Function insertSQL_FdParans(FD:TFDMemTable; Comando, FieldPK:string):boolean;
    Function UpdateSQL_FdParans(FD:TFDMemTable; Comando, FieldPK:string):boolean;

    function Inserir_retornar_PK(Sql, FieldRet: string):integer; // retornaPK

    // consylta
    Function SQL_GET(Comando:string) :Tjsonarray;
    Function Consulta_alterar(sql, Strfield_PK: string ; field_PK:integer):TJSONArray;
    Function SQLCount(Comando:string):integer;

    // pedido venda  - separado dos demais
    Function Inserir_Pedido_Venda( FDPedido,FDItens :TFDMemTable ):boolean;
    Function Update_Pedido_Venda( FDPedido,FDItens :TFDMemTable ):boolean;


    // delete
    Function SQL_DELETE(ListaComandos:Tstringlist) :Boolean;

  end;

var
  Dmbase: TDmbase;

implementation


{$R *.dfm}

uses UFormCadPadrao;


function TDmbase.CarregarConfigDBMySQL:boolean;
var
   dir:string;
begin
  Result := False;
  try
    if ( BaseDados = EmptyStr ) or
       ( server = EmptyStr ) or
       ( Porta = EmptyStr ) or
       ( USER = EmptyStr ) or
       ( PASS = EmptyStr )
    then
    begin
       ShowMessage('Confira as configuração de acessso ao banco de dados parametros: Databasename, Porta, Ip do server, Username e Password ' );
       Result:=false;
       exit;
    end;

    if DBMySQL.Connected = False then
    begin
      DBMySQL.DriverName := 'MySQL';

      with DBMySQL.Params do
      begin
        Clear;
        Add('DriverID=MySQL');
        Add('Server='     + server);
        Add('Port='       + Porta);
        Add('Database='   + BaseDados);
        Add('User_Name='  + USER );
        Add('Password='   + PASS);
      end;

      dir:=ExtractFilePath(ParamStr(0));

      if Bibliotecadll=EmptyStr then
      begin
         if FileExists(dir+'libmysql.dll') then
            FDPhysMySQLDriverLink1.VendorLib := dir+'libmysql.dll'
         else
         begin
           ShowMessage('Atenção: precisa disponibilizar a libmysql.dll na pasta do sistema, ou informar o diretório de sua localização!' );
           result:=false;
         end;
      end
      else
          FDPhysMySQLDriverLink1.VendorLib := Bibliotecadll;

      FDPhysMySQLDriverLink1.DriverID := 'MySQL';
      DBMySQL.Connected := True;
    end;

    Result := DBMySQL.Connected;

  except
    on E: Exception do
    begin
      result:=false;
      raise Exception.Create('Error Message '+ e.Message);
    end;
  end;

end;

procedure TDmbase.DataModuleCreate(Sender: TObject);
begin
   TDataSetSerializeConfig.GetInstance.CaseNameDefinition := cndLower;
   TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

   BaseDados  := ReadParametro(tpString, 'DataBase', 'Databasename','' );
   PORTA      := ReadParametro(tpString, 'DataBase', 'Porta','' );
   USER       := ReadParametro(tpString, 'DataBase', 'User','' );
   PASS       := ReadParametro(tpString, 'DataBase', 'Pass','' );
   SERVER     := ReadParametro(tpString, 'DataBase', 'Server','' );
   Bibliotecadll := ReadParametro(tpString, 'DataBase', 'BibliotecaDll','' );

   conectarbse;


end;


function TDmbase.Desconectarbse: boolean;
begin
  DBMySQL.Connected := false;
end;


function TDmbase.insertSQL_FdParans(FD: TFDMemTable; Comando, FieldPK: string): boolean;
var
  qry: TFDQuery;
  i: Integer;
  FieldName: string;
begin
  Result := False;

  if conectarbse then
  begin
    qry := TFDQuery.Create(nil);
    try
      qry.Connection := DBMySQL;
      qry.SQL.Text := Comando;
      qry.Params.Clear;


      // cria parâmetros do item e atribui valor
      for i := 0 to FD.FieldDefs.Count - 1 do
        begin
          FieldName := FD.FieldDefs[i].Name;

          if SameText(FieldPK, FieldName) then Continue; // ignora PK

          // Cria o parâmetro explicitamente, se ainda não existir
          if qry.FindParam(FieldName) = nil then
          begin
            with qry.Params.Add do
            begin
              Name := FieldName;
              ParamType := ptInput;

              case FD.FieldDefs[i].DataType of
                ftInteger: DataType := ftInteger;
                ftFloat, ftCurrency: DataType := ftFloat;
                ftDate, ftDateTime: DataType := ftDateTime;
              else
                DataType := ftString;
              end;

            end;
          end;

          // Atribui o valor separadamente
          case FD.FieldDefs[i].DataType of
            ftInteger:
               qry.ParamByName(FieldName).AsInteger := FD.FieldByName(FieldName).AsInteger;

            ftFloat, ftCurrency:
               qry.ParamByName(FieldName).AsFloat := FD.FieldByName(FieldName).AsFloat;

            ftDate, ftDateTime, ftTimeStamp:
               begin
                  // Se o campo veio como string (JSON), tenta converter
                  if FD.FieldByName(FieldName).IsNull then
                    qry.ParamByName(FieldName).Clear
                  else
                  begin
                    try
                      qry.ParamByName(FieldName).AsDateTime :=  FD.FieldByName(FieldName).AsDateTime;
                    except
                      // conversão fallback caso seja string
                      qry.ParamByName(FieldName).AsDateTime := StrToDateTime(FD.FieldByName(FieldName).AsString);
                    end;
                  end;
               end;

            ftString, ftWideString:
               qry.ParamByName(FieldName).AsString := FD.FieldByName(FieldName).AsString;
          end;
        end;


      if not DBMySQL.InTransaction then
        DBMySQL.StartTransaction;

      try
        qry.ExecSQL;
        DBMySQL.Commit;

        Result := True;
      except
        on E: Exception do
        begin
          if DBMySQL.InTransaction then
            DBMySQL.Rollback;
          ShowMessage(E.Message);
        end;
      end;

    finally
      qry.Free;
    end;
  end;
end;



function TDmbase.RetornarSQLInsert(Fd: TFDMemTable; Tab,  FieldPK: string): string;
  var
   i: integer;
   StrField, SQLinsert :string;
   ListaCampos:TStringList;
begin
   try
     ListaCampos:=TStringList.Create;

     for I := 0 to Fd.FieldDefs.Count-1 do
       begin
         StrField:=Fd.FieldDefs.Items[i].Name;
         if UpperCase( StrField ) <> UpperCase( FieldPK ) then
            ListaCampos.Add(StrField)
       end;

     SQLinsert:='';
     SQLinsert := 'insert into ' +tab+' (';

     for I := 0 to Pred(ListaCampos.Count) do
       begin
          if I>0 then  SQLinsert:=SQLinsert +', ';
          SQLinsert := SQLinsert +UpperCase( ListaCampos[I] );
       end;

      SQLinsert := SQLinsert +' ) values (';

      for I := 0 to Pred(ListaCampos.Count) do
        begin
          if I>0 then  SQLinsert:= SQLinsert+' , ';
          SQLinsert := SQLinsert +' :' +UpperCase(ListaCampos[I]) ;
        end;

      SQLinsert := SQLinsert +')';
      Result:=SQLinsert;

   finally
     FreeAndNil(ListaCampos);
   end;

end;

function TDmbase.RetornarSQLUpdate(Fd: TFDMemTable; Tab, FieldPK:string  ): string;
var
 i: integer;
 StrField, SQLUpdate :string;
 ListaCampos:TStringList;
begin
   try

      ListaCampos:=TStringList.Create;

      for I := 0 to Fd.FieldDefs.Count-1 do
        begin
          StrField:=Fd.FieldDefs.Items[i].Name;
          if SameText( FieldPK, StrField ) then
            Continue;
          ListaCampos.Add(StrField)
        end;

      Result := 'update  ' +tab+' set  ';

      for i := 0 to Pred(ListaCampos.Count) do
        begin
          if i <>0 then  Result := Result + ', ';
          Result := Result +UpperCase( ListaCampos[i] )+'=';
          Result := Result +' :' +UpperCase(ListaCampos[i]) ;
        end;

      Result := Result;

   finally
     FreeAndNil(ListaCampos);
   end;


end;

function TDmbase.Inserir_Pedido_Venda( FDPedido,FDItens :TFDMemTable): boolean;
var
  qry: TFDQuery;
  i: Integer;
  FieldName: string;
  sql:string;
  Id_pedido:integer;
begin
  Result := False;

  if conectarbse then
  begin
    qry := TFDQuery.Create(nil);
    try
      qry.Connection := DBMySQL;

      qry.SQL.Clear;
      // comandos Tabela pedido_venda
      SQL:=RetornarSQLInsert( FDPedido, 'Pedido_venda', 'Pedidov') ;
      qry.SQL.Text := sql;

      qry.Params.Clear;

      // cria parâmetros e já preenche valores Tabela Pedido
      for i := 0 to FDPedido.FieldDefs.Count - 1 do
        begin
          FieldName := FDPedido.FieldDefs.Items[i].Name;

          if SameText('Pedidov', FieldName) then
            Continue; // ignora PK

          if not FDPedido.FieldByName(FieldName).IsNull then
          begin
            with qry.Params.Add do
            begin
              Name      := FieldName;
              DataType  := FDPedido.FieldDefs.Items[i].DataType;
              ParamType := ptInput;
              Value     := FDPedido.FieldByName(FieldName).Value;
            end;
          end;
        end;

      if not DBMySQL.InTransaction then
        DBMySQL.StartTransaction;

      try
        qry.ExecSQL;
        // pega o último ID
        qry.SQL.Text := 'SELECT LAST_INSERT_ID() AS Pedidov ';
        qry.Open;

        Id_pedido := qry.FieldByName('pedidov').AsInteger;

      except
        on E: Exception do
          begin
            if DBMySQL.InTransaction then
              DBMySQL.Rollback;
            ShowMessage('Erro gravando cabeçalho do pedido : '+ E.Message);
            Exit;
          end;
      end;

      // iniciando itens

      FDItens.first;
      while not FDItens.eof do
      begin
        FDItens.edit;
        FDItens.fieldbyname('pedidov').asinteger:= Id_pedido;
        FDItens.post;

        qry.SQL.Clear;
        // comandos Tabela Produto_pedidov

        SQL:=RetornarSQLInsert( FDItens, 'Produto_pedidov', 'Produto_pedidov') ;
        qry.SQL.Text := sql;

        qry.Params.Clear;

        // cria parâmetros e já preenche valores Tabela Pedido
        for i := 0 to FDItens.FieldDefs.Count - 1 do
          begin
            FieldName := FDItens.FieldDefs.Items[i].Name;

            if SameText('Produto_pedidov', FieldName) then
              Continue; // ignora PK

            if not FDItens.FieldByName(FieldName).IsNull then
            begin
              with qry.Params.Add do
              begin
                Name     := FieldName;
                DataType := FDItens.FieldDefs.Items[i].DataType;
                ParamType := ptInput;
                Value := FDItens.FieldByName(FieldName).Value;
              end;
            end;
          end;

        try
          qry.ExecSQL;
        except
            on E: Exception do
            begin
              if DBMySQL.InTransaction then
                DBMySQL.Rollback;
              ShowMessage('Erro gravando itens do pedido : '+ E.Message);
              Exit
            end;
        end;

        FDItens.next;
      end;

      try
        DBMySQL.Commit;
        Result:=true;
      except
          on E: Exception do
          begin
            if DBMySQL.InTransaction then
              DBMySQL.Rollback;
            ShowMessage('Erro gravando itens do pedido : '+ E.Message);
            Exit
          end;
      end;

    finally
      qry.Free;
    end;
  end;

end;

function TDmbase.Inserir_retornar_PK(Sql, FieldRet: string): Integer;
var
  qry: TFDQuery;
begin
  Result := -1; // valor default
  if conectarbse then
  begin
    qry := TFDQuery.Create(nil);
    try
      qry.Connection := DBMySQL;
      try
        if not DBMySQL.InTransaction then
          DBMySQL.StartTransaction;

        // executa o insert
        qry.SQL.Text := Sql;
        qry.ExecSQL;

        // pega o último ID
        qry.SQL.Text := 'SELECT LAST_INSERT_ID() AS ' + FieldRet;
        qry.Open;

        Result := qry.FieldByName(FieldRet).AsInteger;

        DBMySQL.Commit;
      except
        on E: Exception do
        begin
          DBMySQL.Rollback;
          ShowMessage(E.Message);
          raise; // opcional: relança o erro
        end;
      end;
    finally
      qry.Free;
    end;
  end;
end;



function TDmbase.conectarbse: boolean;
begin
   try
     if DBMySQL.Connected = false
     then
       CarregarConfigDBMySQL
     else
       CarregarConfigDBMySQL;

   finally
     Result:=DBMySQL.Connected;
   end;
end;



function TDmbase.Consulta_alterar(sql, Strfield_PK : string ; field_PK:integer): TJSONArray;
var
    qry: TFDQuery;
begin
  if conectarbse then
  begin
    try
      try
        qry := TFDQuery.Create(nil);
        qry.Connection := DBMySQL;
        if not DBMySQL.InTransaction then
              DBMySQL.StartTransaction;

        qry.SQL.Add(sql);
        qry.ParamByName( Strfield_PK ).Value := inttostr( field_PK );

        qry.Active := true;
        Result := qry.ToJSONArray;
        DBMySQL.Commit;
      except
        on e:exception do
        begin
           DBMySQL.Rollback;
           ShowMessage(sql + #13+ #13 + e.Message);
           Abort;
        end;
      end;
    finally
      FreeAndNil(qry);
    end;
  end;


end;

function TDmbase.SQLCount(Comando: string): integer;
var
    qry: TFDQuery;
begin
  if conectarbse then
  begin
    try
      qry := TFDQuery.Create(nil);
      qry.Connection := DBMySQL;
      qry.SQL.Add(Comando);

      if not DBMySQL.InTransaction then
        DBMySQL.StartTransaction;

      try
        qry.Active := true;
        DBMySQL.Commit;
        Result :=qry.FieldByName('qtde').Value;
      finally
         DBMySQL.Rollback;
      end;

    finally
      FreeAndNil(qry);
    end;

  end;

end;

function TDmbase.SQL_DELETE(ListaComandos: Tstringlist): Boolean;
var
  qry: TFDQuery;
  i: Integer;
  FieldName: string;
begin
  Result := False;
  if conectarbse then
  begin
    qry := TFDQuery.Create(nil);
    try
      qry.Connection := DBMySQL;
      qry.Params.Clear;

      if not DBMySQL.InTransaction then
        DBMySQL.StartTransaction;

      try
        for I := 0 to ListaComandos.Count-1 do
        begin
          qry.SQL.Text := ListaComandos.Strings[i];
          qry.ExecSQL;
        end;
        DBMySQL.Commit;
        Result := True;
      except
        on E: Exception do
        begin
          if DBMySQL.InTransaction then
            DBMySQL.Rollback;
          ShowMessage(E.Message);
        end;
      end;
    finally
      qry.Free;
    end;
  end;
end;

function TDmbase.SQL_GET(Comando: string): Tjsonarray;
var
    qry: TFDQuery;
begin
  if conectarbse then
  begin
    try
      try
        qry := TFDQuery.Create(nil);
        qry.Connection := DBMySQL;

        if not DBMySQL.InTransaction then
            DBMySQL.StartTransaction;

        qry.SQL.Add(comando);
        qry.open;
        Result := qry.ToJSONArray;
        DBMySQL.Commit;

      except
        on e:exception do
        begin
           DBMySQL.Rollback;
           ShowMessage(Comando + #13+ #13 + e.Message);
           Abort;
        end;
      end;
    finally
      FreeAndNil(qry);
    end;
  end;
end;

function TDmbase.UpdateSQL_FdParans(FD: TFDMemTable; Comando, FieldPK: string): boolean;
var
  qry: TFDQuery;
  i: Integer;
  FieldName: string;
begin
  Result := False;

  if conectarbse then
  begin
    qry := TFDQuery.Create(nil);
    try
      qry.Connection := DBMySQL;
      qry.SQL.Text := Comando;
      qry.Params.Clear;

      // cria parâmetros do item e atribui valor
      for i := 0 to FD.FieldDefs.Count - 1 do
        begin
          FieldName := FD.FieldDefs[i].Name;

          if SameText(FieldPK, FieldName) then Continue; // ignora PK

          // Cria o parâmetro explicitamente, se ainda não existir
          if qry.FindParam(FieldName) = nil then
          begin
            with qry.Params.Add do
            begin
              Name := FieldName;
              ParamType := ptInput;

              case FD.FieldDefs[i].DataType of
                ftInteger: DataType := ftInteger;
                ftFloat, ftCurrency: DataType := ftFloat;
                ftDate, ftDateTime: DataType := ftDateTime;
              else
                DataType := ftString;
              end;
            end;
          end;

          // Atribui o valor separadamente
          case FD.FieldDefs[i].DataType of
            ftInteger:
               qry.ParamByName(FieldName).AsInteger := FD.FieldByName(FieldName).AsInteger;

            ftFloat, ftCurrency:
               qry.ParamByName(FieldName).AsFloat := FD.FieldByName(FieldName).AsFloat;

            ftDate, ftDateTime, ftTimeStamp:
               begin
                  // Se o campo veio como string (JSON), tenta converter
                  if FD.FieldByName(FieldName).IsNull then
                    qry.ParamByName(FieldName).Clear
                  else
                  begin
                    try
                      qry.ParamByName(FieldName).AsDateTime :=  FD.FieldByName(FieldName).AsDateTime;
                    except
                      // conversão fallback caso seja string
                      qry.ParamByName(FieldName).AsDateTime := StrToDateTime(FD.FieldByName(FieldName).AsString);
                    end;
                  end;
               end;

            ftString, ftWideString:
               qry.ParamByName(FieldName).AsString := FD.FieldByName(FieldName).AsString;
          end;
        end;


      if not DBMySQL.InTransaction then
        DBMySQL.StartTransaction;

      try
        qry.ExecSQL;
        DBMySQL.Commit;

        Result := True;
      except
        on E: Exception do
        begin
          if DBMySQL.InTransaction then
            DBMySQL.Rollback;
          ShowMessage(E.Message);
        end;
      end;

    finally
      qry.Free;
    end;
  end;

end;

function TDmbase.Update_Pedido_Venda(FDPedido, FDItens: TFDMemTable): Boolean;
var
  qry: TFDQuery;
  i: Integer;
  FieldName, SqlUpd, SqlInst: string;
begin
  Result := False;

  if not conectarbse then
    Exit;

  try
    qry := TFDQuery.Create(nil);
    qry.Connection := DBMySQL;
    qry.SQL.Clear;

    // Atualização do cabeçalho
    SqlUpd := Dmbase.RetornarSQLUpdate(FDPedido, 'pedido_venda', 'Pedidov');
    SqlUpd := SqlUpd + ' WHERE PEDIDOV = ' + IntToStr(FDPedido.FieldByName('PEDIDOV').AsInteger);
    qry.SQL.Text := UpperCase( SqlUpd );

    // Loop para criar e preencher parâmetros

    for i := 0 to FDPedido.FieldDefs.Count - 1 do
      begin
        FieldName := FDPedido.FieldDefs[i].Name;

        if SameText('Pedidov', FieldName) then  Continue; // ignora PK

        // Cria o parâmetro explicitamente, se ainda não existir
        if qry.FindParam(FieldName) = nil then
        begin
          with qry.Params.Add do
          begin
            Name := FieldName;
            ParamType := ptInput;

            case FDPedido.FieldDefs[i].DataType of
              ftInteger: DataType := ftInteger;
              ftFloat, ftCurrency: DataType := ftFloat;
              ftDate, ftDateTime: DataType := ftDateTime;
            else
              DataType := ftString;
            end;
          end;
        end;

        // Atribui o valor separadamente
        case FDPedido.FieldDefs[i].DataType of
          ftInteger:
             qry.ParamByName(FieldName).AsInteger := FDPedido.FieldByName(FieldName).AsInteger;

          ftFloat, ftCurrency:
             qry.ParamByName(FieldName).AsFloat := FDPedido.FieldByName(FieldName).AsFloat;

          ftDate, ftDateTime, ftTimeStamp:
             begin
                // Se o campo veio como string (JSON), tenta converter
                if FDPedido.FieldByName(FieldName).IsNull then
                  qry.ParamByName(FieldName).Clear
                else
                begin
                  try
                    qry.ParamByName(FieldName).AsDateTime :=  FDPedido.FieldByName(FieldName).AsDateTime;
                  except
                    // conversão fallback caso seja string
                    qry.ParamByName(FieldName).AsDateTime := StrToDateTime(FDPedido.FieldByName(FieldName).AsString);
                  end;
                end;
             end;

          ftString, ftWideString:
             qry.ParamByName(FieldName).AsString := FDPedido.FieldByName(FieldName).AsString;
        end;
      end;

    // Executa update
    if not DBMySQL.InTransaction then
      DBMySQL.StartTransaction;

    try
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        if DBMySQL.InTransaction then DBMySQL.Rollback;
        ShowMessage('Erro alterando cabeçalho do pedido: ' + E.Message);
        Exit;
      end;
    end;



    // -------------------------
    // Limpar e reinserir itens
    // -------------------------
    qry.SQL.Clear;
    qry.SQL.Text := 'DELETE FROM produto_pedidov WHERE pedidov = '+ IntToStr(FDPedido.FieldByName('PEDIDOV').AsInteger);
    qry.ExecSQL;

    FDItens.First;
    while not FDItens.Eof do
    begin
      qry.SQL.Clear;
      SqlInst := Dmbase.RetornarSQLInsert(FDItens, 'produto_pedidov', 'produto_pedidov');
      qry.SQL.Text := SqlInst;

      // cria parâmetros do item e atribui valor
      for i := 0 to FDItens.FieldDefs.Count - 1 do
        begin
          FieldName := FDItens.FieldDefs[i].Name;

          if SameText('produto_pedidov', FieldName) then  Continue; // ignora PK

          // Cria o parâmetro explicitamente, se ainda não existir
          if qry.FindParam(FieldName) = nil then
          begin
            with qry.Params.Add do
            begin
              Name := FieldName;
              ParamType := ptInput;

              case FDItens.FieldDefs[i].DataType of
                ftInteger: DataType := ftInteger;
                ftFloat, ftCurrency: DataType := ftFloat;
                ftDate, ftDateTime: DataType := ftDateTime;
              else
                DataType := ftString;
              end;
            end;
          end;

          // Atribui o valor separadamente
          case FDItens.FieldDefs[i].DataType of
            ftInteger:
               qry.ParamByName(FieldName).AsInteger := FDItens.FieldByName(FieldName).AsInteger;

            ftFloat, ftCurrency:
               qry.ParamByName(FieldName).AsFloat := FDItens.FieldByName(FieldName).AsFloat;

            ftDate, ftDateTime, ftTimeStamp:
               begin
                  // Se o campo veio como string (JSON), tenta converter
                  if FDItens.FieldByName(FieldName).IsNull then
                    qry.ParamByName(FieldName).Clear
                  else
                  begin
                    try
                      qry.ParamByName(FieldName).AsDateTime :=  FDItens.FieldByName(FieldName).AsDateTime;
                    except
                      // conversão fallback caso seja string
                      qry.ParamByName(FieldName).AsDateTime := StrToDateTime(FDItens.FieldByName(FieldName).AsString);
                    end;
                  end;
               end;

            ftString, ftWideString:
               qry.ParamByName(FieldName).AsString := FDItens.FieldByName(FieldName).AsString;
          end;
        end;


      try
        qry.ExecSQL;
      except
        on E: Exception do
        begin
          if DBMySQL.InTransaction then DBMySQL.Rollback;
          ShowMessage('Erro alterando itens do pedido: ' + E.Message);
          Exit;
        end;
      end;

      FDItens.Next;
    end;

    try
      DBMySQL.Commit;
      Result := True;
    except
      on E: Exception do
      begin
        if DBMySQL.InTransaction then DBMySQL.Rollback;
        ShowMessage(E.Message);
      end;
    end;

  finally
    qry.Free;
  end;
end;


end.
