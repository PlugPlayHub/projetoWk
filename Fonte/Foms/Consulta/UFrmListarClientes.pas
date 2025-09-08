unit UFrmListarClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmModelo, Data.DB, System.ImageList,
  Vcl.ImgList, Datasnap.DBClient, Vcl.StdCtrls, Vcl.WinXCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, Vcl.ExtCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Phys,

  DataModule.Global, DataSet.Serialize, // função

  UFormCadPadraoCliente  ; // forms


type
  TFrmListarClientes = class(TFrmModelo)
    FdPesquisar: TFDMemTable;
    FdPesquisarcliente: TIntegerField;
    FdPesquisarnome: TStringField;
    FdPesquisarcidade: TStringField;
    FdPesquisarvalor_entregar: TFloatField;
    FdPesquisarqtde_entregar: TIntegerField;
    procedure SpbInlcuirClick(Sender: TObject);
    procedure SpbvoltarClick(Sender: TObject);
    procedure SBInvokeSearch(Sender: TObject);
    procedure dbgridConsultaDblClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure dbgridConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
    tFormCad:TFormCadPadraoCliente;

    procedure ExecConsulta;
    procedure Alterar;


  public
    { Public declarations }
    procedure pesquisar; override;
    Procedure Consulta_alterar ; override;
  end;

var
  FrmListarClientes: TFrmListarClientes;

implementation

{$R *.dfm}



{ TFrmListarClientes }

procedure TFrmListarClientes.Alterar;
begin
  if FdPesquisar.recordcount>0 then
  begin
    PGCtrlModelo.activepage:=TabSheetManu;
    tFormCad:= TFormCadPadraoCliente.Create(nil);
    tFormCad.TypeOperacaoDML:= Upd ;

    if tFormCad.Consulta_alterar( FdPesquisar.fieldbyname('cliente').value ) then
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

procedure TFrmListarClientes.Consulta_alterar;
begin
  inherited;

end;

procedure TFrmListarClientes.dbgridConsultaDblClick(Sender: TObject);
begin
  inherited;
  Alterar;
end;

procedure TFrmListarClientes.dbgridConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then  Alterar;

end;

procedure TFrmListarClientes.ExecConsulta;
var
 sql:string;
 msgErro:string;
begin
   sql:=' select cl.cliente , cl.nome,  CONCAT( cl.cidade, " - ", uf ) as Logradouro,'+
        '  ( select coalesce( pv.valor_total, 0) from pedido_venda pv where pv.cliente=cl.cliente)   as valor_entregar,  '+
        ' sum( coalesce( ppv.qtde, 0)) as qtde_entregar ' +
        '  from clientes cl'+
        '   left join pedido_venda pv on pv.cliente=cl.cliente'+
        '   left join produto_pedidov ppv on ppv.pedidov=pv.pedidov '+
        ' group by cl.cliente , cl.nome,  cl.cidade, uf ';
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


procedure TFrmListarClientes.pesquisar;
begin
  inherited;
  ExecConsulta;
end;

procedure TFrmListarClientes.SBInvokeSearch(Sender: TObject);
begin
  inherited;
  ExecConsulta;
end;

procedure TFrmListarClientes.SpbInlcuirClick(Sender: TObject);
begin
  inherited;
  PGCtrlModelo.activepage:=TabSheetManu;
  tFormCad:= TFormCadPadraoCliente.Create(nil);
  tFormCad.TypeOperacaoDML:=Ins;
  tFormCad.Parent:=TabSheetManu;
  tFormCad.Align:=alClient;
  tFormCad.Visible:=true;
end;

procedure TFrmListarClientes.SpbvoltarClick(Sender: TObject);
begin
  inherited;
  PGCtrlModelo.activepage:=TabSheetConsultar;
  tFormCad.free;
  dbgridConsulta.setfocus;
end;

procedure TFrmListarClientes.SpeedButton11Click(Sender: TObject);
begin
  inherited;

  if FdPesquisar.recordcount>0 then
    PGCtrlModelo.activepage:=TabSheetdelete;

end;

procedure TFrmListarClientes.SpeedButton3Click(Sender: TObject);
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

procedure TFrmListarClientes.SpeedButton4Click(Sender: TObject);
begin
  inherited;
  PGCtrlModelo.activepage:=TabSheetConsultar;
end;

procedure TFrmListarClientes.SpeedButton6Click(Sender: TObject);
var
 sqlLista:Tstringlist;
 Qtde_ped:integer;

begin
  try
     sqlLista:= Tstringlist.Create;

     Qtde_ped:= Dmbase.SQLCount('select count(*) as qtde from pedido_venda where cliente='+FdPesquisar.fieldbyname('cliente').asstring);

     if Qtde_ped>0 then
     begin
       ShowMessage('Este cliente possui vinculo com pedido, e não poderá ser excluido!');
       Abort;
     end;

     if Application.MessageBox(pchar('Confirma a exclusão do cadastro?'),'Aviso',MB_YESNO+MB_ICONWARNING)=ID_YES then
     begin
       sqlLista.add('delete from clientes where cliente='+  FdPesquisar.fieldbyname('cliente').asstring ) ;
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
