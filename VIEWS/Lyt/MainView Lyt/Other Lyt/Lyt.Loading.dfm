object Lyt_Loading: TLyt_Loading
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Layout Loading'
  ClientHeight = 189
  ClientWidth = 216
  Color = 16185078
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    216
    189)
  PixelsPerInch = 96
  TextHeight = 13
  object Pnl_Loading: TPanel
    Left = 33
    Top = 45
    Width = 150
    Height = 100
    Anchors = []
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    DesignSize = (
      150
      100)
    object Loadind_Bar: TscGPActivityBar
      Left = 25
      Top = 48
      Width = 100
      Height = 5
      Anchors = []
      FluentUIOpaque = False
      TabOrder = 0
      Active = True
      PointSpacing = 5
      PointCount = 8
      PointColor = 10173275
      TransparentBackground = True
    end
  end
  object Timer_Loading: TTimer
    Enabled = False
    OnTimer = Timer_LoadingTimer
    Left = 784
    Top = 168
  end
end
