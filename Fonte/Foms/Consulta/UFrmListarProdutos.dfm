inherited FrmListarProdutos: TFrmListarProdutos
  Caption = 'FrmListarProdutos'
  TextHeight = 17
  inherited PGCtrlModelo: TPageControl
    ActivePage = TabSheetManu
    ExplicitWidth = 1333
    ExplicitHeight = 623
    inherited TabSheetConsultar: TTabSheet
      inherited PanelPrincipal: TPanel
        ExplicitWidth = 1325
        ExplicitHeight = 594
        inherited PanelGrid: TPanel
          ExplicitWidth = 1325
          ExplicitHeight = 520
          inherited dbgridConsulta: TDBGrid
            OnDblClick = dbgridConsultaDblClick
            OnKeyDown = dbgridConsultaKeyDown
            Columns = <
              item
                Expanded = False
                FieldName = 'codigo'
                Width = 112
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'descricao'
                Width = 536
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'preco_venda'
                Width = 116
                Visible = True
              end>
          end
        end
        inherited PanelBotoes: TPanel
          ExplicitWidth = 1325
          inherited Panelfiltros: TPanel
            ExplicitWidth = 1325
            inherited SB: TSearchBox
              OnInvokeSearch = SBInvokeSearch
            end
            inherited PnIncluir: TPanel
              inherited SpbInlcuir: TSpeedButton
                OnClick = SpbInlcuirClick
              end
            end
          end
        end
      end
    end
    inherited TabSheetManu: TTabSheet
      inherited Panel5: TPanel
        ExplicitLeft = 1310
        ExplicitHeight = 519
      end
      inherited PanelLeftModel: TPanel
        ExplicitHeight = 519
      end
      inherited Panel7: TPanel
        ExplicitTop = 579
        ExplicitWidth = 1325
      end
      inherited PanelTop: TPanel
        ExplicitWidth = 1325
        inherited Panel1: TPanel
          ExplicitWidth = 1325
        end
        inherited ButtonSalvar: TPanel
          inherited SpeedButton3: TSpeedButton
            OnClick = SpeedButton3Click
          end
        end
        inherited PnVoltar: TPanel
          inherited Spbvoltar: TSpeedButton
            OnClick = SpbvoltarClick
          end
        end
      end
    end
    inherited TabSheetdelete: TTabSheet
      inherited PanelTopExcluir: TPanel
        ExplicitWidth = 1325
        inherited ButtonConfirmarExclusao: TPanel
          inherited SpeedButton6: TSpeedButton
            OnClick = SpeedButton6Click
          end
        end
      end
    end
  end
  inherited ID_Comercial_PlugPlay: TPanel
    ExplicitWidth = 1333
    inherited Panel22: TPanel
      ExplicitLeft = 1315
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
    object FdPesquisarproduto: TIntegerField
      FieldName = 'produto'
    end
    object FdPesquisarcodigo: TStringField
      FieldName = 'codigo'
      Size = 30
    end
    object FdPesquisardescricao: TStringField
      FieldName = 'descricao'
      Size = 45
    end
    object FdPesquisarpreco_venda: TFloatField
      FieldName = 'preco_venda'
      currency = True
    end
  end
end
