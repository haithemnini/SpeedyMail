unit Lyt.DlgMsg;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Controls,
  Vcl.AppEvnts,
  Vcl.Dialogs,
  Vcl.Forms,
//
  UCL.Form,
//
  scControls,acImage,
  scGPControls,sLabel,
//
  API.Interf.Layouts,
  API.Common;

type
  TLyt_DlgMsg = class(TUForm, I_DlgMsg)
  {$REGION ' Component ...'}
    Pnl_MsgDlg: TPanel;
    Pnl_Btns: TPanel;
    Pnl_navbar: TPanel;
    Pnl_Line_navbar: TPanel;
    Lbl_KindName: TsImgLabel;
    Pnl_Msg: TPanel;
    Lbl_Msg: TsImgLabel;
    AppEvents: TApplicationEvents;
    Pnl_Line_Btns: TPanel;
    Btn_Cancel: TscGPButton;
    Btn_Ok: TscGPButton;
    procedure Pnl_navbarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AppEventsActivate(Sender: TObject);
    procedure AppEventsRestore(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  {$ENDREGION}
  private
     fModalResult: TModalResult;
    { Private declarations }
    function  Set_CanClose: Boolean;
    procedure OkClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure UCL_PreConfig;
  public
    constructor Create(aOwner: TComponent); override; //reintroduce; overload;
    destructor Destroy; override;
    { Public declarations }
    property MResult: TModalResult read fModalResult write fModalResult;
     //====<< I_DlgMsg >>=====
    class function New(aOwner: TComponent): I_DlgMsg;
    function Show(aMsg: string = ''; aMsgKind: TMsgDlgKind = tkInfo; aAfter: TProc = nil): TModalResult; overload;
  end;

//var
//  Lyt_DlgMsg: TLyt_DlgMsg;

var
  lBaseCloseAction: TCloseAction = TCloseAction.caNone;
  FirstCall_Done: Boolean = False;

implementation

{$R *.dfm}

uses
//  Base.Main,
  API.Animation;

{ TLyt_DlgMsg }

{$REGION ' UI/UX Design ...'}
procedure TLyt_DlgMsg.AppEventsActivate(Sender: TObject);
begin
  if Assigned(Self) then Self.FormStyle := fsStayOnTop;
end;

procedure TLyt_DlgMsg.AppEventsRestore(Sender: TObject);
begin
  if Assigned(Self) then Self.FormStyle := fsStayOnTop;
end;

constructor TLyt_DlgMsg.Create(aOwner: TComponent);
begin
  inherited Create(AOwner);
  UCL_PreConfig;
end;

destructor TLyt_DlgMsg.Destroy;
begin
  inherited;
end;

class function TLyt_DlgMsg.New(aOwner: TComponent): I_DlgMsg;
begin
 Result := Self.Create(aOwner);
end;

procedure TLyt_DlgMsg.Pnl_navbarMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Perform(WM_SYSCOMMAND, $F012, 0);
end;

procedure TLyt_DlgMsg.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13)or(Key=#32) then Btn_Ok.Down := True;
  if  Key=#27 then             Btn_Cancel.Down := True;
end;

procedure TLyt_DlgMsg.UCL_PreConfig;
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

{$REGION ' ModalResult Btn/s ...'}
procedure TLyt_DlgMsg.CancelClick(Sender: TObject);
begin
  MResult := mrCancel;
end;

procedure TLyt_DlgMsg.OkClick(Sender: TObject);
begin
  MResult := mrOk;
end;

{$ENDREGION}


function TLyt_DlgMsg.Set_CanClose: Boolean;
begin
  if not FirstCall_Done then begin
    Animate_HideDlgMsg(Self,
      procedure
      begin
        lBaseCloseAction := TCloseAction.caFree;
        ModalResult := fModalResult;
      end);
  end;
  Result := True;
end;

procedure TLyt_DlgMsg.FormCreate(Sender: TObject);
begin
  lBaseCloseAction := TCloseAction.caNone;
  FirstCall_Done   := False;

  ModalResult := mrNone;
  fModalResult := ModalResult; // Update fModalResult;

  //Click Btn_ok & Btn_Cancel
  Btn_ok.OnClick     := OkClick;
  Btn_Cancel.OnClick := CancelClick;
end;


procedure TLyt_DlgMsg.FormShow(Sender: TObject);
begin
  Animate_ShowDlgMsg(Self,
    procedure
    begin
      //(Application.MainForm as TBaseMain).Lyt_Dimmer.ShowDimmer;
    end);
end;

procedure TLyt_DlgMsg.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Set_CanClose; FirstCall_Done := True; // Very Important workaround ..
  Action := lBaseCloseAction; // ModalResult Will be changed to mrNone ( go see vcl.Forms => CloseModal Procedure)
end;

function TLyt_DlgMsg.Show(aMsg: string; aMsgKind: TMsgDlgKind; aAfter: TProc): TModalResult; begin
  try

   Lbl_Msg.Caption := aMsg;

    case aMsgKind of
      TkInfo:     begin
        Lbl_KindName.Caption := 'Information';
        Btn_ok.Caption := 'ok';
      end;

      TkWarn:    begin
        Lbl_KindName.Caption := 'Warning';
        Btn_ok.Caption := 'ok';
        Btn_Cancel.Visible := False;
      end;

      TkError:     begin
        Lbl_KindName.Caption := 'Wrong';
        Btn_ok.Caption := 'ok';
        Btn_Cancel.Visible := False;
      end;

      TkConfirm:     begin
        Lbl_KindName.Caption := 'Confirmation';
      end;
    end;

  finally
    Result := Self.ShowModal;
  end;
end;

end.
