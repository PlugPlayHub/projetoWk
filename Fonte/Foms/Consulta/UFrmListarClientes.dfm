inherited FrmListarClientes: TFrmListarClientes
  Caption = 'FrmListarClientes'
  ClientHeight = 662
  ClientWidth = 1257
  ExplicitWidth = 1257
  ExplicitHeight = 662
  TextHeight = 17
  inherited PGCtrlModelo: TPageControl
    Width = 1257
    Height = 627
    ExplicitWidth = 1257
    ExplicitHeight = 627
    inherited TabSheetConsultar: TTabSheet
      ExplicitWidth = 1249
      ExplicitHeight = 598
      inherited PanelPrincipal: TPanel
        Width = 1249
        Height = 598
        ExplicitWidth = 1249
        ExplicitHeight = 598
        inherited PanelGrid: TPanel
          Width = 1249
          Height = 524
          ExplicitWidth = 1249
          ExplicitHeight = 524
          inherited dbgridConsulta: TDBGrid
            Width = 1249
            Height = 524
            OnDblClick = dbgridConsultaDblClick
            OnKeyDown = dbgridConsultaKeyDown
            Columns = <
              item
                Expanded = False
                FieldName = 'cliente'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'nome'
                Width = 367
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Logradouro'
                Width = 274
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'qtde_entregar'
                Title.Caption = 'Qtde pedido aberto'
                Width = 168
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'valor_entregar'
                Title.Caption = 'Valor pedido aberto'
                Width = 151
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'lista_pedidos'
                Title.Alignment = taCenter
                Title.Caption = 'Pedidos'
                Width = 150
                Visible = True
              end>
          end
        end
        inherited PanelBotoes: TPanel
          Width = 1249
          ExplicitWidth = 1249
          inherited Panelfiltros: TPanel
            Width = 1249
            ExplicitWidth = 1249
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
      ExplicitWidth = 1249
      ExplicitHeight = 598
      inherited Panel5: TPanel
        Left = 1234
        Height = 523
        ExplicitLeft = 1234
        ExplicitHeight = 523
      end
      inherited PanelLeftModel: TPanel
        Height = 523
        ExplicitHeight = 523
      end
      inherited Panel7: TPanel
        Top = 583
        Width = 1249
        ExplicitTop = 583
        ExplicitWidth = 1249
      end
      inherited PanelTop: TPanel
        Width = 1249
        ExplicitWidth = 1249
        inherited Panel1: TPanel
          Width = 1249
          ExplicitWidth = 1249
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
      ExplicitWidth = 1249
      ExplicitHeight = 598
      inherited PanelTopExcluir: TPanel
        Width = 1249
        ExplicitWidth = 1249
        inherited BtnVoltarExcluir: TPanel
          inherited SpeedButton4: TSpeedButton
            OnClick = SpeedButton4Click
          end
        end
        inherited ButtonConfirmarExclusao: TPanel
          inherited SpeedButton6: TSpeedButton
            OnClick = SpeedButton6Click
          end
        end
      end
    end
  end
  inherited ID_Comercial_PlugPlay: TPanel
    Width = 1257
    ExplicitWidth = 1257
    inherited Panel22: TPanel
      Left = 1239
      ExplicitLeft = 1239
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
    object FdPesquisarcliente: TIntegerField
      FieldName = 'cliente'
    end
    object FdPesquisarnome: TStringField
      FieldName = 'nome'
      Size = 60
    end
    object FdPesquisarcidade: TStringField
      DisplayWidth = 50
      FieldName = 'Logradouro'
      Size = 45
    end
    object FdPesquisarvalor_entregar: TFloatField
      FieldName = 'valor_entregar'
      currency = True
    end
    object FdPesquisarqtde_entregar: TIntegerField
      FieldName = 'qtde_entregar'
    end
    object FdPesquisarlista_pedidos: TStringField
      FieldName = 'lista_pedidos'
      Size = 30
    end
  end
end
