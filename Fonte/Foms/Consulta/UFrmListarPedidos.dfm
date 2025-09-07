inherited FrmListarPedidos: TFrmListarPedidos
  Caption = 'FrmListarPedidos'
  TextHeight = 17
  inherited PGCtrlModelo: TPageControl
    ActivePage = TabSheetManu
    inherited TabSheetManu: TTabSheet
      inherited Panel5: TPanel
        Top = 0
        Height = 574
        Visible = False
        ExplicitTop = 0
        ExplicitHeight = 574
      end
      inherited PanelLeftModel: TPanel
        Top = 0
        Height = 574
        Visible = False
        ExplicitTop = 0
        ExplicitHeight = 574
      end
      inherited Panel7: TPanel
        ExplicitTop = 574
      end
      inherited PanelTop: TPanel
        Left = 1448
        Width = 281
        Align = alNone
        Visible = False
        ExplicitLeft = 1448
        ExplicitWidth = 281
        inherited Panel1: TPanel
          Width = 281
          ExplicitWidth = 281
        end
      end
    end
  end
  inherited Ds: TDataSource
    DataSet = FdPesquisar
  end
  object FdPesquisar: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 687
    Top = 173
  end
end
