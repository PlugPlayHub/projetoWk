unit UFormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.ExtCtrls,

  System.TypInfo, Vcl.Imaging.pngimage  ;

type
  TtipoCadastro = ( Cliente, Pedido, Produto);

  TFormPrincipal = class(TForm)
    PanelCentral: TPanel;
    PanelTopBTN: TPanel;
    Label11: TLabel;
    Labelmenu: TLabel;
    SpbPedido: TSpeedButton;
    SpbProdutos: TSpeedButton;
    SPBClient: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Image1: TImage;
    Panel2: TPanel;
    PageControlPrincipal: TPageControl;
    Panel1: TPanel;
    PanelRigth: TPanel;
    Panel3: TPanel;

    procedure FormCreate(Sender: TObject);
    procedure SpbPedidoClick(Sender: TObject);
    procedure SPBClientClick(Sender: TObject);
    procedure SpbProdutosClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);

  private
    { Private declarations }
    ListTabShet :tlist ;
    ListaFormprincipal:TStringList;

    // variaveis tab
    xTab, xtag:Integer;

    function  Criartab(nome: string): TTabSheet;

    procedure localizarTabShet(TipoCad: TtipoCadastro);

    Procedure CriarLTelaConsulta( vtabReceb : TTabSheet; TipoCad: TtipoCadastro);

  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

uses UFrmListarClientes, uFrmModelo, UFrmListarPedidos, UFrmListarProdutos,
  UFormConfig;

{ TFormPrincipal }

procedure TFormPrincipal.CriarLTelaConsulta( vtabReceb : TTabSheet; TipoCad: TtipoCadastro);
var
   x:integer;
   Tela_Pedido:Boolean;
begin

    x:=vtabReceb.TabIndex;

    case TipoCad of
         Cliente: x := ListaFormprincipal.AddObject('Frm',TFrmListarClientes.Create(nil));
         Produto: x := ListaFormprincipal.AddObject('Frm',TFrmListarProdutos.Create(nil));
         Pedido: begin
            x := ListaFormprincipal.AddObject('Frm',TFrmListarPedidos.Create(nil));
            Tela_Pedido:=True;
         end;
    end;

    PageControlPrincipal.ActivePage:=vtabReceb;

    TFrmModelo(ListaFormprincipal.Objects[x] ).Parent:= vtabReceb;
    TFrmModelo(ListaFormprincipal.Objects[x] ).Align:= alClient;

    // propriedades
    TFrmModelo(ListaFormprincipal.Objects[x] ).Tag:= vtabReceb.Tag;
    TFrmModelo(ListaFormprincipal.Objects[x] ).Name:=vtabReceb.name;
    TFrmModelo(ListaFormprincipal.Objects[x] ).caption:= vtabReceb.name;
    TFrmModelo(ListaFormprincipal.Objects[x] ).LabelCad.caption:=   'CADASTRO DE '+vtabReceb.name;
    TFrmModelo(ListaFormprincipal.Objects[x] ).Visible:=true;

    // ativar pesquisa automática
    TFrmModelo(ListaFormprincipal.Objects[x] ).pesquisar;
    TFrmModelo(ListaFormprincipal.Objects[x] ).Show;



end;

function TFormPrincipal.Criartab(nome: string): TTabSheet;
var
    vtab   :  TTabSheet;
    tamanho :Integer;
begin
    tamanho:=Length(nome)*25;
    vtab := TTabSheet.Create(PageControlPrincipal);
    vtab.Visible:=false;
    vtab.PageControl := PageControlPrincipal;
    vtab.Align:=alClient;
    vtab.Name :=UpperCase( nome );
    vtab.Caption:=nome;
    vtab.Font.Color:=clNavy;
    PageControlPrincipal.ActivePage:=vtab;
    vtab.TabVisible:=false;
    vtab.Visible:=true;
    vtab.TabStop:=False;

    vtab.PageIndex:=xTab;
    vtab.Tag:=xtag;

    ListTabShet.Add(vtab);
    xTab:=ListTabShet.Count;
    Inc( xtag);
    Result:=vtab;
end;

procedure TFormPrincipal.localizarTabShet(TipoCad: TtipoCadastro);
var
 i:integer;
 janelaPrincipalexiste:Boolean;
 vtabReceb   :  TTabSheet;
 NameTipoCad:string;
begin

   PageControlPrincipal.Visible:=true;

   NameTipoCad := GetEnumName( TypeInfo( TtipoCadastro ), Ord( TipoCad )); // pega o nome do type

   janelaPrincipalexiste:=false;
   for I := 0 to ListTabShet.Count-1 do
   begin
     vtabReceb:=ListTabShet.Items[i];

     if UpperCase( vtabReceb.Name) =UpperCase( NameTipoCad ) then
     begin
        janelaPrincipalexiste:=True;
        PageControlPrincipal.ActivePage:=vtabReceb;

        Break;
     end;
   end;

   if janelaPrincipalexiste=false then
   begin
      vtabReceb:=Criartab(NameTipoCad );
      CriarLTelaConsulta( vtabReceb, TipoCad);
   end;

end;

procedure TFormPrincipal.SpbPedidoClick(Sender: TObject);
begin
  localizarTabShet(Pedido);
end;

procedure TFormPrincipal.SpbProdutosClick(Sender: TObject);
begin
  localizarTabShet(Produto);
end;

procedure TFormPrincipal.SpeedButton1Click(Sender: TObject);
var
  t:TFormConfig;
begin
  try
    t:= TFormConfig.Create(nil);
    t.showmodal;
  finally
    FreeAndNil( t );
  end;
end;

procedure TFormPrincipal.SPBClientClick(Sender: TObject);
begin
  localizarTabShet(Cliente);
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  ListTabShet        := tlist.Create ;
  ListaFormprincipal := TStringList.Create;
end;

end.
