unit UFormCadPadraoCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFormCadPadrao, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls,

  DataSet.Serialize ;

type
  OperacaoDML = (Ins, Upd);
  TFormCadPadraoCliente = class(TFormCadPadrao)
    FDMemTablePadraocliente: TIntegerField;
    FDMemTablePadraonome: TStringField;
    FDMemTablePadraocidade: TStringField;
    FDMemTablePadraouf: TStringField;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
    TypeOperacaoDML:OperacaoDML;
    Function Salvar:Boolean ; override;
    Function Consulta_alterar( id_pk:integer ):Boolean ; override;

  end;

var
  FormCadPadraoCliente: TFormCadPadraoCliente;

implementation

{$R *.dfm}

{ TFormCadPadraoCliente }

function TFormCadPadraoCliente.Consulta_alterar(id_pk: integer): Boolean;
var
 sql:string;
begin
   try
     sql:='select cliente, nome, cidade, uf from clientes where cliente=:cliente';
     FDMemTablePadrao.close;
     FDMemTablePadrao.open;
     FDMemTablePadrao.loadfromjson(   Dmbase.Consulta_alterar(sql, 'cliente', id_pk )  );
     result:=true;
   except
     result:=false;
   end;
end;



function TFormCadPadraoCliente.Salvar: Boolean;
var
  SQL: string;
begin
  try
    if TypeOperacaoDML = Ins then
    begin
      SQL:=Dmbase.RetornarSQLInsert( FDMemTablePadrao, 'Clientes', 'cliente') ;
      Result:=Dmbase.insertSQL_FdParans(FDMemTablePadrao, SQL, 'cliente' )
    end
    else
    begin
      SQL:=Dmbase.RetornarSQLUpdate( FDMemTablePadrao, 'Clientes', 'Cliente') ;
      SQL:= SQL+' where cliente = '+ IntToStr( FDMemTablePadrao.fieldbyname('cliente').value );
      Result:=Dmbase.UpdateSQL_FdParans(FDMemTablePadrao, SQL, 'cliente' );
    end;

    if Result=false then Abort;

    ShowMessage('Comando executado com sucesso!');
    FDMemTablePadrao.close;
    FDMemTablePadrao.open;

  except
    on e:exception do
    begin
      result:=false;
      ShowMessage('Erro: '+e.message);
    end;
  end;

end;

end.
