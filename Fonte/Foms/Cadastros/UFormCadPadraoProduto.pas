unit UFormCadPadraoProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFormCadPadrao, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Mask, Vcl.DBCtrls,

  DataSet.Serialize ;

type
  OperacaoDML = (Ins, Upd);

  TFormCadPadraoProduto = class(TFormCadPadrao)
    FDMemTablePadraoProduto: TIntegerField;
    FDMemTablePadraocodigo: TStringField;
    FDMemTablePadraodescricao: TStringField;
    FDMemTablePadraopreco_venda: TFloatField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
  private
    { Private declarations }

  public
    { Public declarations }
    TypeOperacaoDML:OperacaoDML;
    Function Salvar:Boolean ; override;
    Function Consulta_alterar( id_pk:integer):Boolean ; override;
  end;

var
  FormCadPadraoProduto: TFormCadPadraoProduto;

implementation

{$R *.dfm}

{ TFormCadPadraoProduto }

function TFormCadPadraoProduto.Consulta_alterar( id_pk:integer): Boolean;
var
 sql:string;
begin
   try
     sql:='select Produto,  codigo, descricao, preco_venda from produtos where produto=:produto';
     FDMemTablePadrao.close;
     FDMemTablePadrao.open;
     FDMemTablePadrao.loadfromjson(   Dmbase.Consulta_alterar(sql, 'produto', id_pk )  );
     result:=true;
   except
     result:=false;
   end;
end;

function TFormCadPadraoProduto.Salvar: Boolean;
var
  SQL: string;
begin
  try
    if TypeOperacaoDML = Ins then
    begin
      SQL:=Dmbase.RetornarSQLInsert( FDMemTablePadrao, 'Produtos', 'Produto') ;
      Result:=Dmbase.insertSQL_FdParans(FDMemTablePadrao, SQL, 'Produto' )
    end
    else
    begin
      SQL:=Dmbase.RetornarSQLUpdate( FDMemTablePadrao, 'Produtos', 'Produto') ;
      SQL:= SQL+' where produto = '+ IntToStr( FDMemTablePadrao.fieldbyname('produto').value );
      Result:=Dmbase.UpdateSQL_FdParans(FDMemTablePadrao, SQL, 'Produto' );
    end;

    if Result=false then Abort;

    ShowMessage('Comando executado com sucesso!');
    FDMemTablePadrao.close;
    FDMemTablePadrao.open;

    DBEdit1.SetFocus;
  except
    on e:exception do
    begin
      result:=false;
      ShowMessage('Erro: '+e.message);
    end;
  end;
end;

end.
