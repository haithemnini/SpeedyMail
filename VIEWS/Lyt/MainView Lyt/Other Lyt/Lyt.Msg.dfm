object Toast: TToast
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 0
  BorderStyle = bsNone
  Caption = 'View Msg'
  ClientHeight = 45
  ClientWidth = 310
  Color = 8304957
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Poppins'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefaultSizeOnly
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 23
  object Img_KindMsg: TImage
    Left = 0
    Top = 0
    Width = 49
    Height = 45
    Align = alLeft
    Center = True
  end
  object Lbl_ColorMsg: TLabel
    Left = 63
    Top = 11
    Width = 223
    Height = 23
    Alignment = taCenter
    AutoSize = False
    Caption = 'Text copied to the clipboard'
    Color = clWindow
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Poppins Medium'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Timer_ShowMsg: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer_ShowMsgTimer
    Left = 454
    Top = 53
  end
end
