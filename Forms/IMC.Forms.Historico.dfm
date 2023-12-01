object frmHistorico: TfrmHistorico
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Hist'#243'rico'
  ClientHeight = 328
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object lblHistoricoAlteracoes: TLabel
    Left = 10
    Top = 6
    Width = 134
    Height = 13
    Caption = 'Hist'#243'rico de Altera'#231#245'es:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbxHistoricoAlteracoes: TListBox
    Left = 8
    Top = 22
    Width = 319
    Height = 296
    ItemHeight = 15
    TabOrder = 0
    OnClick = lbxHistoricoAlteracoesClick
  end
end
