object Lyt_DlgMsg: TLyt_DlgMsg
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'View DlgMsg'
  ClientHeight = 121
  ClientWidth = 357
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Poppins'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefaultSizeOnly
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 23
  object Pnl_MsgDlg: TPanel
    Left = 0
    Top = 0
    Width = 357
    Height = 121
    Align = alClient
    BevelOuter = bvNone
    Caption = 'sPanel1'
    Color = clWhite
    ShowCaption = False
    TabOrder = 0
    object Pnl_Btns: TPanel
      Left = 0
      Top = 81
      Width = 357
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      OnMouseDown = Pnl_navbarMouseDown
      DesignSize = (
        357
        40)
      object Pnl_Line_Btns: TPanel
        Left = 0
        Top = 0
        Width = 357
        Height = 1
        Align = alTop
        BevelOuter = bvNone
        Color = 15000804
        ParentBackground = False
        ShowCaption = False
        TabOrder = 2
      end
      object Btn_Cancel: TscGPButton
        Left = 190
        Top = 3
        Width = 81
        Height = 34
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Poppins'
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentFont = False
        FluentUIOpaque = False
        TabOrder = 1
        TabStop = True
        Animation = False
        Badge.Color = clRed
        Badge.ColorAlpha = 255
        Badge.Font.Charset = DEFAULT_CHARSET
        Badge.Font.Color = clWhite
        Badge.Font.Height = -11
        Badge.Font.Name = 'Montserrat SemiBold'
        Badge.Font.Style = [fsBold]
        Badge.Visible = False
        Caption = 'No'
        CaptionCenterAlignment = False
        CanFocused = True
        CustomDropDown = False
        DrawTextMode = scdtmGDI
        Margin = -1
        Spacing = 1
        Layout = blGlyphLeft
        ImageIndex = -1
        ImageMargin = 0
        TransparentBackground = True
        Options.NormalColor = 6769435
        Options.HotColor = 6769435
        Options.PressedColor = 6769435
        Options.FocusedColor = 6769435
        Options.DisabledColor = clNone
        Options.NormalColor2 = clNone
        Options.HotColor2 = clNone
        Options.PressedColor2 = clNone
        Options.FocusedColor2 = clNone
        Options.DisabledColor2 = clNone
        Options.NormalColorAlpha = 40
        Options.HotColorAlpha = 40
        Options.PressedColorAlpha = 60
        Options.FocusedColorAlpha = 40
        Options.DisabledColorAlpha = 40
        Options.NormalColor2Alpha = 255
        Options.HotColor2Alpha = 255
        Options.PressedColor2Alpha = 255
        Options.FocusedColor2Alpha = 255
        Options.DisabledColor2Alpha = 255
        Options.FrameNormalColor = clNone
        Options.FrameHotColor = clNone
        Options.FramePressedColor = clHighlight
        Options.FrameFocusedColor = clNone
        Options.FrameDisabledColor = clNone
        Options.FrameWidth = 1
        Options.FrameNormalColorAlpha = 255
        Options.FrameHotColorAlpha = 255
        Options.FramePressedColorAlpha = 255
        Options.FrameFocusedColorAlpha = 255
        Options.FrameDisabledColorAlpha = 255
        Options.FontNormalColor = 6769435
        Options.FontHotColor = 6769435
        Options.FontPressedColor = 6769435
        Options.FontFocusedColor = 6769435
        Options.FontDisabledColor = 6769435
        Options.ShapeFillGradientAngle = 90
        Options.ShapeFillGradientPressedAngle = -90
        Options.ShapeFillGradientColorOffset = 25
        Options.ShapeCornerRadius = 10
        Options.ShapeStyle = scgpBottomRoundedLine
        Options.ShapeStyleLineSize = 0
        Options.ArrowSize = 9
        Options.ArrowAreaSize = 0
        Options.ArrowType = scgpatDefault
        Options.ArrowThickness = 2
        Options.ArrowThicknessScaled = False
        Options.ArrowNormalColor = clBtnText
        Options.ArrowHotColor = clBtnText
        Options.ArrowPressedColor = clBtnText
        Options.ArrowFocusedColor = clBtnText
        Options.ArrowDisabledColor = clBtnText
        Options.ArrowNormalColorAlpha = 200
        Options.ArrowHotColorAlpha = 255
        Options.ArrowPressedColorAlpha = 255
        Options.ArrowFocusedColorAlpha = 200
        Options.ArrowDisabledColorAlpha = 125
        Options.StyleColors = True
        Options.PressedHotColors = True
        HotImageIndex = -1
        ModalResult = 2
        ModalSetting = True
        FluentLightEffect = False
        FocusedImageIndex = -1
        PressedImageIndex = -1
        UseGalleryMenuImage = False
        UseGalleryMenuCaption = False
        ScaleMarginAndSpacing = False
        WidthWithCaption = 0
        WidthWithoutCaption = 0
        SplitButton = False
        RepeatClick = False
        RepeatClickInterval = 100
        GlowEffect.Enabled = False
        GlowEffect.Color = clHighlight
        GlowEffect.AlphaValue = 255
        GlowEffect.GlowSize = 7
        GlowEffect.Offset = 0
        GlowEffect.Intensive = True
        GlowEffect.StyleColors = True
        GlowEffect.HotColor = clNone
        GlowEffect.PressedColor = clNone
        GlowEffect.FocusedColor = clNone
        GlowEffect.PressedGlowSize = 7
        GlowEffect.PressedAlphaValue = 255
        GlowEffect.States = [scsHot, scsPressed, scsFocused]
        ImageGlow = True
        ShowGalleryMenuFromTop = False
        ShowGalleryMenuFromRight = False
        ShowMenuArrow = True
        ShowFocusRect = True
        Down = False
        GroupIndex = 0
        AllowAllUp = False
        ToggleMode = False
      end
      object Btn_Ok: TscGPButton
        Left = 274
        Top = 3
        Width = 80
        Height = 34
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Poppins'
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        ParentFont = False
        FluentUIOpaque = False
        TabOrder = 0
        TabStop = True
        Animation = False
        Badge.Color = clRed
        Badge.ColorAlpha = 255
        Badge.Font.Charset = DEFAULT_CHARSET
        Badge.Font.Color = clWhite
        Badge.Font.Height = -11
        Badge.Font.Name = 'Montserrat SemiBold'
        Badge.Font.Style = [fsBold]
        Badge.Visible = False
        Caption = 'Ok'
        CaptionCenterAlignment = False
        CanFocused = True
        CustomDropDown = False
        DrawTextMode = scdtmGDI
        Margin = -1
        Spacing = 1
        Layout = blGlyphLeft
        ImageIndex = -1
        ImageMargin = 0
        TransparentBackground = True
        Options.NormalColor = 6769435
        Options.HotColor = 6769435
        Options.PressedColor = 6769435
        Options.FocusedColor = 6769435
        Options.DisabledColor = clNone
        Options.NormalColor2 = clNone
        Options.HotColor2 = clNone
        Options.PressedColor2 = clNone
        Options.FocusedColor2 = clNone
        Options.DisabledColor2 = clNone
        Options.NormalColorAlpha = 255
        Options.HotColorAlpha = 255
        Options.PressedColorAlpha = 255
        Options.FocusedColorAlpha = 255
        Options.DisabledColorAlpha = 255
        Options.NormalColor2Alpha = 255
        Options.HotColor2Alpha = 255
        Options.PressedColor2Alpha = 255
        Options.FocusedColor2Alpha = 255
        Options.DisabledColor2Alpha = 255
        Options.FrameNormalColor = clNone
        Options.FrameHotColor = clNone
        Options.FramePressedColor = clHighlight
        Options.FrameFocusedColor = clNone
        Options.FrameDisabledColor = clNone
        Options.FrameWidth = 1
        Options.FrameNormalColorAlpha = 255
        Options.FrameHotColorAlpha = 255
        Options.FramePressedColorAlpha = 255
        Options.FrameFocusedColorAlpha = 255
        Options.FrameDisabledColorAlpha = 255
        Options.FontNormalColor = clWhite
        Options.FontHotColor = clWhite
        Options.FontPressedColor = clWhite
        Options.FontFocusedColor = clWhite
        Options.FontDisabledColor = 6769435
        Options.ShapeFillGradientAngle = 90
        Options.ShapeFillGradientPressedAngle = -90
        Options.ShapeFillGradientColorOffset = 25
        Options.ShapeCornerRadius = 10
        Options.ShapeStyle = scgpBottomRoundedLine
        Options.ShapeStyleLineSize = 0
        Options.ArrowSize = 9
        Options.ArrowAreaSize = 0
        Options.ArrowType = scgpatDefault
        Options.ArrowThickness = 2
        Options.ArrowThicknessScaled = False
        Options.ArrowNormalColor = clBtnText
        Options.ArrowHotColor = clBtnText
        Options.ArrowPressedColor = clBtnText
        Options.ArrowFocusedColor = clBtnText
        Options.ArrowDisabledColor = clBtnText
        Options.ArrowNormalColorAlpha = 200
        Options.ArrowHotColorAlpha = 255
        Options.ArrowPressedColorAlpha = 255
        Options.ArrowFocusedColorAlpha = 200
        Options.ArrowDisabledColorAlpha = 125
        Options.StyleColors = True
        Options.PressedHotColors = True
        HotImageIndex = -1
        ModalResult = 1
        ModalSetting = True
        FluentLightEffect = False
        FocusedImageIndex = -1
        PressedImageIndex = -1
        UseGalleryMenuImage = False
        UseGalleryMenuCaption = False
        ScaleMarginAndSpacing = False
        WidthWithCaption = 0
        WidthWithoutCaption = 0
        SplitButton = False
        RepeatClick = False
        RepeatClickInterval = 100
        GlowEffect.Enabled = False
        GlowEffect.Color = clHighlight
        GlowEffect.AlphaValue = 255
        GlowEffect.GlowSize = 7
        GlowEffect.Offset = 0
        GlowEffect.Intensive = True
        GlowEffect.StyleColors = True
        GlowEffect.HotColor = clNone
        GlowEffect.PressedColor = clNone
        GlowEffect.FocusedColor = clNone
        GlowEffect.PressedGlowSize = 7
        GlowEffect.PressedAlphaValue = 255
        GlowEffect.States = [scsHot, scsPressed, scsFocused]
        ImageGlow = True
        ShowGalleryMenuFromTop = False
        ShowGalleryMenuFromRight = False
        ShowMenuArrow = True
        ShowFocusRect = True
        Down = False
        GroupIndex = 0
        AllowAllUp = False
        ToggleMode = False
      end
    end
    object Pnl_navbar: TPanel
      Left = 0
      Top = 0
      Width = 357
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
      OnMouseDown = Pnl_navbarMouseDown
      object Lbl_KindName: TsImgLabel
        Left = 6
        Top = 5
        Width = 81
        Height = 23
        Align = alCustom
        Caption = 'Information'
        ParentFont = False
        Layout = tlCenter
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Poppins'
        Font.Style = [fsBold]
        Font.Quality = fqClearTypeNatural
      end
      object Pnl_Line_navbar: TPanel
        Left = 0
        Top = 29
        Width = 357
        Height = 1
        Align = alBottom
        BevelOuter = bvNone
        Color = 6769435
        ParentBackground = False
        ShowCaption = False
        TabOrder = 0
      end
    end
    object Pnl_Msg: TPanel
      Left = 0
      Top = 30
      Width = 357
      Height = 51
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Color = clWhite
      Padding.Left = 6
      TabOrder = 2
      OnMouseDown = Pnl_navbarMouseDown
      object Lbl_Msg: TsImgLabel
        Left = 6
        Top = 0
        Width = 351
        Height = 51
        Align = alClient
        AutoSize = False
        Caption = 'Do you want to Close the Program ?'
        Color = clWhite
        ParentColor = False
        ParentFont = False
        TransparentForMouse = True
        Layout = tlCenter
        WordWrap = True
        OnMouseDown = Pnl_navbarMouseDown
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Poppins'
        Font.Style = []
        ExplicitLeft = 62
        ExplicitTop = 6
        ExplicitWidth = 310
        ExplicitHeight = 43
      end
    end
  end
  object AppEvents: TApplicationEvents
    OnActivate = AppEventsActivate
    OnRestore = AppEventsRestore
    Left = 288
    Top = 40
  end
end
