inherited FormCadPadraoCliente: TFormCadPadraoCliente
  Caption = 'FormCadPadraoCliente'
  TextHeight = 15
  object Label2: TLabel [0]
    Left = 50
    Top = 57
    Width = 41
    Height = 20
    Caption = 'Nome'
    FocusControl = DBEdit2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [1]
    Left = 50
    Top = 122
    Width = 47
    Height = 20
    Caption = 'Cidade'
    FocusControl = DBEdit3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel [2]
    Left = 281
    Top = 122
    Width = 17
    Height = 20
    Caption = 'UF'
    FocusControl = DBEdit4
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object DBEdit2: TDBEdit [3]
    Left = 50
    Top = 79
    Width = 465
    Height = 23
    DataField = 'nome'
    DataSource = DataSourcePadrao
    TabOrder = 0
  end
  object DBEdit3: TDBEdit [4]
    Left = 50
    Top = 143
    Width = 177
    Height = 23
    DataField = 'cidade'
    DataSource = DataSourcePadrao
    TabOrder = 1
  end
  object DBEdit4: TDBEdit [5]
    Left = 281
    Top = 143
    Width = 34
    Height = 23
    CharCase = ecUpperCase
    DataField = 'uf'
    DataSource = DataSourcePadrao
    TabOrder = 2
  end
  inherited FDMemTablePadrao: TFDMemTable
    Left = 832
    Top = 158
    object FDMemTablePadraocliente: TIntegerField
      FieldName = 'cliente'
    end
    object FDMemTablePadraonome: TStringField
      FieldName = 'nome'
      Required = True
      Size = 60
    end
    object FDMemTablePadraocidade: TStringField
      FieldName = 'cidade'
      Required = True
      Size = 45
    end
    object FDMemTablePadraouf: TStringField
      FieldName = 'uf'
      Required = True
      Size = 2
    end
  end
  inherited DataSourcePadrao: TDataSource
    Left = 1116
    Top = 108
  end
end
