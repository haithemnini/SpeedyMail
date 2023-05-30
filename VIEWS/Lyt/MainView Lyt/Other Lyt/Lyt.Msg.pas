unit Lyt.Msg;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Forms,
//
  API.Interf.Layouts,
  API.Common, acPNG, se_image, Vcl.StdCtrls;

type
  TToast = class(TForm, I_Msg)
  {$REGION ' Component ...'}
    Timer_ShowMsg: TTimer;
    Img_KindMsg: TImage;
    Lbl_ColorMsg: TLabel;
  {$ENDREGION}
  {$REGION '...'}
    procedure Timer_ShowMsgTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  {$ENDREGION}
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(aOwner: TComponent; aParent: TWinControl); reintroduce; overload;
    destructor Destroy; override;
     //====<< I_Msg >>=====
    class function New(aOwner: TComponent; aParent: TWinControl): I_Msg;
    function Show(aMsg: string = ''; aMsgKind: TMsgKind = Tk_Success; aAfter: TProc = nil): I_Msg; overload;
  end;

//var
//  Lyt_Msg: TLyt_Msg;

implementation

uses
  API.Animation,
  API.Consts,
  API.Utils;

{$R *.dfm}

{ TLyt_Msg }

{$REGION ' UI/UX Design ...'}
constructor TToast.Create(aOwner: TComponent; aParent: TWinControl);
begin
  inherited Create(AOwner);
  Parent := aParent;
end;

destructor TToast.Destroy;
begin
  inherited;
end;

procedure TToast.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TToast.FormShow(Sender: TObject);
begin
  Timer_ShowMsg.Enabled := True;
end;

class function TToast.New(aOwner: TComponent; aParent: TWinControl): I_Msg;
begin
  Result := Self.Create(aOwner,aParent);
end;
{$ENDREGION}


function TToast.Show(aMsg: string = ''; aMsgKind: TMsgKind = Tk_Success;
  aAfter: TProc = nil): I_Msg;
begin
 with Result do
  try
   DrawRounded(Self, 5);

    case aMsgKind of
      Tk_Success : begin Lbl_ColorMsg.Caption := aMsg ;Lbl_ColorMsg.Color := $73CD2F; Color := $73CD2F; Img_KindMsg.Picture.Assign(DecEncodedBase64_PNG(IMGSuccess));end;
      Tk_Error   : begin Lbl_ColorMsg.Caption := aMsg ;Lbl_ColorMsg.Color := $4754DC; Color := $4754DC; Img_KindMsg.Picture.Assign(DecEncodedBase64_PNG(IMGError)); end;
      Tk_Info    : begin Lbl_ColorMsg.Caption := aMsg ;Lbl_ColorMsg.Color := $D08B50; Color := $D08B50; Img_KindMsg.Picture.Assign(DecEncodedBase64_PNG(IMGInfo)); end;
      Tk_Warn    : begin Lbl_ColorMsg.Caption := aMsg ;Lbl_ColorMsg.Color := $299EE7; Color := $299EE7; Img_KindMsg.Picture.Assign(DecEncodedBase64_PNG(IMGWarn));end;
    end;

  finally

   Animate_ShowMsg(Self,
     Parent,procedure begin
     //
     end);
  end;
  Result := Self;
end;


procedure TToast.Timer_ShowMsgTimer(Sender: TObject);
begin
 Animate_HideMsg(Self,
  procedure begin
    Timer_ShowMsg.Enabled := False;
    Close;
  end);
end;



end.
