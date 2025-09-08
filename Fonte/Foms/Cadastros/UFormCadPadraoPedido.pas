unit UFormCadPadraoPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFormCadPadrao, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  DataSet.Serialize, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls ;

type
  OperacaoDML = (Ins, Upd);
  TFormCadPadraoPedido = class(TFormCadPadrao)
    Panel3: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    PanelGridCentral: TPanel;
    ButtonSalvar: TPanel;
    SPBSalvar: TSpeedButton;
    EditCodigoCliente: TEdit;
    Label1: TLabel;
    FDMemTablePadraocliente: TIntegerField;
    PanelCarregarPedido: TPanel;
    SpeedButton1: TSpeedButton;
    PanelCancelarPedido: TPanel;
    SpeedButton2: TSpeedButton;
    PanelEdicaoPed: TPanel;
    SPBCancelaPed: TSpeedButton;
    PanelGridProdutos: TPanel;
    Panel9: TPanel;
    dbgridprodutos: TDBGrid;
    SpbAddproduto: TSpeedButton;
    Panel6: TPanel;
    FDMemTablePedido: TFDMemTable;
    IntegerField1: TIntegerField;
    FDTable_ItensPedido: TFDMemTable;
    Panel5: TPanel;
    FDMemTablePedidopedidov: TIntegerField;
    FDMemTablePedidodata_emissao: TSQLTimeStampField;
    FDMemTablePedidovalor_total: TFloatField;
    Panel7: TPanel;
    Label3: TLabel;
    DtEmissao: TDateTimePicker;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    Panel8: TPanel;
    Panel4: TPanel;
    FDTable_ItensPedidopedidov: TIntegerField;
    FDTable_ItensPedidoproduto: TIntegerField;
    FDTable_ItensPedidoqtde: TIntegerField;
    FDTable_ItensPedidovalor_unit: TFloatField;
    FDTable_ItensPedidovalor_total: TFloatField;
    FD_Grid_produto: TFDMemTable;
    DsGrid_produto: TDataSource;
    DsPedido: TDataSource;
    FDMemTablePedidototal_qtde: TIntegerField;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label5: TLabel;
    FDMemTablePadraonome: TStringField;
    DBEditCliente: TDBEdit;
    FD_Grid_produtoproduto: TIntegerField;
    FD_Grid_produtodescricao: TStringField;
    FD_Grid_produtocodigo: TStringField;
    FD_Grid_produtovalor_unit: TFloatField;
    FD_Grid_produtovalor_total: TFloatField;
    FD_Grid_produtoqtde: TIntegerField;
    SpbDeleteproduto: TSpeedButton;
    Label6: TLabel;
    procedure EditCodigoClienteChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SPBCancelaPedClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditCodigoClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpbAddprodutoClick(Sender: TObject);
    procedure SPBSalvarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure dbgridprodutosKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton2Click(Sender: TObject);
    procedure dbgridprodutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgridprodutosDblClick(Sender: TObject);
    procedure SpbDeleteprodutoClick(Sender: TObject);
    procedure FD_Grid_produtoAfterPost(DataSet: TDataSet);
    procedure FD_Grid_produtoAfterDelete(DataSet: TDataSet);

  private
    { Private declarations }
    TypeOperacaoDML:OperacaoDML;
    procedure EdicaoPedido( Ativo : Boolean ) ;
    procedure BuscarCliente( codigo :string );

    // DBgrid
    Procedure CalcValores;

    // salvar
    Function SalvarPedido:Boolean;

    //  editar item do grid
    procedure EditarItem;


  public
    { Public declarations }
  end;

var
  FormCadPadraoPedido: TFormCadPadraoPedido;

implementation

{$R *.dfm}

uses UFormAddProdutoPed, UFormEditarItemPedido;

procedure TFormCadPadraoPedido.BuscarCliente ( codigo :string );
var
 sql:string;
begin
  if Length (codigo)>0 then
  begin
     sql:='select cliente, nome from cLientes where cliente  ='+ codigo ;
     FDMemTablePadrao.close;
     FDMemTablePadrao.open;
     FDMemTablePadrao.loadfromjson(  Dmbase.SQL_GET(  sql  ) );

     if FDMemTablePadrao.recordcount>0 then
       EdicaoPedido(true)
     else
       ShowMessage('Cliente não localizado : '+EditCodigoCliente.text);
  end;
end;







procedure TFormCadPadraoPedido.CalcValores;
var
 ValorTotal : Double;
 QtdeTotal : integer;
 id_recno:integer;
begin
    ValorTotal:=0;
    QtdeTotal:=0;

    id_recno:=FD_Grid_produto.RecNo;

    FD_Grid_produto.DisableControls;
    FD_Grid_produto.first;
    while not FD_Grid_produto.eof do
    begin
      QtdeTotal:= QtdeTotal + FD_Grid_produto.FieldByName('qtde').AsInteger;
      ValorTotal:= ValorTotal + FD_Grid_produto.FieldByName('valor_total').AsFloat;

      FD_Grid_produto.next;
    end;
    FD_Grid_produto.first;

    FDMemTablePedido.Edit;
    FDMemTablePedido.FieldByName('total_qtde').AsInteger  :=  QtdeTotal ;
    FDMemTablePedido.FieldByName('valor_total').AsFloat    :=  ValorTotal;
    FDMemTablePedido.post;

    FD_Grid_produto.EnableControls;
    FD_Grid_produto.RecNo:=id_recno;

end;

procedure TFormCadPadraoPedido.dbgridprodutosDblClick(Sender: TObject);
begin
  inherited;
  EditarItem;
end;

procedure TFormCadPadraoPedido.dbgridprodutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_DELETE then
  begin
    if Application.MessageBox(pchar('Confirma a exclusão do item?'),'Aviso',MB_YESNO+MB_ICONWARNING)=ID_YES then
      FD_Grid_produto.delete;

    Key := 0;
  end;
end;

procedure TFormCadPadraoPedido.dbgridprodutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
     EditarItem;

end;

procedure TFormCadPadraoPedido.EdicaoPedido(Ativo: Boolean);
begin
  if ativo  then
  begin
     PanelGridProdutos.visible:=true;
     EditCodigoCliente.enabled:=false;
     SPBSalvar.enabled:=true;
     PanelEdicaoPed.Visible:=true;
     dbgridprodutos.SetFocus;
     DBEditCliente.Visible:=true;
     PanelCarregarPedido.Visible:=false;
     PanelCancelarPedido.Visible:=false;
  end
  else
  begin
     PanelGridProdutos.visible:=false;
     SPBSalvar.enabled:=false;
     EditCodigoCliente.enabled:=true;
     PanelEdicaoPed.Visible:=false;
     DBEditCliente.Visible:=false;
  end;

end;

procedure TFormCadPadraoPedido.EditarItem;
var
  t : TFormEditarItemPedido;
begin
  try
    t := TFormEditarItemPedido.Create(nil);
    t.DsEditarItem.dataset:=FD_Grid_produto;
    t.showmodal;
  finally
     CalcValores;
     FreeAndNil( t );
  end;

end;

procedure TFormCadPadraoPedido.EditCodigoClienteChange(Sender: TObject);
begin
  inherited;
  if Length( trim( EditCodigoCliente.Text )) >0 then
  begin
    PanelCarregarPedido.Visible:=false;
    PanelCancelarPedido.Visible:=false;
  end
  else
  begin
    PanelCarregarPedido.Visible:=true;
    PanelCancelarPedido.Visible:=true;
  end;

end;

procedure TFormCadPadraoPedido.EditCodigoClienteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN)  then
  begin
    TypeOperacaoDML:=Ins;
    DtEmissao.Date := Date;
    BuscarCliente( Editcodigocliente.text );
    Key := 0;
  end;
end;

procedure TFormCadPadraoPedido.FD_Grid_produtoAfterDelete(DataSet: TDataSet);
begin
  inherited;
  CalcValores;
end;

procedure TFormCadPadraoPedido.FD_Grid_produtoAfterPost(DataSet: TDataSet);
begin
  inherited;
  CalcValores;
end;

procedure TFormCadPadraoPedido.FormCreate(Sender: TObject);
begin
  inherited;
  FDMemTablePedido.CreateDataSet;
  FDTable_ItensPedido.CreateDataSet;
  FD_Grid_produto.CreateDataSet;

end;


procedure TFormCadPadraoPedido.FormShow(Sender: TObject);
begin
  inherited;
  DrawControl ( PanelCarregarPedido );
  DrawControl ( PanelCancelarPedido );
  DrawControl ( ButtonSalvar );
  DrawControl ( PanelEdicaoPed );

end;

function TFormCadPadraoPedido.SalvarPedido: Boolean;
var
  sql:string;
begin
  inherited;
  if FD_Grid_produto.RecordCount>0 then
  begin
    try
      // gravar o cliente na tabela do pedido..
      FDMemTablePedido.Edit;
      FDMemTablePedido.FieldByName('cliente').asinteger := FDMemTablePadrao.FieldByName('cliente').asinteger;
      FDMemTablePedido.FieldByName('data_emissao').AsDateTime := DtEmissao.Date ;
      FDMemTablePedido.Post;

      // gravar items
      FDTable_ItensPedido.Close; // limpar dataset
      FDTable_ItensPedido.open;

      FD_Grid_produto.DisableControls;
      FD_Grid_produto.First;
      while not FD_Grid_produto.eof do
      begin
        if ( FD_Grid_produto.FieldByName('qtde').Value>0 ) and
           ( FD_Grid_produto.FieldByName('valor_unit').Value > 0 )
        then
        begin
          FDTable_ItensPedido.Edit;
          FDTable_ItensPedido.Append;

          if TypeOperacaoDML = Upd then
            FDTable_ItensPedido.FieldByName('pedidov').Value:=    FDMemTablePedido.FieldByName('pedidov').Value;

          FDTable_ItensPedido.FieldByName('produto').Value:=      FD_Grid_produto.FieldByName('produto').Value;
          FDTable_ItensPedido.FieldByName('qtde').Value:=         FD_Grid_produto.FieldByName('qtde').Value;
          FDTable_ItensPedido.FieldByName('valor_unit').Value:=   FD_Grid_produto.FieldByName('valor_unit').Value;
          FDTable_ItensPedido.FieldByName('valor_total').Value:=  FD_Grid_produto.FieldByName('valor_total').Value;

          FDTable_ItensPedido.Post;
        end;

        FD_Grid_produto.Next
      end;

      FD_Grid_produto.EnableControls;
      FD_Grid_produto.First;

    except
      on e:exception do
      begin
        result:=false;
        ShowMessage('Erro : '+e.Message);
      end;
    end;

    if TypeOperacaoDML = Ins then
      Result:=Dmbase.Inserir_Pedido_Venda( FDMemTablePedido, FDTable_ItensPedido )
    else
      Result:=Dmbase.Update_Pedido_Venda( FDMemTablePedido, FDTable_ItensPedido );

  end
  else
  begin
    ShowMessage('Precisa informar os produtos !');
    Result:=false;
  end;

end;

procedure TFormCadPadraoPedido.SPBCancelaPedClick(Sender: TObject);
begin
  inherited;
  EdicaoPedido(false);
  EditCodigoCliente.Text:=EmptyStr;
  FD_Grid_produto.Close;
  FD_Grid_produto.open;
end;

procedure TFormCadPadraoPedido.SpbDeleteprodutoClick(Sender: TObject);
begin
  inherited;
  if Application.MessageBox(pchar('Confirma a exclusão do item?'),'Aviso',MB_YESNO+MB_ICONWARNING)=ID_YES then
      FD_Grid_produto.delete;
end;

procedure TFormCadPadraoPedido.SPBSalvarClick(Sender: TObject);
begin
   if SalvarPedido then
   begin
     ShowMessage('Comando executado com sucesso!');
     EdicaoPedido( false );
     EditCodigoCliente.Text:=EmptyStr;
   end;
end;

procedure TFormCadPadraoPedido.SpeedButton1Click(Sender: TObject);
var
  StrPedido:string;
  sql:string;
begin
  inherited;
  StrPedido := InputBox('Buscar pedido', 'Informe o número do pedido:', '');

  if StrPedido<>EmptyStr then
  begin
    sql:='select  pedidov,  cliente , data_emissao, valor_total, total_qtde from pedido_venda pv '+
        ' where pv.pedidov = '+StrPedido;

    FDMemTablePedido.Close;
    FDMemTablePedido.Open;
    FDMemTablePedido.loadfromjson(  Dmbase.SQL_GET(  sql  ) );

    if FDMemTablePedido.RecordCount>0 then
    begin
      DtEmissao.Date:= FDMemTablePedido.FieldByName('data_emissao').AsDateTime;

      sql:=' select  ppv.produto, p.descricao, p.codigo, ppv.valor_unit, ppv.valor_total, ppv.qtde from produto_pedidov ppv '+
           ' inner join produtos p on p.produto=ppv.produto '+
           ' where ppv.pedidov = '+ StrPedido;
      FD_Grid_produto.Close;
      FD_Grid_produto.Open;
      FD_Grid_produto.loadfromjson(  Dmbase.SQL_GET(  sql  ) );

      EditCodigoCliente.text:=FDMemTablePedido.FieldByName('cliente').asstring;
      BuscarCliente( FDMemTablePedido.FieldByName('cliente').asstring );
      TypeOperacaoDML:=Upd;
    end
    else
     ShowMessage('Pedido não localizado!');

  end;


end;

procedure TFormCadPadraoPedido.SpeedButton2Click(Sender: TObject);
var
 sqlLista:Tstringlist;
 StrPedido:string;
 Qtde_ped:integer;
begin
  try
     sqlLista:= Tstringlist.Create;
     StrPedido := InputBox('Cancelar pedido', 'Informe o número do pedido:', '');
     if StrPedido<>EmptyStr then
     begin
       if Application.MessageBox(pchar('Confirma a exclusão do cadastro?'),'Aviso',MB_YESNO+MB_ICONWARNING)=ID_YES then
       begin
         sqlLista.add('delete from produto_pedidov where pedidov='+ StrPedido ) ;
         sqlLista.add('delete from pedido_venda where pedidov='+ StrPedido ) ;

         if Dmbase.SQL_DELETE( sqlLista ) then
            ShowMessage('Comando executado com sucesso!');
       end;
     end;
  finally
    FreeAndNil(sqlLista);
  end;

end;

procedure TFormCadPadraoPedido.SpbAddprodutoClick(Sender: TObject);
var
  sql:string;
  t: TFormAddProdutoPed;
  ValorTotal:Double;
begin
  inherited;

  try
    t:= TFormAddProdutoPed.create(nil);
    t.DsItemPed.dataset:=FD_Grid_produto;
    t.showmodal;
  finally
    FreeAndNil( t );

  end;



end;

end.
