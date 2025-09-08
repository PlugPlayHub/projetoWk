inherited FrmListarProdutos: TFrmListarProdutos
  Caption = 'FrmListarProdutos'
  TextHeight = 17
  inherited PGCtrlModelo: TPageControl
    ActivePage = TabSheetManu
    inherited TabSheetConsultar: TTabSheet
      inherited PanelPrincipal: TPanel
        inherited PanelGrid: TPanel
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
          inherited Panelfiltros: TPanel
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
      inherited PanelTop: TPanel
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
        inherited ButtonConfirmarExclusao: TPanel
          inherited SpeedButton6: TSpeedButton
            OnClick = SpeedButton6Click
          end
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
