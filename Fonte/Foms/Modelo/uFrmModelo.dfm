object FrmModelo: TFrmModelo
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 658
  ClientWidth = 1333
  Color = 15790320
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  StyleElements = [seClient, seBorder]
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 17
  object PGCtrlModelo: TPageControl
    Left = 0
    Top = 35
    Width = 1333
    Height = 623
    ActivePage = TabSheetConsultar
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Calibri'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TabSheetConsultar: TTabSheet
      Caption = 'TabSheetConsultar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      object PanelPrincipal: TPanel
        Left = 0
        Top = 0
        Width = 1325
        Height = 594
        Align = alClient
        BevelOuter = bvNone
        Color = 15790320
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Calibri'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object PanelGrid: TPanel
          Left = 0
          Top = 74
          Width = 1325
          Height = 520
          Align = alClient
          BevelOuter = bvNone
          Caption = 'Consulta Sem Resultado'
          Color = 6641225
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -30
          Font.Name = 'Calibri'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = True
          object dbgridConsulta: TDBGrid
            Left = 0
            Top = 0
            Width = 1325
            Height = 520
            Align = alClient
            BorderStyle = bsNone
            Color = 16514043
            DataSource = Ds
            DrawingStyle = gdsGradient
            FixedColor = 12763842
            GradientEndColor = 12763842
            GradientStartColor = 12763842
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            ParentFont = False
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clBlack
            TitleFont.Height = -15
            TitleFont.Name = 'Segoe UI'
            TitleFont.Style = []
            Visible = False
            StyleElements = [seFont, seBorder]
            OnDrawColumnCell = dbgridConsultaDrawColumnCell
          end
        end
        object PanelBotoes: TPanel
          Left = 0
          Top = 0
          Width = 1325
          Height = 74
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object Panelfiltros: TPanel
            Left = 0
            Top = 0
            Width = 1325
            Height = 74
            Align = alClient
            BevelOuter = bvNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -12
            Font.Name = 'Calibri'
            Font.Style = []
            ParentBackground = False
            ParentFont = False
            TabOrder = 0
            StyleElements = [seFont, seBorder]
            object SPBLimparFiltro: TSpeedButton
              Left = 281
              Top = 17
              Width = 21
              Height = 23
              Hint = 'Limpar Filtro'
              Flat = True
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFF0000000000000000000000000000004000008000008000008000
                00800000800000800000FFFFFFFFFFFFFFFFFF20000080404080404080404080
                4040804040802020800000800000800000800000800000800000FFFFFFFFFFFF
                2000008040408040408040408040408040408040408020208000008000008000
                00800000800000800000FFFFFF20000080404080404080404080404080404080
                4040804040802020703030AF3030AF3030400000400000400000200000804040
                804040804040804040804040804040804040804040503030DF6060DF6060DF60
                60000000FFFFFFFFFFFF000000000000007F7F007F7F007F7F007F7F007F7F3F
                7F7F3F7F7F3FBFBFDF6060DF6060DF6060000000FFFFFFFFFFFFFFFFFFFFFFFF
                003F3F00BFBF00FFFFBFFFFF3FFFFF3FFFFF00FFFF00FFFF9F9F9FDF6060DF60
                60000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00BFBF00FFFF3FFFFF3F
                FFFF3FFFFF3FFFFF00FFFF003F3F000000000000FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFF007F7F00FFFF3FFFFF3FFFFF3FFFFF209F9F4040200000
                00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF003F3F00
                BFBF3FFFFF407F7F707050A0A060606040000000FFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF205F5FAFAFAFAFAFAF9090707070
                30202000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFF000000909090EFEFEF8F8F8F808060505050000000FFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000006060609F9F9F7F7F
                5F707050707070000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFF0000000000006F6F30BFBFBF909050707070FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
                003F3F7FBFBFBF909050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00003F6F6F50BFBFBF}
              ParentShowHint = False
              ShowHint = True
              OnClick = SPBLimparFiltroClick
            end
            object LabelTotal: TLabel
              Left = 33
              Top = 46
              Width = 69
              Height = 16
              BiDiMode = bdRightToLeftNoAlign
              Caption = 'Registros: 0'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentBiDiMode = False
              ParentFont = False
              StyleElements = [seClient, seBorder]
            end
            object SB: TSearchBox
              Left = 32
              Top = 17
              Width = 235
              Height = 23
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -13
              Font.Name = 'Calibri'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              TextHint = 'Localizar'
              StyleName = 'Windows'
              OnChange = SBChange
            end
            object PnIncluir: TPanel
              Left = 341
              Top = 13
              Width = 80
              Height = 28
              BevelOuter = bvNone
              Color = 15508554
              ParentBackground = False
              TabOrder = 1
              StyleElements = []
              object SpbInlcuir: TSpeedButton
                Left = 0
                Top = 0
                Width = 80
                Height = 28
                Hint = 'Incluir cadastro'
                Align = alClient
                Caption = 'Incluir'
                Flat = True
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -13
                Font.Name = 'Segoe UI Symbol'
                Font.Style = []
                Glyph.Data = {
                  42010000424D4201000000000000760000002800000013000000110000000100
                  040000000000CC00000000000000000000001000000000000000000000000000
                  8000008000000080800080000000800080008080000080808000C0C0C0000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
                  DDDDDDD00000DDDDDDDDDDDDDDDDDDD00000DDDDDDDDDDDDDDDDDDD00000DDDD
                  DDDDFFDDDDDDDDD00000DDDDDDDDFFDDDDDDDDD00000DDDDDDDDFFDDDDDDDDD0
                  0000DDDDDDDDFFDDDDDDDDD00000DDDFFFFFFFFFFFFDDDD00000DDDFFFFFFFFF
                  FFFDDDD00000DDDDDDDDFFDDDDDDDDD00000DDDDDDDDFFDDDDDDDDD00000DDDD
                  DDDDFFDDDDDDDDD00000DDDDDDDDFFDDDDDDDDD00000DDDDDDDDFFDDDDDDDDD0
                  0000DDDDDDDDDDDDDDDDDDD00000DDDDDDDDDDDDDDDDDDD00000DDDDDDDDDDDD
                  DDDDDDD00000}
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                Spacing = 0
                StyleElements = [seBorder]
                ExplicitLeft = 8
                ExplicitHeight = 30
              end
            end
            object PNexclur: TPanel
              Left = 464
              Top = 13
              Width = 85
              Height = 28
              BevelOuter = bvNone
              Color = 15508554
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentBackground = False
              ParentFont = False
              TabOrder = 2
              StyleElements = []
              object SpeedButton11: TSpeedButton
                Left = 0
                Top = 0
                Width = 85
                Height = 28
                Hint = 'Excluir'
                Align = alClient
                Caption = 'Delete'
                Flat = True
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -13
                Font.Name = 'Segoe UI Symbol'
                Font.Style = []
                Glyph.Data = {
                  E6040000424DE604000000000000360000002800000014000000140000000100
                  180000000000B004000074120000741200000000000000000000E6E6E6FFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CED241CED24
                  1CED241CED241CED000000000000000000000000000000000000000000241CED
                  241CED241CED241CED241CED241CED241CED241CEDFFFFFFFFFFFFFFFFFFFFFF
                  FF241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CEDF9F6FAFF
                  FFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFFFFFFFF241CED
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CEDF9F6FAFFFFFFFFFF
                  FFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFFFFFFFF241CEDFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CEDF7F4F7FFFFFFFFFFFFFFFFFF
                  FFFFFF241CED241CEDFFFFFFFFFFFFFFFFFFFFFFFF241CEDFDF7F2FDF7F2FFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFF241CEDF8F7FBFFFFFFFFFFFFFFFFFFFFFFFF24
                  1CED241CEDFFFFFFFFFFFFFFFFFFFFFFFF241CED241CED241CED241CED241CED
                  241CED241CED241CED241CEDFBFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241C
                  EDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFF24
                  1CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED
                  241CED241CED241CED241CEDFFFFFF241CED241CEDFFFFFFFFFFFF241CEDFFFF
                  FFFCFFFFFBFFFDFBFFFDFBFFFCFBFFFDFBFFFDFBFFFDFBFFFDFBFFFDFBFFFFFF
                  FFFF241CED241CEDFFFFFF241CED241CEDFFFFFFFFFFFF241CEDFFFFFFFCFBF3
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241C
                  ED241CEDFFFFFF241CED241CEDFFFFFFFFFFFF241CEDFBFBF8241CED241CED24
                  1CEDFFFFFF241CED241CED241CED241CEDFFFFFF241CEDF9F9F6241CED241CED
                  FFFFFF241CED241CEDFFFFFFFFFFFF241CEDFBFBF8241CED241CED241CEDFFFF
                  FF241CED241CED241CED241CEDFFFFFF241CEDF9F9F6241CED241CEDFFFFFF24
                  1CED241CEDFFFFFFFFFFFF241CEDFDFCF9FDF5E8FFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFAF7241CED241CEDFFFFFF241CED241C
                  EDFFFFFFFFFFFF241CEDFFFFFF241CED241CED241CED241CEDFFFFFF241CED24
                  1CED241CED241CED241CEDFFFFFF241CED241CEDFFFFFF241CED241CEDFFFFFF
                  FFFFFF241CEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFF241CED241CEDFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF241CED241CEDFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                  FFFFFFFFFFFFFFFFFFFFFF241CED241CED241CED241CED241CED241CED241CED
                  241CED241CED241CED241CED241CED241CED241CED241CED241CED241CED241C
                  ED241CED241CED241CED}
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                Spacing = 5
                StyleElements = [seBorder]
                ExplicitTop = 1
              end
            end
          end
        end
      end
    end
    object TabSheetManu: TTabSheet
      Caption = 'TabSheetManu'
      ImageIndex = 1
      object Panel5: TPanel
        Left = 1310
        Top = 60
        Width = 15
        Height = 519
        Align = alRight
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        StyleElements = [seFont, seBorder]
      end
      object PanelLeftModel: TPanel
        Left = 0
        Top = 60
        Width = 15
        Height = 519
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 1
        StyleElements = [seFont, seBorder]
      end
      object Panel7: TPanel
        Left = 0
        Top = 579
        Width = 1325
        Height = 15
        Align = alBottom
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 2
        StyleElements = [seFont, seBorder]
      end
      object PanelTop: TPanel
        Left = 0
        Top = 0
        Width = 1325
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 3
        StyleElements = [seFont, seBorder]
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 1325
          Height = 10
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
        end
        object ButtonSalvar: TPanel
          Left = 110
          Top = 16
          Width = 97
          Height = 28
          BevelOuter = bvNone
          Color = 15508554
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          StyleElements = []
          object SpeedButton3: TSpeedButton
            Left = 0
            Top = 0
            Width = 97
            Height = 28
            Hint = 'Salvar'
            Align = alClient
            Caption = 'Salvar'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'Segoe UI Symbol'
            Font.Style = []
            Glyph.Data = {
              0A070000424D0A07000000000000360000002800000019000000170000000100
              180000000000D406000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FF0000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000FF00FFFF00FF00FF00
              FFFF00FF000000000000FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              000000FF00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFF000000FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00FF000000FFFFFFFF
              FFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00
              FF00FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF000000FF00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFF
              000000000000000000000000000000000000000000000000000000000000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00FF000000
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
              00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00
              FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              000000FF00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00FF000000FFFFFFFF
              FFFFFFFFFF000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000FFFFFFFFFFFFFFFFFF000000FF00FFFF00
              FF00FF00FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF
              FFFFFFFF000000FF00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFFFF000000
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00FF000000
              FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FF
              00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
              FFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFF
              FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00
              FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF
              000000FF00FFFF00FF00FF00FF00000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000FF00FFFF00FF00FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FF00}
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            Spacing = 10
            StyleElements = [seBorder]
            ExplicitLeft = 38
            ExplicitTop = -3
            ExplicitWidth = 95
            ExplicitHeight = 30
          end
        end
        object PnVoltar: TPanel
          Left = 18
          Top = 16
          Width = 60
          Height = 28
          BevelOuter = bvNone
          Color = 15508554
          ParentBackground = False
          TabOrder = 2
          StyleElements = []
          object Spbvoltar: TSpeedButton
            Left = 0
            Top = 0
            Width = 60
            Height = 28
            Hint = 'Retornar tela anterior'
            Align = alClient
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'Segoe UI Symbol'
            Font.Style = []
            Glyph.Data = {
              4E010000424D4E01000000000000760000002800000013000000120000000100
              040000000000D800000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDDDD00000DDDDDDDDDDDDDDDDDDD00000DDDDDDDDFFFFFFFDDDD00000DDDD
              DDDDFFFFFFFFDDD00000DDDDDDDDFFFFFFFFFDD00000DDDDDDDDFFFFFFFFFDD0
              0000DDDDDDDDDDDDDDDDFDD00000DDDDDDDDDDDDDDDDFDD00000DDDDDDDDDDDD
              DDDDFDD00000DDDDFDDDDDDDDDDDFDD00000DDDFFDDDDDDDDDDDFDD00000DDFF
              FFFFFFFFFFFFFDD00000DFFFFFFFFFFFFFFFDDD00000DFFFFFFFFFFFFFFDDDD0
              0000DDFFFFFFFFFFFFFDDDD00000DDDFFDDDDDDDDDDDDDD00000DDDDFDDDDDDD
              DDDDDDD00000DDDDDDDDDDDDDDDDDDD00000}
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            Spacing = 5
            StyleElements = []
            ExplicitTop = 8
            ExplicitWidth = 49
            ExplicitHeight = 30
          end
        end
      end
    end
    object TabSheetdelete: TTabSheet
      Caption = 'TabSheetdelete'
      ImageIndex = 2
      object PanelTopExcluir: TPanel
        Left = 0
        Top = 0
        Width = 1325
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = 16382457
        ParentBackground = False
        TabOrder = 0
        object BtnVoltarExcluir: TPanel
          Left = 18
          Top = 16
          Width = 60
          Height = 28
          BevelOuter = bvNone
          Color = 15508554
          ParentBackground = False
          TabOrder = 0
          StyleElements = []
          object SpeedButton4: TSpeedButton
            Left = 0
            Top = 0
            Width = 60
            Height = 28
            Hint = 'Retornar tela anterior'
            Align = alClient
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'Segoe UI Symbol'
            Font.Style = []
            Glyph.Data = {
              4E010000424D4E01000000000000760000002800000013000000120000000100
              040000000000D800000000000000000000001000000000000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDDDD00000DDDDDDDDDDDDDDDDDDD00000DDDDDDDDFFFFFFFDDDD00000DDDD
              DDDDFFFFFFFFDDD00000DDDDDDDDFFFFFFFFFDD00000DDDDDDDDFFFFFFFFFDD0
              0000DDDDDDDDDDDDDDDDFDD00000DDDDDDDDDDDDDDDDFDD00000DDDDDDDDDDDD
              DDDDFDD00000DDDDFDDDDDDDDDDDFDD00000DDDFFDDDDDDDDDDDFDD00000DDFF
              FFFFFFFFFFFFFDD00000DFFFFFFFFFFFFFFFDDD00000DFFFFFFFFFFFFFFDDDD0
              0000DDFFFFFFFFFFFFFDDDD00000DDDFFDDDDDDDDDDDDDD00000DDDDFDDDDDDD
              DDDDDDD00000DDDDDDDDDDDDDDDDDDD00000}
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            Spacing = 5
            StyleElements = [seBorder]
            ExplicitLeft = -1
            ExplicitTop = -5
            ExplicitWidth = 30
            ExplicitHeight = 30
          end
        end
        object ButtonConfirmarExclusao: TPanel
          Left = 110
          Top = 16
          Width = 97
          Height = 28
          BevelOuter = bvNone
          Color = 15508554
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          StyleElements = []
          object SpeedButton6: TSpeedButton
            Left = 0
            Top = 0
            Width = 97
            Height = 28
            Hint = 'Excluir cadastro'
            Align = alClient
            Caption = 'Delete'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'Segoe UI Symbol'
            Font.Style = []
            Glyph.Data = {
              0A070000424D0A07000000000000360000002800000019000000170000000100
              180000000000D406000000000000000000000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF00FFFF00FFFF00FFFF00FF0000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000FF00FFFF00FF00FF00
              FFFF00FF000000000000FFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              000000FF00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFF000000FF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00FF000000FFFFFFFF
              FFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00
              FF00FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF000000FF00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFF
              000000000000000000000000000000000000000000000000000000000000FFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00FF000000
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
              00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00
              FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              000000FF00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00FF000000FFFFFFFF
              FFFFFFFFFF000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000FFFFFFFFFFFFFFFFFF000000FF00FFFF00
              FF00FF00FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFF
              FFFFFFFF000000FF00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFFFF000000
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00FF000000
              FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FF
              00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
              FFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00FF000000FFFFFFFFFFFFFFFF
              FF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000FF00FFFF00FF00FF00
              FF000000FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
              FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF
              000000FF00FFFF00FF00FF00FF00000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000000000000000FF00FFFF00FF00FF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FF00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FF00}
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            Spacing = 5
            StyleElements = [seBorder]
            ExplicitLeft = 1
            ExplicitWidth = 85
          end
        end
      end
    end
  end
  object ID_Comercial_PlugPlay: TPanel
    Left = 0
    Top = 0
    Width = 1333
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    StyleElements = [seFont, seBorder]
    object LabelCad: TLabel
      Left = 14
      Top = 7
      Width = 56
      Height = 18
      Caption = 'LabelCad'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Calibri'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object Panel22: TPanel
      Left = 1315
      Top = 0
      Width = 18
      Height = 35
      Align = alRight
      BevelOuter = bvNone
      ParentBackground = False
      ParentColor = True
      TabOrder = 0
      StyleElements = [seFont, seBorder]
    end
  end
  object Ds: TDataSource
    Left = 968
    Top = 104
  end
end
