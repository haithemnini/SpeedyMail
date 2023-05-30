unit Base.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Dialogs,
//
  scControls, scGPControls,
  scModernControls,sLabel,
//
  UCL.Form,
//
  API.Interf.Layouts,
  API.Ref.Lyt,
//
  Lyt.Msg,
  Lyt.DlgMsg,
  Lyt.Dimmer,
//
  Lyt.Loading,
  Lyt.Config,
  Lyt.Sending;

type
  TBaseMain = class(TUForm)
  {$REGION '  Comonpent ...'}
    Pnl_Container: TPanel;
    Pnl_Content: TPanel;
    Pnl_TitBtn: TPanel;
    Lbl_Pagename: TsLabel;
    Pnl_TabBar: TPanel;
    Pnl_Bar_P: TPanel;
    Btn_Sending: TscGPButton;
    Btn_Config: TscGPButton;
    Pnl_navbar: TPanel;
    Lbl_TitleProgram: TsLabel;
    Pnl_Client: TPanel;
    Pnl_SubBtns: TPanel;
    Btn_Minimize: TscGPButton;
    Btn_Close: TscGPButton;
  {$ENDREGION}
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Pnl_navbarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
  strict private
    fLytRef : I_BaseLayout;
    fDlgMsg : I_DlgMsg;
    fMsg : I_Msg;
  private
     procedure UCL_PreConfig;
    { Private declarations }
    function Get_DlgMsg : I_DlgMsg;
    function Get_Msg : I_Msg;
    function GetLyt(aLytClass: TBaseLytClass): I_BaseLayout;
    function Get_LytConfig: TLyt_Config;
    function Get_LytSending: TLyt_Sending;
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
    property LytRef[aLytClass: TBaseLytClass]: I_BaseLayout read GetLyt;
//
    property Lyt_DlgMsg  : I_DlgMsg  read Get_DlgMsg;
    property Lyt_Msg     : I_Msg     read Get_Msg;
//
    property Lyt_Config  : TLyt_Config  read  Get_LytConfig;
    property Lyt_Sending : TLyt_Sending read  Get_LytSending;
  end;

//var
//  BaseMain: TBaseMain;

implementation

uses
  udm.Res,
  udm.API,
  API.Animation;

{$R *.dfm}

{ TBaseMain }

{$REGION ' UI/UX Design ...'}

constructor TBaseMain.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  UCL_PreConfig;
end;

procedure TBaseMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Owner = nil then
    Action := TCloseAction.caFree;
end;



procedure TBaseMain.Pnl_navbarMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, $F012, 0);
end;

procedure TBaseMain.UCL_PreConfig;
begin
  {$REGION '  UCL PreConfig .. '}
  Color := clWhite;
  with Font do
  begin
    Name := 'Poppins';
    Size := 10;
  end;
{$ENDREGION}
end;

{$ENDREGION}

procedure TBaseMain.FormShow(Sender: TObject);
begin
  dmAPI.Act_Lyt_Sending.Enabled := False;
  if not Assigned(fLytRef) then begin
    Btn_Config.Down := True;
    LytRef[TLyt_Config].ShowLayout;
  end;
end;

function TBaseMain.GetLyt(aLytClass: TBaseLytClass): I_BaseLayout;
var
 LWait: TWait;
begin
  if fLytRef <> nil then // if vRef is Still Allocated !!
  begin
    fLytRef.FinishLayout; // Interface Call !!

    if LWait.Wait(100) then // Very important to make sure if current vRef is destroyed completlly we add 100..!!
    fLytRef := aLytClass.New(nil, Pnl_Client);
  end else
  fLytRef := aLytClass.New(nil, Pnl_Client);

  Result := fLytRef;
end;

{$REGION '  Get Layouts Object ..''}
function TBaseMain.Get_DlgMsg: I_DlgMsg;
begin
  if Assigned(fDlgMsg) then Exit(fDlgMsg) else  Result := TLyt_DlgMsg.New(nil)
end;


function TBaseMain.Get_Msg: I_Msg;
begin
  if Assigned(fMsg) then Exit(fMsg) else  Result := TToast.New(nil,Self)
end;
{$ENDREGION}

{$REGION '  Get Layouts Object Reference ..'}

function TBaseMain.Get_LytConfig: TLyt_Config;
begin
  Result := (fLytRef as TLyt_Config);
end;

function TBaseMain.Get_LytSending: TLyt_Sending;
begin
  Result := (fLytRef as TLyt_Sending);
end;
{$ENDREGION}

end.
