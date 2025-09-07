object FormEditarItemPedido: TFormEditarItemPedido
  Left = 0
  Top = 0
  Caption = 'Editar item do pedido'
  ClientHeight = 328
  ClientWidth = 552
  Color = 14935011
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  StyleElements = [seFont, seBorder]
  OnCreate = FormCreate
  TextHeight = 20
  object Label2: TLabel
    Left = 32
    Top = 30
    Width = 49
    Height = 20
    Caption = 'C'#243'digo'
    FocusControl = DBEdit2
  end
  object Label_qtde: TLabel
    Left = 32
    Top = 123
    Width = 31
    Height = 20
    Caption = 'qtde'
  end
  object Label_valor: TLabel
    Left = 216
    Top = 123
    Width = 64
    Height = 20
    Caption = 'valor_unit'
  end
  object Label_total: TLabel
    Left = 32
    Top = 184
    Width = 33
    Height = 20
    Caption = 'Total'
  end
  object DBEdit1: TDBEdit
    Left = 184
    Top = 56
    Width = 329
    Height = 28
    DataField = 'descricao'
    DataSource = DsEditarItem
    Enabled = False
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 32
    Top = 56
    Width = 113
    Height = 28
    DataField = 'codigo'
    DataSource = DsEditarItem
    Enabled = False
    TabOrder = 1
  end
  object DBEdit_qtde: TDBEdit
    Left = 96
    Top = 120
    Width = 81
    Height = 28
    DataField = 'qtde'
    DataSource = DsEditarItem
    TabOrder = 2
    OnKeyPress = DBEdit_qtdeKeyPress
  end
  object DBEdit_valor_unit: TDBEdit
    Left = 304
    Top = 120
    Width = 145
    Height = 28
    DataField = 'valor_unit'
    DataSource = DsEditarItem
    TabOrder = 3
    OnKeyPress = DBEdit_valor_unitKeyPress
  end
  object DBEdit_valor_total: TDBEdit
    Left = 96
    Top = 181
    Width = 161
    Height = 28
    DataField = 'valor_total'
    DataSource = DsEditarItem
    Enabled = False
    TabOrder = 4
  end
  object BtnAdd: TBitBtn
    Left = 32
    Top = 255
    Width = 185
    Height = 41
    Caption = 'Atualizar produto'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF4CB1224CB1224CB1224CB122FF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4CB1224CB1224CB1224C
      B1224CB1224CB122FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF4CB1224CB1224CB1224CB1224CB1224CB1224CB122FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4CB1224CB1224CB1224CB1224C
      B1224CB1224CB1224CB122FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      4CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB122FF00
      FFFF00FFFF00FFFF00FFFF00FF4CB1224CB1224CB1224CB1224CB1224CB1224C
      B1224CB1224CB1224CB1224CB122FF00FFFF00FFFF00FFFF00FFFF00FF4CB122
      4CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1224CB1
      22FF00FFFF00FFFF00FFFF00FF4CB1224CB1224CB1224CB1224CB122FF00FFFF
      00FF4CB1224CB1224CB1224CB1224CB1224CB122FF00FFFF00FFFF00FFFF00FF
      4CB1224CB1224CB122FF00FFFF00FFFF00FF4CB1224CB1224CB1224CB1224CB1
      224CB122FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FF4CB1224CB1224CB1224CB1224CB1224CB122FF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4CB1224CB1224CB1
      224CB1224CB122FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FF4CB1224CB1224CB1224CB1224CB122FF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4CB1224CB1
      224CB122FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    TabOrder = 5
    OnClick = BtnAddClick
  end
  object DsEditarItem: TDataSource
    Left = 571
    Top = 134
  end
  object FDProdutosAdd: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 362
    Top = 177
    object FDProdutosAddproduto: TIntegerField
      FieldName = 'produto'
    end
    object FDProdutosAddcodigo: TStringField
      FieldName = 'codigo'
      Size = 30
    end
    object FDProdutosAdddescricao: TStringField
      FieldName = 'descricao'
      Size = 60
    end
    object FDProdutosAddqtde: TIntegerField
      FieldName = 'qtde'
    end
    object FDProdutosAddvalor_unit: TFloatField
      FieldName = 'valor_unit'
      currency = True
    end
    object FDProdutosAddvalor_total: TFloatField
      FieldName = 'valor_total'
      currency = True
    end
  end
end
