unit UFormCadPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Datasnap.DBClient, Data.DBXDBReaders,Data.DBXCommon,Data.DBXCDSReaders,
  MidasLib, Vcl.ComCtrls,  Vcl.Menus, Vcl.DBCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  DataModule.Global;


type

  TFormCadPadrao = class(TForm)
    FDMemTablePadrao: TFDMemTable;
    DataSourcePadrao: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  Protected
    Dmbase : TDmbase;

    // arredondar cantos
    procedure DrawControl(Control: TWinControl) ;

  private
    { Private declarations }
    Cor_destaque , Cor_Padrao_Label, Cor_Padrao_Fundo, Cor_memo_Fundo :TColor ;

    // localizar field automático
    function GetControlByField(AFieldName: string): TWinControl;
  public
    { Public declarations }
    Function FieldRequired:Boolean;

    Function Salvar:Boolean ; virtual; abstract;
    Function Consulta_alterar(id_pk:integer):Boolean ; virtual; abstract;


  end;


implementation

{$R *.dfm}

procedure TFormCadPadrao.DrawControl(Control: TWinControl);
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

function TFormCadPadrao.FieldRequired: Boolean;
var
 x :integer;
 Campo, apelido:string;
 Tdbed:TDBEdit;
 ctrl: TWinControl;
begin

   Result:=true;
   FDMemTablePadrao.CheckBrowseMode;

   for x := 0 to FDMemTablePadrao.FieldDefs.Count-1 do
   begin
       if FDMemTablePadrao.FieldDefs.Items[x].Required then
       begin
         apelido:=UpperCase(FDMemTablePadrao.FieldDefs.Items[x].DisplayName);
         Campo:=FDMemTablePadrao.FieldDefs.Items[x].Name;

         if FDMemTablePadrao.FieldDefs.Items[x].DataType=ftString then
         begin
           if  Length ( trim( FDMemTablePadrao.FieldByName(campo).AsString) ) = 0
           then
           begin
              ShowMessage('Campo '+QuotedStr( apelido )+' precisa ter um valor!');
              ctrl := GetControlByField(Campo);
              if Assigned(ctrl) then ctrl.SetFocus;
              Result:=false;
              exit;
           end;
         end
         else
         begin
           if ( FDMemTablePadrao.FieldDefs.Items[x].DataType=ftInteger ) or
              ( FDMemTablePadrao.FieldDefs.Items[x].DataType=ftFloat )
           then
           begin
             if  Length ( FDMemTablePadrao.FieldByName(campo).AsString) > 0
             then
             begin
                if ( FDMemTablePadrao.FieldByName(campo).Value <= 0 )
                then
                begin
                  ShowMessage('Campo '+QuotedStr( apelido )+' precisa ter um valor!');
                  ctrl := GetControlByField(Campo);
                  if Assigned(ctrl) then ctrl.SetFocus;
                  Result:=false;
                  exit;
                end;
             end
             else
             begin
                ShowMessage('Campo '+QuotedStr( apelido )+' precisa ter um valor!');
                ctrl := GetControlByField(Campo);
                if Assigned(ctrl) then ctrl.SetFocus;
                Result:=false;
                exit;
             end;
           end;
         end;
       end;
   end;
end;

procedure TFormCadPadrao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dmbase.Free;
end;

procedure TFormCadPadrao.FormCreate(Sender: TObject);
var
  Tdate:TDateTimePicker;
  i:integer;
  Tam_fonte:integer;
  Name_Fonte:string;
begin
    FDMemTablePadrao.CreateDataSet;
    Dmbase := TDmbase.Create(nil);

    Cor_destaque := clMaroon;
    Cor_Padrao_Label   := clBlack;
    Cor_Padrao_Fundo  := clwhite;
    Cor_memo_Fundo :=  clwhite;
    Tam_fonte:=9;

    Name_Fonte:= 'Segoe UI';
    for i := 0 to ComponentCount - 1 do
    begin
      if Components[i] is TLabel then
      begin
        TLabel(Components[i]).StyleElements:=[];

        if (TLabel(Components[i]).Font.Color <> Cor_destaque )
        then
           TLabel(Components[i]).Font.Color:= Cor_Padrao_Label;

        TLabel(Components[i]).Font.Name:=Name_Fonte;
        TLabel(Components[i]).Font.Size:=Tam_fonte;
        //TLabel(Components[i]).Caption := UpperCase(TLabel(Components[i]).Caption);

      end;

      if Components[i] is Tmemo then
      begin
        Tmemo(Components[i]).StyleElements:=[];
        Tmemo(Components[i]).Color:= Cor_memo_Fundo;
        Tmemo(Components[i]).Font.Name:= Name_Fonte;
        Tmemo(Components[i]).Font.Size:= Tam_fonte;
      end;

      if Components[i] is TDBmemo then
      begin
        TDBmemo(Components[i]).StyleElements:=[];
        TDBmemo(Components[i]).Color:=Cor_memo_Fundo;
        TDBmemo(Components[i]).Font.Name:=Name_Fonte;
        TDBmemo(Components[i]).Font.Size:=Tam_fonte;
      end;

      if Components[i] is TDateTimePicker then
      begin
        Tmemo(Components[i]).StyleElements:=[];
        Tmemo(Components[i]).Color:=Cor_memo_Fundo;
        Tmemo(Components[i]).Font.Name:=Name_Fonte;
        Tmemo(Components[i]).Font.Size:=Tam_fonte;

      end;

      if Components[i] is TDBEdit then
      begin
        TDBEdit(Components[i]).StyleElements:=[];

        if TDBEdit(Components[i]).Color=clWindow then
          TDBEdit(Components[i]).Color:= Cor_Padrao_fundo;

        TDBEdit(Components[i]).Font.Name:=Name_Fonte;
        TDBEdit(Components[i]).Font.Size:=Tam_fonte;
        TDBEdit(Components[i]).Height:=30;

        TDBEdit(Components[i]).BevelInner:=bvLowered;
        TDBEdit(Components[i]).BevelKind:=bkFlat;
        TDBEdit(Components[i]).BevelOuter:=bvSpace;
        TDBEdit(Components[i]).BevelWidth:=2;

        TDBEdit(Components[i]).BorderStyle:=bsNone;
        TDBEdit(Components[i]).CharCase:=ecUpperCase;

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

      if Components[i] is TDBLookupComboBox then
      begin
        TDBLookupComboBox(Components[i]).StyleElements:=[];
        TDBLookupComboBox(Components[i]).Color:=Cor_Padrao_fundo;
        TDBLookupComboBox(Components[i]).Height:=30;
        TDBLookupComboBox(Components[i]).BevelInner:=bvNone;
        TDBLookupComboBox(Components[i]).BevelKind:=bkFlat;
        TDBLookupComboBox(Components[i]).BevelOuter:=bvSpace;
        TDBLookupComboBox(Components[i]).BevelWidth:=1;
        TDBLookupComboBox(Components[i]).Font.Name:=Name_Fonte;
        TDBLookupComboBox(Components[i]).Font.Size:=Tam_fonte;


      end;

     if Components[i] is TComboBox then
      begin
        TComboBox(Components[i]).StyleElements:=[];
        TComboBox(Components[i]).Color:=Cor_Padrao_fundo;
        TComboBox(Components[i]).Height:=30;
        TComboBox(Components[i]).BevelInner:=bvNone;
        TComboBox(Components[i]).BevelKind:=bkFlat;
        TComboBox(Components[i]).BevelOuter:=bvSpace;

        TComboBox(Components[i]).Style:=csOwnerDrawVariable;
        TComboBox(Components[i]).Font.Name:=Name_Fonte;
        TComboBox(Components[i]).Font.Size:=Tam_fonte;

      end;

      if Components[i] is TCheckBox then
      begin
        TCheckBox(Components[i]).Font.Name:=Name_Fonte;
        TCheckBox(Components[i]).Font.Size:=Tam_fonte;
      end;

      if Components[i] is TDateTimePicker then
      begin
        TDateTimePicker(Components[i]).Font.Name:=Name_Fonte;
        TDateTimePicker(Components[i]).Font.Size:=Tam_fonte;
      end;
    end;


end;

function TFormCadPadrao.GetControlByField(AFieldName: string): TWinControl;
var
  i: Integer;
  dbEdit: TDBEdit;
begin
  Result := nil;
  for i := 0 to ComponentCount - 1 do
  begin
    if Components[i] is TDBEdit then
    begin
      dbEdit := TDBEdit(Components[i]);
      if SameText(dbEdit.DataField, AFieldName) then
      begin
        Result := dbEdit;
        Exit;
      end;
    end;
  end;

end;



end.
