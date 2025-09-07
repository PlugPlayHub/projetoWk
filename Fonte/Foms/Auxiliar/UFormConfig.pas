unit UFormConfig;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Datasnap.DBClient, Data.DBXDBReaders,Data.DBXCommon,Data.DBXCDSReaders,
  MidasLib, Vcl.ComCtrls,  Vcl.Menus, Vcl.DBCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  UntINIfileManager, FireDAC.Phys.MySQLDef, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.VCLUI.Wait;

type
  TFormConfig = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ButtonSalvar: TPanel;
    SPBSalvar: TSpeedButton;
    SpeedButton3: TSpeedButton;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    DBMySQL: TFDConnection;
    PnTestarConection: TPanel;
    SpeedButton1: TSpeedButton;
    EdtBaseDados: TEdit;
    EDTSERVER: TEdit;
    EDTPORTA: TEdit;
    EDTUSER: TEdit;
    EDTPASS: TEdit;
    EdtBibliotecadll: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SPBSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    // arredondar cantos
    procedure DrawControl(Control: TWinControl) ;
  public
    { Public declarations }
  end;

var
  FormConfig: TFormConfig;

implementation

{$R *.dfm}

procedure TFormConfig.DrawControl(Control: TWinControl);
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

procedure TFormConfig.FormCreate(Sender: TObject);
var
  Tdate:TDateTimePicker;
  i:integer;
  Tam_fonte:integer;
  Name_Fonte:string;
  Cor_Padrao_Label, Cor_Padrao_Fundo : TColor;
begin

    EDtBaseDados.Text  := ReadParametro(tpString, 'DataBase', 'Databasename','' );
    EDtSERVER.Text     := ReadParametro(tpString, 'DataBase', 'Server','' );
    EDtPORTA.Text      := ReadParametro(tpString, 'DataBase', 'Porta','' );
    EDtUSER.Text       := ReadParametro(tpString, 'DataBase', 'User','' );
    EDtPASS.Text       := ReadParametro(tpString, 'DataBase', 'Pass','' );
    EDtBibliotecadll.Text := ReadParametro(tpString, 'DataBase', 'BibliotecaDll','' );

    Cor_Padrao_Label   := clBlack;
    Cor_Padrao_Fundo  :=  clwhite;
    Tam_fonte:=9;

    Name_Fonte:= 'Segoe UI';
    for i := 0 to ComponentCount - 1 do
    begin
      if Components[i] is TLabel then
      begin
        TLabel(Components[i]).StyleElements:=[];

        TLabel(Components[i]).Font.Color:= Cor_Padrao_Label;

        TLabel(Components[i]).Font.Name:=Name_Fonte;
        TLabel(Components[i]).Font.Size:=Tam_fonte;
        //TLabel(Components[i]).Caption := UpperCase(TLabel(Components[i]).Caption);
      end;

      if Components[i] is TEdit then
      begin
        TEdit(Components[i]).StyleElements:=[];
        TEdit(Components[i]).Color:=Cor_Padrao_fundo;
        TEdit(Components[i]).Font.Name:=Name_Fonte;
        TEdit(Components[i]).Font.Size:=Tam_fonte;
        TEdit(Components[i]).Height:=30;

        TEdit(Components[i]).BevelInner:=bvLowered;
        TEdit(Components[i]).BevelKind:=bkFlat;
        TEdit(Components[i]).BevelOuter:=bvSpace;
        TEdit(Components[i]).BevelWidth:=2;

        TEdit(Components[i]).BorderStyle:=bsNone;
      end;

      if Components[i] is TDateTimePicker then
      begin
        Tmemo(Components[i]).StyleElements:=[];
        Tmemo(Components[i]).Color:=Cor_Padrao_fundo;
        Tmemo(Components[i]).Font.Name:=Name_Fonte;
        Tmemo(Components[i]).Font.Size:=Tam_fonte;

      end;


    end;
end;

procedure TFormConfig.FormShow(Sender: TObject);
begin
  DrawControl( PnTestarConection );
  DrawControl( ButtonSalvar );
end;

procedure TFormConfig.SPBSalvarClick(Sender: TObject);
begin
    if ( trim( edtBaseDados.Text ) = EmptyStr ) or
       ( trim( Edtserver.Text ) = EmptyStr ) or
       ( trim( EdtPorta.Text ) = EmptyStr ) or
       ( trim( EdtUSER.Text ) = EmptyStr ) or
       ( trim( EdtPASS.Text ) = EmptyStr )
    then
    begin
       ShowMessage('Precisa informar os parametros: Databasename, Porta, IP do server, Username e Password' );
       exit;
    end;


    WriteParametro('DataBase', 'Databasename', Trim( EDtBaseDados.Text ));
    WriteParametro('DataBase', 'Server', Trim( EDtSERVER.Text ));
    WriteParametro('DataBase', 'Porta', Trim( EDtPORTA.Text ));
    WriteParametro('DataBase', 'User', Trim( EDtUSER.Text ));
    WriteParametro('DataBase', 'Pass', Trim( EDtPASS.Text ));
    WriteParametro('DataBase', 'BibliotecaDll', Trim( EDtBibliotecadll.Text ));

    close;
end;

procedure TFormConfig.SpeedButton1Click(Sender: TObject);
var
   dir:string;
begin
  try
    if ( edtBaseDados.Text = EmptyStr ) or
       ( Edtserver.Text = EmptyStr ) or
       ( EdtPorta.Text = EmptyStr ) or
       ( EdtUSER.Text = EmptyStr ) or
       ( EdtPASS.Text = EmptyStr )
    then
    begin
       ShowMessage('Precisa informar os parametros: Databasename, Porta, IP do server, Username e Password' );
       exit;
    end;


    DBMySQL.DriverName := 'MySQL';

    with DBMySQL.Params do
    begin
      Clear;
      Add('DriverID=MySQL');
      Add('Server='     + Edtserver.Text);
      Add('Port='       + EdtPorta.Text);
      Add('Database='   + edtBaseDados.Text);
      Add('User_Name='  + EdtUSER.Text );
      Add('Password='   + EdtPASS.Text);
    end;

    dir:=ExtractFilePath(ParamStr(0));

    if EdtBibliotecadll.text=EmptyStr then
    begin
       if FileExists(dir+'libmysql.dll') then
          FDPhysMySQLDriverLink1.VendorLib := dir+'libmysql.dll'
       else
         ShowMessage('Atenção: precisa disponibilizar a libmysql.dll na pasta do sistema, ou informar o diretório!' );
    end
    else
        FDPhysMySQLDriverLink1.VendorLib := EdtBibliotecadll.text;

    FDPhysMySQLDriverLink1.DriverID := 'MySQL';
    DBMySQL.Connected := True;

    if DBMySQL.Connected then
      ShowMessage('Banco de dados conectado com sucesso!');

    DBMySQL.Connected:=False;

  except
    on E: Exception do
    begin
      ShowMessage('Não foi possivel conectar ao banco de dados!' +#13 +#13 +e.Message)
    end;
  end;

end;

end.
