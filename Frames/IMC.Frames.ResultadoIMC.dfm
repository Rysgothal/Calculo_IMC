object frmResultadoIMC: TfrmResultadoIMC
  Left = 0
  Top = 0
  Width = 777
  Height = 132
  TabOrder = 0
  PixelsPerInch = 96
  object gbxResultado: TGroupBox
    Left = 3
    Top = 0
    Width = 770
    Height = 130
    Caption = 'Resultado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object shpAbaixoPeso: TShape
      Left = 16
      Top = 49
      Width = 149
      Height = 52
      Brush.Color = 15132390
      Pen.Style = psClear
    end
    object shpPesoIdeal: TShape
      Left = 163
      Top = 49
      Width = 149
      Height = 52
      Brush.Color = 14145495
      Pen.Style = psClear
    end
    object shpPoucoAcima: TShape
      Left = 309
      Top = 49
      Width = 149
      Height = 52
      Brush.Color = 13224393
      Pen.Style = psClear
    end
    object shpAcimaPeso: TShape
      Left = 457
      Top = 49
      Width = 149
      Height = 52
      Brush.Color = 12369084
      Pen.Style = psClear
    end
    object shpObesidade: TShape
      Left = 605
      Top = 49
      Width = 149
      Height = 52
      Brush.Color = 11053224
      Pen.Style = psClear
    end
    object lblAbaixoPeso: TLabel
      Left = 36
      Top = 65
      Width = 108
      Height = 20
      Caption = 'Abaixo do Peso'
      Color = clBlue
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblPesoIdeal: TLabel
      Left = 200
      Top = 65
      Width = 71
      Height = 20
      Caption = 'Peso Ideal'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPoucoAcima: TLabel
      Left = 310
      Top = 65
      Width = 147
      Height = 20
      Caption = 'Pouco acima do Peso'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clOlive
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAcimaPeso: TLabel
      Left = 480
      Top = 65
      Width = 103
      Height = 20
      Caption = 'Acima do Peso'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 16319
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblObesidade: TLabel
      Left = 643
      Top = 65
      Width = 73
      Height = 20
      Caption = 'Obesidade'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSetaBottom: TLabel
      Left = 375
      Top = 91
      Width = 20
      Height = 31
      Alignment = taCenter
      Caption = #9650
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lblSetaTop: TLabel
      Left = 375
      Top = 22
      Width = 20
      Height = 31
      Alignment = taCenter
      Caption = #9660
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -23
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
  end
end
