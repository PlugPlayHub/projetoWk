inherited FormCadPadraoProduto: TFormCadPadraoProduto
  Caption = 'FormCadPadraoProduto'
  TextHeight = 15
  object Label1: TLabel [0]
    Left = 50
    Top = 38
    Width = 39
    Height = 15
    Caption = 'C'#243'digo'
    FocusControl = DBEdit1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel [1]
    Left = 50
    Top = 94
    Width = 51
    Height = 15
    Caption = 'Descricao'
    FocusControl = DBEdit2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [2]
    Left = 50
    Top = 151
    Width = 81
    Height = 15
    Caption = 'Pre'#231'o de venda'
    FocusControl = DBEdit3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object DBEdit1: TDBEdit [3]
    Left = 50
    Top = 55
    Width = 154
    Height = 23
    DataField = 'codigo'
    DataSource = DataSourcePadrao
    TabOrder = 0
  end
  object DBEdit2: TDBEdit [4]
    Left = 50
    Top = 111
    Width = 679
    Height = 23
    DataField = 'descricao'
    DataSource = DataSourcePadrao
    TabOrder = 1
  end
  object DBEdit3: TDBEdit [5]
    Left = 50
    Top = 168
    Width = 154
    Height = 23
    DataField = 'preco_venda'
    DataSource = DataSourcePadrao
    TabOrder = 2
  end
  inherited FDMemTablePadrao: TFDMemTable
    Left = 1096
    Top = 266
    object FDMemTablePadraoProduto: TIntegerField
      FieldName = 'Produto'
    end
    object FDMemTablePadraocodigo: TStringField
      FieldName = 'codigo'
      Required = True
      Size = 10
    end
    object FDMemTablePadraodescricao: TStringField
      FieldName = 'descricao'
      Required = True
      Size = 45
    end
    object FDMemTablePadraopreco_venda: TFloatField
      FieldName = 'preco_venda'
      Required = True
      currency = True
    end
  end
  inherited DataSourcePadrao: TDataSource
    Left = 1092
    Top = 124
  end
end
