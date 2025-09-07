object FormCadPadrao: TFormCadPadrao
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FormCadPadrao'
  ClientHeight = 632
  ClientWidth = 1309
  Color = 14935011
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  StyleElements = [seFont, seBorder]
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object FDMemTablePadrao: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 1005
    Top = 197
  end
  object DataSourcePadrao: TDataSource
    DataSet = FDMemTablePadrao
    Left = 1040
    Top = 80
  end
end
