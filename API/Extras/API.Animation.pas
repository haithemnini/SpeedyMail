unit API.Animation;

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ExtCtrls,
// ThirdParty Units ...
  IKAnimation,
  IKTypes,
  se_ani,
  acWavPlayer,Vcl.Dialogs;
  //
  //UDimmer;

type
  TWaitTimerSec = record
  strict private
    fTimer: TTimer;
    fComplete: Boolean;
    procedure OnTimer(aSender: TObject);
  public
    function WaitTimer(aMillSec: Cardinal = 1000): Boolean;
  end;

  TWait = record
  strict private

  public
    function Wait(aMillSec: Cardinal; aSyncProc: TProc = nil): Boolean;
  end;

type
  TControlHelper = class helper for TControl
    function Get_Text: string;
    procedure Set_Text(const aValue: string);
  end;

  procedure DrawRounded(aControl: TWinControl; aRadius: Integer);

  procedure Animate_Transition(ACtrl: TControl; AANI: TseAnimation; AProc: TProc; AFinishEvent: TNotifyEvent = nil); overload;
  procedure Animate_Transition(ACtrl: TControl; AANI: TseAnimation; AProc: TProc; aPlayer: TacWavPlayer = nil; AFinishEvent: TNotifyEvent = nil); overload;
  procedure Animate_Ctrl(AObject: TObject; AProperty: String; AValue: Integer; ADuration: Double; AFinishProc: TProc = nil; aOnProcessEvent: TAnimationProcess = nil);

  /// <summary> don't call it inside form create block because FrmMain not created yet !! </summary>
 /// <remarks> this Method use this if statement check << if AForm = Application.MainForm  then >> </remarks>
  procedure Show_UP(AForm: TForm; aAfterFinish: TProc = nil);
  /// <summary> don't call it inside form create block because FrmMain not created yet !! </summary>
 /// <remarks> this Method use this if statement check << if AForm = Application.MainForm  then >> </remarks>
  procedure Show_Effect(AForm: TForm;   aAfterFinish: TProc = nil);
  procedure Show_Down(AForm:   TForm;   aAfterFinish: TProc = nil);
  procedure Hide_UP(AForm:     TForm;   aAfterFinish: TProc = nil);
  procedure Hide_Down(AForm:   TForm;   aAfterFinish: TProc = nil);

  procedure Show_Menu(aForm:    TForm;   aAfterFinish: TProc = nil);
  procedure Hide_Menu(aForm:   TForm;   aAfterFinish: TProc = nil);

  procedure Animate_ShowMsg(aForm: TForm; aParent: TWinControl; aAfterView: TProc = nil);
  procedure Animate_HideMsg(aForm: TForm; aAfterView: TProc = nil);

  procedure Animate_ShowDlgMsg(aForm: TForm; aAfterView: TProc = nil);
  procedure Animate_HideDlgMsg(aForm: TForm; aAfterView: TProc = nil);

  procedure Animate_ShowListMenu(aObject: TWinControl; aAfterView: TProc = nil);


implementation

uses
  Winapi.Messages,
  Winapi.Windows,
  System.Threading,
  System.Diagnostics, Winapi.ActiveX ;
  //
 // API.RefViews




procedure DrawRounded(aControl: TWinControl; aRadius: Integer);
var
  R: TRect;
  Rgn: HRGN;
begin
  with aControl do begin
    R := ClientRect;
    rgn := CreateRoundRectRgn(R.Left +1, R.Top +1, R.Right, R.Bottom, aRadius, aRadius) ;
    Perform(EM_GETRECT, 0, lParam(@r)) ;
    Winapi.Windows.InflateRect(R, - 2, - 2) ;

    Perform(EM_SETRECTNP, 0, lParam(@R)) ;
    SetWindowRgn(Handle, rgn, True) ;
    Invalidate;
   end;
end;

procedure Animate_Transition(ACtrl: TControl; AANI: TseAnimation; AProc: TProc; AFinishEvent: TNotifyEvent = nil);
begin
  with AANI do
  begin
    if Assigned(AFinishEvent) then  OnFinish := AFinishEvent;
    ForceControlUpdate := True;
    FreezeControlClient(ACtrl, ACtrl.ClientRect);
    try
      AProc;
      Execute;
    finally
      Restore;
    end;
  end;
end;
procedure Animate_Transition(ACtrl: TControl; AANI: TseAnimation; AProc: TProc; aPlayer: TacWavPlayer = nil; AFinishEvent: TNotifyEvent = nil);
begin
  with AANI do
  begin
    if Assigned(AFinishEvent) then  OnFinish := AFinishEvent;
    if Assigned(aPlayer) then  begin
      aPlayer.Asynchronous := True; // to async with Method below ..
      aPlayer.Play;
    end;
    ForceControlUpdate := True;
    FreezeControlClient(ACtrl, ACtrl.ClientRect);
    try
      AProc;
      Execute;
    finally
      Restore;
    end;
  end;
end;


procedure Animate_Ctrl(AObject: TObject; AProperty: String; AValue: Integer; ADuration: Double; AFinishProc: TProc = nil; aOnProcessEvent: TAnimationProcess = nil);
var
  Animation: TIKPropertyAnimation;
begin
  if Assigned(AFinishProc) then
  begin
    Animation := TIKPropertyAnimation.Create(AObject, AProperty, Avalue, AFinishProc);
  end else
    Animation := TIKPropertyAnimation.Create(AObject, AProperty, Avalue);

  Animation.Duration := ADuration / 1000;
  Animation.OnProcess := aOnProcessEvent;
//  Animation.OnFinish := AFinishEvent;
  Animation.FreeOnFinished := True;
  Animation.Start;
end;


procedure Show_UP(AForm: TForm; aAfterFinish: TProc = nil);

begin
   AForm.AlphaBlend := True;
  AForm.AlphaBlendValue := 0;

  if (AForm.Parent = nil) then begin
    AForm.Top  := (Screen.Height div 2) - (AForm.Height div 2) +100;
    AForm.Left := (Screen.Width div 2) - (AForm.Width div 2);

    Animate_CTRL(AForm, 'Top', (Screen.Height div 2) - (AForm.Height div 2), 300);

  end

  else if (AForm.Parent <> nil) then begin
    AForm.Top := -300;
    AForm.Left := 0;
    AForm.Width  := AForm.Parent.Width;
    AForm.Height := AForm.Parent.Height;
    Animate_CTRL(AForm, 'Top', 0, 300);
  end;

  if Assigned(aAfterFinish) then
    Animate_CTRL(AForm, 'AlphaBlendValue', 255, 300,
      procedure
      begin
        aAfterFinish;
      end) else Animate_CTRL(AForm, 'AlphaBlendValue', 255, 300);

end;




procedure Show_Down(AForm: TForm; aAfterFinish: TProc = nil);
begin
//  AForm.AlphaBlend := True;
//  AForm.AlphaBlendValue := 0;
//
//  if (AForm = vBView) then begin // or(AForm = fSplash)or(AForm = fLogIn)
//    AForm.Top  := (vBView.Height div 2) - (AForm.Height div 2) -100;
//    AForm.Left := (vBView.Width div 2) - (AForm.Width div 2);
//
//    Animate_CTRL(AForm, 'Top', (vBView.Height div 2) - (AForm.Height div 2), 300);
//  end else begin
//    AForm.Top  := (AForm.Parent.Height div 2) - (AForm.Height div 2) -100;
//    AForm.Left := (AForm.Parent.Width div 2) - (AForm.Width div 2);
//
//    Animate_CTRL(AForm, 'Top', (AForm.Parent.Height div 2) - (AForm.Height div 2), 300);
//  end;
//
//  if Assigned(aAfterFinish) then
//  Animate_CTRL(AForm, 'AlphaBlendValue', 250, 400,
//    procedure
//    begin
//      aAfterFinish
//    end) else
//  Animate_CTRL(AForm, 'AlphaBlendValue', 250, 400);
end;

procedure Show_Effect(aForm: TForm; aAfterFinish: TProc = nil);begin
  try
   aForm.AlphaBlend := True; aForm.AlphaBlendValue := 0;
  finally
   if Assigned(aAfterFinish) then
    Animate_Ctrl(aForm, 'AlphaBlendValue', 255, 300,
     procedure
      begin
        aAfterFinish;
      end) else
   Animate_Ctrl(aForm, 'AlphaBlendValue', 255, 300);
  end;
end;

procedure Animate_ShowListMenu(aObject: TWinControl; aAfterView: TProc = nil); begin


     //aObject.Left := -10;
     Animate_CTRL(aObject, 'Left', 0, 200);
     //Animate_Ctrl(aObject, 'AlphaBlendValue', 0, 300);


//   if Assigned(aAfterView) then
//
//    Animate_CTRL(aForm, 'AlphaBlendValue', 255, 300,
//      procedure
//      begin
//        aAfterView;
//      end) else Animate_CTRL(aForm, 'AlphaBlendValue', 255, 300);
//

end;



procedure Animate_ShowMsg(aForm: TForm; aParent: TWinControl; aAfterView: TProc = nil); begin
  try
    aForm.AlphaBlend := True;  aForm.AlphaBlendValue := 0;

    aForm.Top  := aForm.Top +(aForm.Height div 2) + 25;
    aForm.Left := (aParent.Width div 2) - (aForm.Width div 2);

    Animate_Ctrl(aForm, 'Top', aForm.Top - (aForm.Height div 2), 300);
  finally
   if Assigned(aAfterView) then
    Animate_Ctrl(aForm, 'AlphaBlendValue', 250, 300,
      procedure
      begin
        aAfterView;
      end) else Animate_Ctrl(aForm, 'AlphaBlendValue', 250, 300);

   aForm.Show;

  end;
end;


procedure Animate_HideMsg(aForm: TForm; aAfterView: TProc = nil);begin
  try
    AForm.AlphaBlend := True;
    Animate_CTRL(AForm, 'AlphaBlendValue', 0, 300);
  finally

   if Assigned(aAfterView) then
     Animate_CTRL(AForm, 'Top', AForm.Top +25, 300,
     procedure
      begin
        aAfterView;
      end) else
   Animate_CTRL(AForm, 'Top', AForm.Top +25, 300);

  end;

end;

procedure Animate_ShowDlgMsg(aForm: TForm; aAfterView: TProc = nil); begin
  try
    aForm.AlphaBlend := True;  aForm.AlphaBlendValue := 0;

    aForm.Top  := (Screen.Height div 2) - (aForm.Height div 2) - 50;
    aForm.Left := (Screen.Width div 2) - (aForm.Width div 2);

   Animate_CTRL(AForm, 'Top', (Screen.Height div 2) - (aForm.Height div 2), 300);
  finally
   if Assigned(aAfterView) then
    Animate_CTRL(aForm, 'AlphaBlendValue', 255, 300,
      procedure
      begin
        aAfterView;
      end) else Animate_CTRL(aForm, 'AlphaBlendValue', 255, 300);

  end;
end;

procedure Animate_HideDlgMsg(aForm: TForm; aAfterView: TProc = nil);begin
  try
    AForm.AlphaBlend := True;
    Animate_CTRL(AForm, 'AlphaBlendValue', 0, 300);
  finally

   if Assigned(aAfterView) then
     Animate_CTRL(AForm, 'Top', AForm.Top +50, 300,
     procedure
      begin
        aAfterView;
      end) else
   Animate_CTRL(AForm, 'Top', AForm.Top +50, 300);

  end;

end;



procedure Hide_UP(AForm: TForm; aAfterFinish: TProc = nil);
begin
  AForm.AlphaBlend := True;

  Animate_CTRL(AForm, 'AlphaBlendValue', 0, 400);

  if Assigned(aAfterFinish) then
  Animate_CTRL(AForm, 'Top', AForm.Top -100, 500,
    procedure
    begin
      aAfterFinish;
    end) else
  Animate_CTRL(AForm, 'Top', AForm.Top -100, 500);
end;

procedure Hide_Down(AForm: TForm; aAfterFinish: TProc = nil);
begin
  AForm.AlphaBlend := True;

  Animate_CTRL(AForm, 'AlphaBlendValue', 0, 300);
  if Assigned(aAfterFinish) then
  Animate_CTRL(AForm, 'Top', AForm.Top +100, 400,
    procedure
    begin
      aAfterFinish;
    end) else
  Animate_CTRL(AForm, 'Top', AForm.Top +100, 400);
end;



{$REGION '  Menu..'}

procedure Show_Menu(aForm: TForm; aAfterFinish: TProc = nil);
begin
  aForm.Left := - aForm.Width;
  AForm.AlphaBlend := True;
  AForm.AlphaBlendValue := 0;

  Animate_CTRL(AForm, 'AlphaBlendValue', 255, 300);

  if Assigned(aAfterFinish) then
    Animate_CTRL(aForm, 'Left',0, 250,
      procedure
      begin
        aAfterFinish
      end) else
  Animate_CTRL(aForm, 'Left',0, 250);

end;

procedure Hide_Menu(aForm: TForm; aAfterFinish: TProc = nil);
begin
  AForm.AlphaBlend := True;

  Animate_CTRL(AForm, 'AlphaBlendValue', 0, 300);
  if Assigned(aAfterFinish) then
    Animate_CTRL(AForm, 'Left', - aForm.Width, 300,
      procedure
      begin
        aAfterFinish;
      end) else
  Animate_CTRL(AForm, 'Left', - aForm.Width, 300);

end;
{$ENDREGION}

{ TWaitSecWhile }

procedure TWaitTimerSec.OnTimer(aSender: TObject);
begin
  fComplete := True;
end;

function TWaitTimerSec.WaitTimer(aMillSec: Cardinal = 1000): Boolean;
begin
  fTimer := TTimer.Create(nil);
  try
    fTimer.Interval := aMillSec;
    fTimer.OnTimer  := OnTimer;

    fComplete       := False;
    fTimer.Enabled  := True;

    while not fComplete do Application.ProcessMessages;
  finally
    fTimer.Free;
  end;

  Result := fComplete;
end;

{ TControlHelper }

function TControlHelper.Get_Text: string;
begin
  Result := Self.Text;  // TEXT PROPERTY IS inside PROTECTED Access Specifier in the base Class TCONTROL  ..
end;                    // We use this helper to get access to this value from tcontrol

procedure TControlHelper.Set_Text(const aValue: string);
begin
  Self.Text := aValue;  // TEXT PROPERTY IS inside PROTECTED Access Specifier in the base Class TCONTROL  ..
end;                    // We use this helper to get access to this value from tcontrol

{ TWait }

function TWait.Wait(aMillSec: Cardinal; aSyncProc: TProc): Boolean;
var
  vTask: ITask;
  LWaitWhile: TWaitTimerSec;
  LResultTimer: Boolean;

type
  TSync_Proc = ^TProc; // Work around to capture Symbole [aSyncProc]..
var
  P: Pointer;
  P_SyncProc: TSync_Proc;
  LProc: TProc;
begin
  LResultTimer := False;

  if Assigned(aSyncProc) then begin
    P := @aSyncProc;
    P_SyncProc := TSync_Proc(P);

    LProc := P_SyncProc^;
  end;

  vTask := TTask.Create(procedure begin

     if Assigned(LProc) then
       TThread.Synchronize(TThread.CurrentThread, procedure begin
           LProc;
         end);

     LResultTimer :=  LWaitWhile.WaitTimer(aMillSec); // plz don't use this Stupid: Sleep(1000); !!!

   end);

   vTask.ExecuteWork; // this will stop here.. until [vTask] finish work !!

   Result := LResultTimer;
end;

end.
