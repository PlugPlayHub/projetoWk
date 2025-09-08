unit uFrmModelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ImgList, ToolWin, ComCtrls, Menus, StdCtrls, Buttons,
  Grids, DBGrids, ExtCtrls, DB, Datasnap.DBClient, Data.DBXDataSnap,
  IndyPeerImpl, Data.DBXCommon, Datasnap.DSConnect, Data.SqlExpr,
  System.SyncObjs, Vcl.DBCtrls, System.Math, MidasLib,
  Winapi.CommCtrl, System.ImageList, Vcl.CheckLst,
  Vcl.WinXCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys,
  FireDAC.Comp.Client,
  DataModule.Global;

type
  TFrmModelo = class(TForm)
    Ds: TDataSource;
    PGCtrlModelo: TPageControl;
    TabSheetConsultar: TTabSheet;
    TabSheetManu: TTabSheet;
    PanelPrincipal: TPanel;
    PanelGrid: TPanel;
    PanelBotoes: TPanel;
    Panelfiltros: TPanel;
    SPBLimparFiltro: TSpeedButton;
    SB: TSearchBox;
    LabelTotal: TLabel;
    PnIncluir: TPanel;
    SpbInlcuir: TSpeedButton;
    ID_Comercial_PlugPlay: TPanel;
    Panel22: TPanel;
    LabelCad: TLabel;
    dbgridConsulta: TDBGrid;
    PNexclur: TPanel;
    SpeedButton11: TSpeedButton;
    TabSheetdelete: TTabSheet;
    PanelTopExcluir: TPanel;
    BtnVoltarExcluir: TPanel;
    SpeedButton4: TSpeedButton;
    ButtonConfirmarExclusao: TPanel;
    SpeedButton6: TSpeedButton;
    Panel5: TPanel;
    PanelLeftModel: TPanel;
    Panel7: TPanel;
    PanelTop: TPanel;
    Panel1: TPanel;
    ButtonSalvar: TPanel;
    SpeedButton3: TSpeedButton;
    PnVoltar: TPanel;
    Spbvoltar: TSpeedButton;

    procedure EdtValorChange(Sender: TObject);
    procedure aplicafiltro;

    procedure SPBLimparFiltroClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SBChange(Sender: TObject);
    procedure dbgridConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);


  private
     { Private declarations }
     ListaColunas: TStringList;

  protected
      Dmbase : TDmbase;
      procedure PreperListaFieldsFiltro;

      // arredondar cantos
      procedure DrawControl(Control: TWinControl) ;


  public
     { Public declarations }
     procedure pesquisar; virtual; abstract;
     Procedure Consulta_alterar ; virtual; abstract;
  end;

var
  FrmModelo: TFrmModelo;

implementation




type TCDBGrid = class(TCustomDBGrid);

{$R *.dfm}


procedure TFrmModelo.EdtValorChange(Sender: TObject);
var
  i:Integer;
  strfilter:string;
begin

  if  (not TFDMemTable(ds.DataSet).IsEmpty) or (TFDMemTable(ds.DataSet).Filtered=true) then
  begin
    TFDMemTable(ds.DataSet).DisableControls;
    begin
       TFDMemTable(ds.DataSet).Filtered:=false;
       for I := 0 to ListaColunas.Count-1 do
       begin
          if I=0 then  strfilter:='( upper('+ ListaColunas.Strings[i]+') like  ('+ QuotedStr('%'+SB.Text+'%')+') )'
          else  strfilter:= strfilter+' or '+'( upper('+ListaColunas.Strings[i]+') like  ('+ QuotedStr('%'+SB.Text+'%')+') )' ;
       end;
       TFDMemTable(ds.DataSet).Filter:=strfilter;
       TFDMemTable(ds.DataSet).Filtered:=true;
       LabelTotal.Caption:='Registros: '+IntToStr(TFDMemTable(ds.DataSet).RecordCount);
    end;
    TFDMemTable(ds.DataSet).EnableControls;
    TFDMemTable(ds.DataSet).First;
  end;
end;


procedure TFrmModelo.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(ListaColunas);
  Dmbase.Free;
end;

procedure TFrmModelo.FormCreate(Sender: TObject);
begin
  PGCtrlModelo.OwnerDraw := false;
  TabSheetConsultar.TabVisible:=false;
  TabSheetManu.TabVisible:=false;
  TabSheetdelete.TabVisible:=false;
  PGCtrlModelo.ActivePage:=TabSheetConsultar;
  ListaColunas:=TStringList.Create;
  Dmbase := TDmbase.Create(nil);
end;




procedure TFrmModelo.FormShow(Sender: TObject);
begin
   DrawControl( PnIncluir );
   DrawControl( PNexclur );

   DrawControl( PnVoltar );
   DrawControl( ButtonSalvar );

   DrawControl( BtnVoltarExcluir );
   DrawControl( ButtonConfirmarExclusao );

end;

procedure TFrmModelo.PreperListaFieldsFiltro;
var
  i:integer;
begin
  ListaColunas.Clear;

  LabelTotal.Caption:='Registros: '+IntToStr(TFDMemTable(ds.DataSet).RecordCount);

  for I := 0 to TFDMemTable(ds.DataSet).FieldDefs.Count-1 do
  begin
     if TFDMemTable(ds.DataSet).FieldDefs.Items[i].DataType=ftString then
     begin
       ListaColunas.Add(TFDMemTable(ds.DataSet).FieldDefs.Items[i].Name) ;
     end;
  end;
end;

procedure TFrmModelo.aplicafiltro;
var
 filtrolocal:string;
begin
  if (not TFDMemTable(ds.DataSet).IsEmpty)
  then
  begin
     if (Length( trim(SB.Text))>0)
     then
     begin
         TFDMemTable(ds.DataSet).DisableControls;
         TFDMemTable(ds.DataSet).Filtered:=false;

         TFDMemTable(ds.DataSet).Filter:=filtrolocal;

         try
           TFDMemTable(ds.DataSet).Filtered:=true;
           TFDMemTable(ds.DataSet).EnableControls;
         except
           TFDMemTable(ds.DataSet).Filtered:=false;
           TFDMemTable(ds.DataSet).EnableControls;
         end;


     end;
  end;
end;



procedure TFrmModelo.dbgridConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;   DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if odd( dbgridConsulta.DataSource.DataSet.RecNo)  then
    dbgridConsulta.Canvas.Brush.Color:= $00E1DDD9
  else
    dbgridConsulta.Canvas.Brush.Color:=clWhite;

  // mudar cor da linha selecionada
  if (gdSelected in state) then
  begin
    DbgridConsulta.Canvas.Brush.Color:=$00CBC5BE;
    dbgridConsulta.Canvas.Font.Color:=clBlack;
  end;

  dbgridConsulta.Canvas.FillRect(Rect);
  dbgridConsulta.DefaultDrawColumnCell(Rect,DataCol,Column,State);

end;



procedure TFrmModelo.DrawControl(Control: TWinControl);
var
   R: TRect;
   Rgn: HRGN;
begin
    with Control do  begin
        R := ClientRect;
        rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 10, 10) ;
        Perform(EM_GETRECT, 0, lParam(@r)) ;
        InflateRect(r, - 4, - 4) ;
        Perform(EM_SETRECTNP, 0, lParam(@r)) ;
        SetWindowRgn(Handle, rgn, True) ;
        Invalidate;
    end;
end;

procedure TFrmModelo.SBChange(Sender: TObject);
var
  i:Integer;
  strfilter:string;
begin

  if  (not TFDMemTable(ds.DataSet).IsEmpty) or (TFDMemTable(ds.DataSet).Filtered=true) then
  begin
    TFDMemTable(ds.DataSet).DisableControls;
    begin
       TFDMemTable(ds.DataSet).Filtered:=false;

       for I := 0 to ListaColunas.Count-1 do
       begin
          if I=0 then  strfilter:='( upper('+ ListaColunas.Strings[i]+') like  ('+ QuotedStr('%'+SB.Text+'%')+') )'
          else  strfilter:= strfilter+' or '+'( upper('+ListaColunas.Strings[i]+') like  ('+ QuotedStr('%'+SB.Text+'%')+') )' ;
       end;

       TFDMemTable(ds.DataSet).Filter:=strfilter;

       TFDMemTable(ds.DataSet).Filtered:=true;

       LabelTotal.Caption:='Registros: '+IntToStr(TFDMemTable(ds.DataSet).RecordCount);

    end;
    TFDMemTable(ds.DataSet).EnableControls;
    TFDMemTable(ds.DataSet).First;

  end;

end;



procedure TFrmModelo.SPBLimparFiltroClick(Sender: TObject);
begin
  SB.Text:=EmptyStr;
  if (not TFDMemTable (ds.DataSet).IsEmpty)  then
  begin
    if TFDMemTable(ds.DataSet).Filtered then
    begin
      TFDMemTable(ds.DataSet).DisableControls;
      SB.Text:=EmptyStr;
      SB.NumbersOnly:=false;
      TFDMemTable(ds.DataSet).Filtered:=false;
      TFDMemTable(ds.DataSet).EnableControls;
    end;
  end;
end;




end.
