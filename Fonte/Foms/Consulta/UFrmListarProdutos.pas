unit UFrmListarProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmModelo, Data.DB, Vcl.StdCtrls,
  Vcl.WinXCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  DataModule.Global, DataSet.Serialize, // função

  UFormCadPadraoProduto ; // forms

type
  TFrmListarProdutos = class(TFrmModelo)
    FdPesquisar: TFDMemTable;
    FdPesquisarproduto: TIntegerField;
    FdPesquisarcodigo: TStringField;
    FdPesquisardescricao: TStringField;
    FdPesquisarpreco_venda: TFloatField;
    procedure SBInvokeSearch(Sender: TObject);
    procedure SpbInlcuirClick(Sender: TObject);
    procedure SpbvoltarClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure dbgridConsultaDblClick(Sender: TObject);
    procedure dbgridConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
  private
    { Private declarations }
    tFormCad:TFormCadPadraoProduto;
    procedure ExecConsulta;

    procedure pesquisar; override;
    Procedure Consulta_alterar ; override;
    procedure Alterar;

  public
    { Public declarations }

  end;

var
  FrmListarProdutos: TFrmListarProdutos;

implementation

{$R *.dfm}






{ TFrmListarProdutos }

procedure TFrmListarProdutos.Alterar;
begin
  if FdPesquisar.recordcount>0 then
  begin

    PGCtrlModelo.activepage:=TabSheetManu;
    tFormCad:= TFormCadPadraoProduto.Create(nil);
    tFormCad.TypeOperacaoDML:= Upd ;

    if tFormCad.Consulta_alterar( FdPesquisar.fieldbyname('produto').value ) then
    begin
      tFormCad.Parent:=TabSheetManu;
      tFormCad.Align:=alClient;
      tFormCad.Visible:=true;
    end
    else
    begin
      tFormCad.Free;
      ShowMessage('ocorreu erro na alteração do cadastro!');
    end;

  end;
end;

procedure TFrmListarProdutos.Consulta_alterar;
begin
  inherited;

end;

procedure TFrmListarProdutos.dbgridConsultaDblClick(Sender: TObject);
begin
  inherited;
  alterar;


end;

procedure TFrmListarProdutos.dbgridConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then  Alterar;
end;

procedure TFrmListarProdutos.ExecConsulta;
var
 sql:string;
begin
   sql:='select   produto, codigo, descricao, preco_venda from produtos order by codigo';

   FdPesquisar.close;
   FdPesquisar.open;
   FdPesquisar.loadfromjson( Dmbase.SQL_GET(sql ));

   if FdPesquisar.recordcount=0 then
        dbgridConsulta.Visible:=false
   else
   begin
      PreperListaFieldsFiltro;
      dbgridConsulta.Visible:=true;
   end;
end;

procedure TFrmListarProdutos.pesquisar;
begin
  inherited;
  ExecConsulta;
end;

procedure TFrmListarProdutos.SBInvokeSearch(Sender: TObject);
begin
  inherited;
  ExecConsulta;
end;

procedure TFrmListarProdutos.SpbInlcuirClick(Sender: TObject);
begin
  inherited;

  PGCtrlModelo.activepage:=TabSheetManu;
  tFormCad:= TFormCadPadraoProduto.Create(nil);

  tFormCad.TypeOperacaoDML:= Ins ;

  tFormCad.Parent:=TabSheetManu;
  tFormCad.Align:=alClient;
  tFormCad.Visible:=true;

end;

procedure TFrmListarProdutos.SpbvoltarClick(Sender: TObject);
begin
  inherited;
  PGCtrlModelo.activepage:=TabSheetConsultar;
  tFormCad.free;
  dbgridConsulta.setfocus;
end;

procedure TFrmListarProdutos.SpeedButton11Click(Sender: TObject);
begin
  inherited;
  if FdPesquisar.recordcount>0 then
    PGCtrlModelo.activepage:=TabSheetdelete;
end;

procedure TFrmListarProdutos.SpeedButton3Click(Sender: TObject);
var
 i:integer;
begin
  inherited;

  if tFormCad.FieldRequired then
  begin
    tFormCad.Salvar;
    if tFormCad.TypeOperacaoDML = Upd then
    begin
      PGCtrlModelo.activepage:=TabSheetConsultar;
      tFormCad.free;
      dbgridConsulta.setfocus;
    end;
    ExecConsulta;
  end;

end;

procedure TFrmListarProdutos.SpeedButton6Click(Sender: TObject);
var
 sqlLista:Tstringlist;
 Qtde_ped:integer;
begin
  try
     sqlLista:= Tstringlist.Create;

     Qtde_ped:= Dmbase.SQLCount('select  count(*) as qtde from produto_pedidov where produto='+FdPesquisar.fieldbyname('produto').asstring);

     if Qtde_ped>0 then
     begin
       ShowMessage('Este produto possui vinculo com pedido, e não poderá ser excluido!');
       Abort;
     end;

     if Application.MessageBox(pchar('Confirma a exclusão do cadastro?'),'Aviso',MB_YESNO+MB_ICONWARNING)=ID_YES then
     begin
       sqlLista.add('delete from produtos where produto='+  FdPesquisar.fieldbyname('produto').asstring ) ;
       if Dmbase.SQL_DELETE( sqlLista ) then
       begin
         ShowMessage('Comando executado com sucesso!');
         ExecConsulta;
         PGCtrlModelo.activepage:=TabSheetConsultar;
       end;
     end;
  finally
    FreeAndNil(sqlLista);
  end;

end;

end.
