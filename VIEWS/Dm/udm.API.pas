unit udm.API;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Actions,
  System.UITypes,
  Winapi.Windows,
  Winapi.Messages,
  scGPControls,
  ActnList,
  Dialogs,
  Forms,
//
  Base.Main;

type
  TdmAPI = class(TDataModule)
  {$REGION ' ...  '}
    ActLst_APP: TActionList;
    Act_CloseAPP: TAction;
    Act_Minimize: TAction;
    ActLst_1: TActionList;
    Act_Lyt_Config: TAction;
    Act_Lyt_Sending: TAction;
    Act_SaveData: TAction;
    Act_SendEmail: TAction;
    Act_1: TAction;
    procedure Act_CloseAPPExecute(Sender: TObject);
    procedure Act_MinimizeExecute(Sender: TObject);
    procedure Act_Lyt_ConfigExecute(Sender: TObject);
    procedure Act_Lyt_SendingExecute(Sender: TObject);
    procedure Act_SaveDataExecute(Sender: TObject);
    procedure Act_SendEmailExecute(Sender: TObject);
  {$ENDREGION}
  strict private
    fHost_SMTP,
    fPort, fEmail,
    fPassword, fTitleRecipient: string;
  private  { Private declarations }
     procedure Set_Host_SMTP(const aValue: string);
     procedure Set_Port(const aValue: string);
     procedure Set_Email(const aValue: string);
     procedure Set_Password(const aValue: string);
     procedure Set_TitleRecipient(const aValue: string);

     function SendEmail(const ToMail, Subject, MsgSend: string; aStartProc, aFinishProc: TProc): Boolean;
  public  { Public declarations }
    property Host_SMTP      : string  read fHost_SMTP      write Set_Host_SMTP   ;
    property Port           : string  read fPort           write Set_Port ;
    property Email          : string  read fEmail          write Set_Email;
    property Password       : string  read fPassword       write Set_Password ;
    property TitleRecipient : string  read fTitleRecipient write Set_TitleRecipient ;
//
    procedure GetConfig_Email;
 end;

var
  dmAPI: TdmAPI;
//
  Msg_Error: string;
  IsNotEmpty_Config : Boolean = False;

implementation

uses
  API.Consts,
  API.Common,
  API.Utils,
//
  API.Email,
//
  Lyt.Loading,
  Lyt.Config,
  Lyt.Sending;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{$REGION '...SubBtns  '}


procedure TdmAPI.Act_CloseAPPExecute(Sender: TObject);
begin
 with (Application.MainForm as TBaseMain) do
  if Lyt_DlgMsg.Show(Msg_CloseAPP , TkConfirm ) = mrOK then
    Screen.ActiveForm.Close;
end;

procedure TdmAPI.Act_MinimizeExecute(Sender: TObject);
begin
  Application.Minimize;
end;

{$ENDREGION}

function TdmAPI.SendEmail(const ToMail, Subject, MsgSend: string; aStartProc, aFinishProc: TProc): Boolean;
var
  aEmail_Sender: TEmailSender;
  ThreadResult: Boolean;
begin
  try
    // Validate parameters
    if (ToMail = '') or (Subject = '') or (MsgSend = '') or (not ValidateRegex(ToMail, Email_REGEX)) then
    begin
      // Handle invalid parameter(s) here
      Result := False;
      Exit;
    end;

    TThread.Queue(nil,
     procedure
      begin
        if Assigned(aStartProc) then
          aStartProc;
      end
    );

    aEmail_Sender := TEmailSender.Create(Host_SMTP, Email, Password, TitleRecipient, Port.ToInteger);

    try
      ThreadResult := aEmail_Sender.Send(ToMail, Subject, MsgSend);

      TThread.Queue(nil,
       procedure
        begin
          if Assigned(aFinishProc) then
            aFinishProc;
        end
      );
      Result := ThreadResult;
    finally
      aEmail_Sender.Free;
    end;
  except
    Result := False;
  end;
end;

procedure TdmAPI.Act_Lyt_ConfigExecute(Sender: TObject);
begin
  with(Application.MainForm as TBaseMain) do begin
    Btn_Config.Down := True;
    Lbl_Pagename.Caption := 'Email Configuration : ';
    LytRef[TLyt_Config].ShowLayout;
  end;
end;

procedure TdmAPI.Act_Lyt_SendingExecute(Sender: TObject);
begin
   with(Application.MainForm as TBaseMain) do begin
    Btn_Sending.Down := True;
    Lbl_Pagename.Caption := 'Sending Settings : ';
    LytRef[TLyt_Sending].ShowLayout;
  end;
end;

procedure TdmAPI.Act_SaveDataExecute(Sender: TObject);
begin
 try
  with (Application.MainForm as TBaseMain) do begin
   Set_Host_SMTP(Lyt_Config.Edt_Host_SMTP.Text);
   Set_Port(Lyt_Config.Edt_Port.Text);
   Set_Email(Lyt_Config.Edt_Email.Text);
   Set_Password(Lyt_Config.Edt_Password.Text);
   Set_TitleRecipient(Lyt_Config.Edt_TitleRecipient.Text);
  end;
 finally
   if Msg_Error <> '' then begin
    (Application.MainForm as TBaseMain).Lyt_Msg.Show(Msg_ErrorSaved, Tk_Error);
    Msg_Error :=  String.Empty; Abort;
   end;
  Act_Lyt_Sending.Enabled := True; IsNotEmpty_Config := True;
  Msg_Error :=  String.Empty;
  (Application.MainForm as TBaseMain).Lyt_Msg.Show(Msg_Saved, Tk_Success);// Abort;
 end;
end;

procedure TdmAPI.Act_SendEmailExecute(Sender: TObject);
var
  ToMail, Subject, MsgSend: string;
  Success: Boolean;
begin
  // Get values from UI elements
  ToMail  := Trim((Application.MainForm as TBaseMain).Lyt_Sending.Edt_ToEmail.Text);
  Subject := Trim((Application.MainForm as TBaseMain).Lyt_Sending.Edt_Subject.Text);
  MsgSend := Trim((Application.MainForm as TBaseMain).Lyt_Sending.Edt_Msg.Text);

  TThread.CreateAnonymousThread(
    procedure
    begin
      Success := SendEmail(ToMail, Subject, MsgSend,
       procedure
        begin
          // Start procedure
         {$REGION ' Start procedure  '}
          with (Application.MainForm as TBaseMain) do
          begin
            // Disable UI elements and show loading layout
            Act_Lyt_Config.Enabled := False;
            Pnl_SubBtns.Enabled := False;
            LytRef[TLyt_Loading].ShowLayout;
          end;
         {$ENDREGION}
        end,
       procedure
        begin
          // Finish procedure
         {$REGION ' Finish procedure  '}
         with (Application.MainForm as TBaseMain) do
          begin
            // Enable UI elements and show the sending layout
            Act_Lyt_Config.Enabled := True;
            Pnl_SubBtns.Enabled := True;
            LytRef[TLyt_Sending].ShowLayout;
          end;
         {$ENDREGION}
        end
      );

      TThread.Queue(nil,
        procedure
        begin
         with (Application.MainForm as TBaseMain) do
          begin
            // Check the value and display appropriate message
            if Success then
              Lyt_Msg.Show(Msg_SuccesSent, Tk_Success)
            else
              Lyt_Msg.Show(Msg_ErrorUnknown, Tk_Error);
          end;
        end
      );
    end
  ).Start;
end;






procedure TdmAPI.GetConfig_Email;
begin
 if IsNotEmpty_Config then begin
  with (Application.MainForm as TBaseMain) do begin
    Lyt_Config.Edt_Host_SMTP.Text := Host_SMTP;
    Lyt_Config.Edt_Port.Text      := Port;
    Lyt_Config.Edt_Email.Text     := Email;
    Lyt_Config.Edt_Password.Text  := Password;
    Lyt_Config.Edt_TitleRecipient.Text := TitleRecipient ;
  end;
 end;
end;

{$REGION ' ..Setter '}
procedure TdmAPI.Set_Host_SMTP(const aValue: string);
begin
 if not IsEmptyOrNull(aValue) then
  fHost_SMTP := aValue  else Msg_Error := Msg_ErrorSaved;
end;

procedure TdmAPI.Set_Port(const aValue: string);
begin
 if ValidateRegex(aValue, NumbersOnly_REGEX) then
   fPort := aValue else Msg_Error := Msg_ErrorSaved;
end;

procedure TdmAPI.Set_Email(const aValue: string);
begin
 if ValidateRegex(aValue, Email_REGEX) then
   fEmail := aValue else Msg_Error := Msg_ErrorSaved;
end;

procedure TdmAPI.Set_Password(const aValue: string);
begin
 if not IsEmptyOrNull(aValue) then
  fPassword := aValue  else Msg_Error := Msg_ErrorSaved;
end;

procedure TdmAPI.Set_TitleRecipient(const aValue: string);
begin
 if not IsEmptyOrNull(aValue) then
  fTitleRecipient := aValue  else Msg_Error := Msg_ErrorSaved;
end;
{$ENDREGION}

end.



