unit UFormEditarItemPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls,
  Vcl.Buttons;

type
  TFormEditarItemPedido = class(TForm)
    DsEditarItem: TDataSource;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label_qtde: TLabel;
    Label_valor: TLabel;
    Label_total: TLabel;
    FDProdutosAdd: TFDMemTable;
    FDProdutosAddproduto: TIntegerField;
    FDProdutosAddcodigo: TStringField;
    FDProdutosAdddescricao: TStringField;
    FDProdutosAddqtde: TIntegerField;
    FDProdutosAddvalor_unit: TFloatField;
    FDProdutosAddvalor_total: TFloatField;
    DBEdit_qtde: TDBEdit;
    DBEdit_valor_unit: TDBEdit;
    DBEdit_valor_total: TDBEdit;
    BtnAdd: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure DBEdit_qtdeKeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit_valor_unitKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEditarItemPedido: TFormEditarItemPedido;

implementation

{$R *.dfm}

procedure TFormEditarItemPedido.BtnAddClick(Sender: TObject);
begin
   if (TFDMemTable(DsEditarItem.dataset).FieldByName('qtde').Value >0) and
      (TFDMemTable(DsEditarItem.dataset).FieldByName('valor_unit').Value >0)
   then
   begin
     TFDMemTable(DsEditarItem.dataset).Edit;
     TFDMemTable(DsEditarItem.dataset).Post;
     Close;
   end
   else
   begin
     ShowMessage('Deve ser informado o valores válidos em: qtde e valor unit!')
   end;

end;

procedure TFormEditarItemPedido.DBEdit_qtdeKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key = #13 then
    begin
       TFDMemTable(DsEditarItem.dataset).Edit;
       TFDMemTable(DsEditarItem.dataset).post;
       if TFDMemTable(DsEditarItem.dataset).FieldByName('qtde').Value >0 then
       begin
         TFDMemTable(DsEditarItem.dataset).Edit;
         TFDMemTable(DsEditarItem.dataset).FieldByName('valor_total').Value:=
                   TFDMemTable(DsEditarItem.dataset).FieldByName('valor_unit').Value *
                   TFDMemTable(DsEditarItem.dataset).FieldByName('qtde').Value;
         TFDMemTable(DsEditarItem.dataset).Post;
         DBEdit_valor_unit.SetFocus;
       end
       else
         ShowMessage('Qtde deve ser um valor válido!')

    end;
end;

procedure TFormEditarItemPedido.DBEdit_valor_unitKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key = #13 then
    begin
       TFDMemTable(DsEditarItem.dataset).Edit;
       TFDMemTable(DsEditarItem.dataset).post;
       if TFDMemTable(DsEditarItem.dataset).FieldByName('valor_unit').Value >0 then
       begin
         TFDMemTable(DsEditarItem.dataset).Edit;
         TFDMemTable(DsEditarItem.dataset).FieldByName('valor_total').Value:=
                   TFDMemTable(DsEditarItem.dataset).FieldByName('valor_unit').Value *
                   TFDMemTable(DsEditarItem.dataset).FieldByName('qtde').Value;
         TFDMemTable(DsEditarItem.dataset).Post;
         BtnAdd.SetFocus;
       end
       else
         ShowMessage('Valor unit deve ser um valor válido!')

    end;
end;

procedure TFormEditarItemPedido.FormCreate(Sender: TObject);
var
  i:integer;
  Tam_fonte:integer;
  Name_Fonte:string;
  Cor_Padrao_Label, Cor_Padrao_Fundo : TColor;
begin

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

end.
