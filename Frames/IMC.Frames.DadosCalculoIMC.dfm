object frmDadosCalculoIMC: TfrmDadosCalculoIMC
  Left = 0
  Top = 0
  Width = 783
  Height = 318
  TabOrder = 0
  object gbxDadosPaciente: TGroupBox
    Left = 3
    Top = 3
    Width = 770
    Height = 313
    Caption = 'Dados do Paciente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object lblNome: TLabel
      Left = 47
      Top = 32
      Width = 36
      Height = 15
      Alignment = taRightJustify
      Caption = 'Nome:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblNascimento: TLabel
      Left = 16
      Top = 62
      Width = 67
      Height = 15
      Alignment = taRightJustify
      Caption = 'Nascimento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblIdadeCompleta: TLabel
      Left = 217
      Top = 62
      Width = 87
      Height = 15
      Alignment = taRightJustify
      Caption = 'Idade Completa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblAnoMesesSemanasDias: TLabel
      Left = 314
      Top = 62
      Width = 146
      Height = 15
      Caption = 'anos; meses; semanas; dias'
    end
    object sbtnLimpar: TSpeedButton
      Left = 693
      Top = 280
      Width = 69
      Height = 30
      DisabledImageIndex = 3
      Caption = '&Limpar'
      ImageIndex = 2
      Enabled = False
      OnClick = sbtnLimparClick
    end
    object lblIMC: TLabel
      Left = 434
      Top = 203
      Width = 37
      Height = 28
      Caption = 'IMC'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = cl3DDkShadow
      Font.Height = -20
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSeta: TLabel
      Left = 421
      Top = 180
      Width = 80
      Height = 124
      Alignment = taCenter
      Caption = #8594
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMedGray
      Font.Height = -93
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
    end
    object btnHistorico: TSpeedButton
      Left = 601
      Top = 280
      Width = 87
      Height = 30
      DisabledImageIndex = 5
      Caption = '&Hist'#243'rico'
      ImageIndex = 4
      Enabled = False
      OnClick = btnHistoricoClick
    end
    object rgpSexo: TRadioGroup
      Left = 83
      Top = 95
      Width = 201
      Height = 42
      Caption = 'Sexo'
      Columns = 2
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      Items.Strings = (
        '&Feminino'
        '&Masculino')
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 2
      WordWrap = True
      OnClick = rgpSexoClick
      OnExit = rgpSexoExit
    end
    object edtNome: TEdit
      Left = 87
      Top = 29
      Width = 590
      Height = 23
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = edtNomeChange
      OnExit = edtNomeExit
    end
    object edtNascimento: TEdit
      Left = 87
      Top = 58
      Width = 104
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = edtNascimentoChange
      OnExit = edtNascimentoExit
    end
    object edtIMC: TEdit
      Left = 555
      Top = 202
      Width = 110
      Height = 59
      Alignment = taCenter
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvSpace
      BiDiMode = bdRightToLeft
      BorderStyle = bsNone
      Color = clBtnFace
      Ctl3D = True
      DoubleBuffered = False
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -36
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      CanUndoSelText = True
      ReadOnly = True
      TabOrder = 3
      Text = '0,0'
    end
    object gbxDadosCalculo: TGroupBox
      Left = 83
      Top = 143
      Width = 286
      Height = 138
      Caption = 'Dados para C'#225'lculo do IMC'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 4
      object lblPeso: TLabel
        Left = 38
        Top = 32
        Width = 50
        Height = 15
        Caption = 'Peso (Kg)'
      end
      object lblAltura: TLabel
        Left = 182
        Top = 32
        Width = 54
        Height = 15
        Caption = 'Altura (m)'
      end
      object sbtnCalcular: TSpeedButton
        Left = 90
        Top = 88
        Width = 105
        Height = 33
        ParentCustomHint = False
        DisabledImageIndex = 1
        Caption = '&Calcular ->'
        ImageIndex = 0
        ParentShowHint = False
        ShowHint = False
        OnClick = sbtnCalcularClick
      end
      object edtPeso: TEdit
        Left = 19
        Top = 53
        Width = 89
        Height = 23
        Alignment = taCenter
        BiDiMode = bdLeftToRight
        MaxLength = 6
        ParentBiDiMode = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
        OnChange = edtPesoChange
        OnExit = edtPesoExit
      end
      object edtAltura: TEdit
        Left = 160
        Top = 53
        Width = 99
        Height = 23
        Alignment = taCenter
        BiDiMode = bdLeftToRight
        MaxLength = 5
        ParentBiDiMode = False
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
        OnChange = edtAlturaChange
        OnExit = edtAlturaExit
      end
    end
  end
end
