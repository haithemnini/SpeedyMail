unit API.Interf.Layouts;

interface

uses
  FireDAC.Comp.Client,
  System.SysUtils,
  Vcl.Controls,
//
  scGPExtControls,
//
  API.Common,
  API.Consts;

type

  I_BaseLayout = interface ['{9277584A-B5DC-4810-A175-580EF012C562}']
    function ShowLayout(aAfter: TProc = nil) : I_BaseLayout;
    function FinishLayout(aAfter: TProc = nil) : I_BaseLayout;
  end;

  I_BaseView = interface ['{0D6E788A-B5B2-43A8-8BE1-464C0FB31085}']
    function ShowModalView(aShowModal: Boolean = True): TModalResult;
    function FinishView : I_BaseView;
  end;

  I_Dimmer = interface ['{82D5DE04-0666-43A3-AAC8-3AE04FD4926C}']
    function ShowDimmer: I_Dimmer;
    function HideDimmer: I_Dimmer;
  end;

  I_Loading = interface ['{98CC8731-C5A0-429A-85AF-001E7F1C7598}']
    function ShowLoading(aLoadingTime: Cardinal = 2500): I_Loading;
  end;

  I_Msg = interface ['{4F1B2303-60D6-4F5E-9E15-96CE18A81B8C}']
    function Show(aMsg: string = ''; aMsgKind: TMsgKind = Tk_Success; aAfter: TProc = nil): I_Msg; overload;
  end;

  I_DlgMsg = interface ['{A7A46B35-E125-4A32-87EE-28981159E377}']
    function Show(aMsg: string = ''; aMsgKind: TMsgDlgKind = TkInfo; aAfter: TProc = nil): TModalResult; overload;
  end;

implementation

end.
