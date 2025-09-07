unit UFormAddProdutoPed;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  System.ImageList, Vcl.ImgList, Vcl.Buttons, Vcl.ExtCtrls,

  DataSet.Serialize,  DataModule.Global, Vcl.Mask, Vcl.DBCtrls;

type
  TFormAddProdutoPed = class(TForm)
    DsItemPed: TDataSource;
    DSProdutosAdd: TDataSource;
    Label1: TLabel;
    FDProdutosAdd: TFDMemTable;
    FDProdutosAddproduto: TIntegerField;
    FDProdutosAddcodigo: TStringField;
    FDProdutosAdddescricao: TStringField;
    FDProdutosAddqtde: TIntegerField;
    FDProdutosAddvalor_unit: TFloatField;
    FDProdutosAddvalor_total: TFloatField;
    Label_qtde: TLabel;
    Label_valor: TLabel;
    Label_total: TLabel;
    Edit1: TEdit;
    DBEdit_desc: TDBEdit;
    DBEdit_qtde: TDBEdit;
    DBEdit_valor_unit: TDBEdit;
    DBEdit_valor_total: TDBEdit;
    BtnAdd: TBitBtn;
    BtCancelarItem: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure dbgridprodutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgridprodutosKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit_qtdeKeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit_valor_unitKeyPress(Sender: TObject; var Key: Char);
    procedure BtCancelarItemClick(Sender: TObject);
  private
    { Private declarations }
    Dmbase : TDmbase;

    procedure BuscarProdutoDigitado;
    procedure Edicao_ativa ( ativo : Boolean);
    procedure additem;


  public
    { Public declarations }
  end;

var
  FormAddProdutoPed: TFormAddProdutoPed;

implementation

{$R *.dfm}

procedure TFormAddProdutoPed.Edicao_ativa( ativo : Boolean );
begin
  if ativo then
  begin
     Edit1.Enabled:=false;
     DBEdit_desc.Enabled:=true;
     DBEdit_qtde.Enabled:=true;
     DBEdit_valor_unit.Enabled:=true;
     DBEdit_valor_total.Enabled:=true;
     BtnAdd.Enabled:=true;
     DBEdit_qtde.SetFocus;
     BtCancelarItem.Enabled:=true;
  end
  else
  begin
     DBEdit_desc.Enabled:=false;
     DBEdit_qtde.Enabled:=false;
     DBEdit_valor_unit.Enabled:=false;
     DBEdit_valor_total.Enabled:=false;
     BtnAdd.Enabled:=false;
     BtCancelarItem.Enabled:=false;

     Edit1.Text:=EmptyStr;
     Edit1.Enabled:=true;
     Edit1.SetFocus;
  end;
end;

procedure TFormAddProdutoPed.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    BuscarProdutoDigitado;

end;

procedure TFormAddProdutoPed.additem;
begin
  TFDMemTable(DSProdutosAdd.dataset).Edit;
  TFDMemTable(DSProdutosAdd.dataset).Post;

  TFDMemTable(DSProdutosAdd.dataset).DisableControls;
  TFDMemTable(DSProdutosAdd.dataset).First;
  while not TFDMemTable(DSProdutosAdd.dataset).eof do
  begin
     if  ( TFDMemTable(DSProdutosAdd.dataset).FieldByName('qtde').Value>0 ) and
          ( TFDMemTable(DSProdutosAdd.dataset).FieldByName('valor_unit').Value>0 )
     then
     begin
       TFDMemTable(DsItemPed.dataset).Edit;
       TFDMemTable(DsItemPed.dataset).Append;

       TFDMemTable(DsItemPed.dataset).FieldByName('produto').Value:=      TFDMemTable(DSProdutosAdd.dataset).FieldByName('produto').Value;
       TFDMemTable(DsItemPed.dataset).FieldByName('qtde').Value:=         TFDMemTable(DSProdutosAdd.dataset).FieldByName('qtde').Value;
       TFDMemTable(DsItemPed.dataset).FieldByName('valor_unit').Value:=   TFDMemTable(DSProdutosAdd.dataset).FieldByName('valor_unit').Value;
       TFDMemTable(DsItemPed.dataset).FieldByName('valor_total').Value:=  TFDMemTable(DSProdutosAdd.dataset).FieldByName('valor_total').Value;
       TFDMemTable(DsItemPed.dataset).FieldByName('codigo').Value:=       TFDMemTable(DSProdutosAdd.dataset).FieldByName('codigo').Value;
       TFDMemTable(DsItemPed.dataset).FieldByName('descricao').Value:=    TFDMemTable(DSProdutosAdd.dataset).FieldByName('descricao').Value;

       TFDMemTable(DsItemPed.dataset).post;
     end;

     TFDMemTable(DSProdutosAdd.dataset).Next
  end;

  TFDMemTable(DSProdutosAdd.dataset).EnableControls;

  Edit1.Text:=EmptyStr;
  Edicao_ativa(false);
end;

procedure TFormAddProdutoPed.BtCancelarItemClick(Sender: TObject);
begin
  Edit1.Text:=EmptyStr;
  Edicao_ativa(false);
end;

procedure TFormAddProdutoPed.BtnAddClick(Sender: TObject);
begin
  if ( FDProdutosAdd.fieldbyname('qtde').value >0 ) and
     ( FDProdutosAdd.fieldbyname('valor_unit').value >0 )
  then
  begin
    additem;
  end
  else
  begin
    if ( FDProdutosAdd.fieldbyname('qtde').value = 0 ) then
       ShowMessage('Precisa informar uma quantidade válida!')
    else
      ShowMessage('Precisa informar um valor válido!')
  end;

end;

procedure TFormAddProdutoPed.BuscarProdutoDigitado;
var
  sql:string;
begin

  sql:=' select p.produto, p.codigo, p.descricao , 1 as qtde, p.preco_venda  as valor_unit, p.preco_venda as valor_total '+
       ' from produtos p'+
       ' where p.codigo='+QuotedStr( Edit1.Text ) ;

  FDProdutosAdd.Close;
  FDProdutosAdd.Open;
  FDProdutosAdd.LoadFromJSON( Dmbase.SQL_GET( sql ) );

  if FDProdutosAdd.RecordCount>0 then
     Edicao_ativa(true)
  else
    ShowMessage('Não localizado produtos na base de dados');

end;

procedure TFormAddProdutoPed.DBEdit_qtdeKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key = #13 then
    begin
       FDProdutosAdd.Edit;
       FDProdutosAdd.post;
       if FDProdutosAdd.FieldByName('qtde').Value >0 then
       begin
         FDProdutosAdd.Edit;
         FDProdutosAdd.FieldByName('valor_total').Value:=
                   FDProdutosAdd.FieldByName('valor_unit').Value *
                   FDProdutosAdd.FieldByName('qtde').Value;
         FDProdutosAdd.Post;
         DBEdit_valor_unit.SetFocus;
       end
       else
         ShowMessage('Qtde deve ser um valor válido!')

    end;
end;

procedure TFormAddProdutoPed.DBEdit_valor_unitKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key = #13 then
    begin
       FDProdutosAdd.Edit;
       FDProdutosAdd.post;
       if FDProdutosAdd.FieldByName('valor_unit').Value >0 then
       begin
         FDProdutosAdd.Edit;
         FDProdutosAdd.FieldByName('valor_total').Value:=
                   FDProdutosAdd.FieldByName('valor_unit').Value *
                   FDProdutosAdd.FieldByName('qtde').Value;
         FDProdutosAdd.Post;
         BtnAdd.SetFocus;
       end
       else
         ShowMessage('Valor unit deve ser um valor válido!')

    end;
end;

procedure TFormAddProdutoPed.dbgridprodutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // Bloqueia tecla Insert
  if Key = VK_INSERT then
    Key := 0;

  // Bloqueia seta ↓ quando está na última linha
  if (Key = VK_DOWN) and (TFDMemTable(DSProdutosAdd.DataSet).RecNo = TFDMemTable(DSProdutosAdd.DataSet).RecordCount) then
    Key := 0;

end;

procedure TFormAddProdutoPed.dbgridprodutosKeyPress(Sender: TObject;
  var Key: Char);
begin
   if Key = #13 then
  begin
     TFDMemTable(DSProdutosAdd.dataset).Edit;
     TFDMemTable(DSProdutosAdd.dataset).FieldByName('valor_total').Value:=
                 TFDMemTable(DSProdutosAdd.dataset).FieldByName('valor_unit').Value *
                 TFDMemTable(DSProdutosAdd.dataset).FieldByName('qtde').Value;
     TFDMemTable(DSProdutosAdd.dataset).Post;

  end;
end;

procedure TFormAddProdutoPed.FormCreate(Sender: TObject);
var
  i:integer;
  Tam_fonte:integer;
  Name_Fonte:string;
  Cor_Padrao_Label, Cor_Padrao_Fundo : TColor;
begin

    FDProdutosAdd.CreateDataSet;
    Dmbase := TDmbase.create(nil);

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
    end;

end;




procedure TFormAddProdutoPed.FormDestroy(Sender: TObject);
begin
  Dmbase.Free;
end;

end.
