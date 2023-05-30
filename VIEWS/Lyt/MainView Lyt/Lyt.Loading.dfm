inherited Lyt_Loading: TLyt_Loading
  Caption = 'Lyt_Loading'
  PixelsPerInch = 96
  TextHeight = 23
  inherited Pnl_Views: TPanel
    object Pnl_Loading: TPanel
      Left = 305
      Top = 207
      Width = 150
      Height = 100
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        150
        100)
      object scgpctvtybrLoadind_Bar: TscGPActivityBar
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
        PointColor = 6769435
        TransparentBackground = True
      end
    end
  end
end
