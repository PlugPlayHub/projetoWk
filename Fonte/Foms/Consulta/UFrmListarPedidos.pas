unit UFrmListarPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmModelo, Data.DB, Vcl.StdCtrls,
  Vcl.WinXCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  DataModule.Global, DataSet.Serialize, // função

  UFormCadPadraoPedido, UFormCadPadrao  ; // forms


type
  TFrmListarPedidos = class(TFrmModelo)
    FdPesquisar: TFDMemTable;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    tFormCad:TFormCadPadraoPedido;
  public
    { Public declarations }
    procedure pesquisar; override;
    Procedure Consulta_alterar ; override;

  end;

var
  FrmListarPedidos: TFrmListarPedidos;

implementation

{$R *.dfm}

{ TFrmListarPedidos }

procedure TFrmListarPedidos.Consulta_alterar;
begin
  inherited;

end;

procedure TFrmListarPedidos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   Dmbase.Free;
end;

procedure TFrmListarPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  Dmbase := TDmbase.Create(nil);
end;

procedure TFrmListarPedidos.FormShow(Sender: TObject);
begin
  inherited;
    PGCtrlModelo.activepage:=TabSheetManu;
    tFormCad:= TFormCadPadraoPedido.Create(nil);
    tFormCad.Parent:=TabSheetManu;
    tFormCad.Align:=alClient;
    tFormCad.Visible:=true;

end;

procedure TFrmListarPedidos.pesquisar;
begin
  //inherited;
  //
end;

end.
