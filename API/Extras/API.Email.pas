unit API.Email;

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.StdCtrls,
  RegularExpressions,
//
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdBaseComponent,
  IdMessage,
  IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  IdSMTP,
  IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL,
  IdSSLOpenSSL,
  IdAttachmentFile,
  IdText;

type
  TSMTP_Config = record
    fServerHost: string;
    fPort: Integer;
  end;

  TAppEmail_Config = record
    fEmail,
    fPassword,
    fAppName: string;
  end;

  TUserEmail_Msg = record
    fUserEmail,
    fMsgSubject,
    fMsg: string;
    procedure Clear;
  end;

  TEmailSender = class
  private
    fSMTP: TSMTP_Config;
    fAppEmail: TAppEmail_Config;
    fUserMsg: TUserEmail_Msg;
    // Components of Indy component ..
    f_IdMsg: TIdMessage;
    f_SMTP: TIdSMTP;
    f_SSL: TIdSSLIOHandlerSocketOpenSSL;
    f_IdText: TIdText;
    fMail_Is_Sent: Boolean;
  public
    constructor Create(aSMTP_Host, aEmailSender, aEmailSender_Password, aEmailSender_Name: string; aSMTP_Port: Cardinal);
    destructor Destroy; override;
    function Send(aTarget_Email, aEmail_SubjectMsg, aBodyMsg_Email: string; aAttachedFilePath: string = ''): Boolean;
  end;

const
   Email_REGEX  = '^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';

implementation

procedure Send_WithThread(AProcSend: TProc);
var
  MyThread: TThread;
begin
  MyThread := TThread.CreateAnonymousThread(
    procedure
    begin
      AProcSend;
      // MyThread.Synchronize(MyThread, AProc_Sync);
    end);
  MyThread.FreeOnTerminate := True;
  MyThread.Start;
end;

{ TEmailSender }

constructor TEmailSender.Create(aSMTP_Host, aEmailSender, aEmailSender_Password, aEmailSender_Name: string; aSMTP_Port: Cardinal);
begin
  inherited create;

  // SMTP SERVER settings
  fSMTP.fServerHost := aSMTP_Host; //'smtp.gmail.com';
  fSMTP.fPort := aSMTP_Port; //465;

  // sender settings for application email
  fAppEmail.fEmail := aEmailSender; //'web.bravesofts@gmail.com';
  fAppEmail.fPassword := aEmailSender_Password; //'wzdxkzcrvsfqdbyn';
  fAppEmail.fAppName := aEmailSender_Name; //'GBank APP';

  // Set up the components needed to run at runtime
  f_SMTP := TIdSMTP.Create(nil);
  f_IdMsg := TIdMessage.Create(nil);
  f_SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    // Processing SSL settings
    f_SSL.SSLOptions.Method := sslvSSLv23;
    f_SSL.SSLOptions.Mode := sslmClient;

    // Prepare the initial sender settings for the sender
    f_IdMsg.CharSet := 'utf-8';
    f_IdMsg.Encoding := meMIME;
    f_IdMsg.Priority := mpNormal;
    f_IdMsg.From.Address := fAppEmail.fEmail;  // sender's email
    f_IdMsg.From.Name := fAppEmail.fAppName; // The name of the sender that the recipient knows
  finally
    //  ÃÂÌ“ ≈⁄œ«œ«  SMTP
    f_SMTP.IOHandler := f_SSL;
    f_SMTP.UseTLS := utUseImplicitTLS;
    f_SMTP.AuthType := satDefault;
    f_SMTP.Host := fSMTP.fServerHost;
    f_SMTP.Port := fSMTP.fPort;
    f_SMTP.username := fAppEmail.fEmail;
    f_SMTP.password := fAppEmail.fPassword;
    f_SMTP.AuthType := satDefault;
  end;
end;

destructor TEmailSender.Destroy;
begin
  f_IdText.Free;
  UnLoadOpenSSLLibrary;  // Dump content for SSL
  // Edit the various components created earlier
  f_SMTP.Free;
  f_IdMsg.Free;
  f_SSL.Free;
  inherited;
end;

function TEmailSender.Send(aTarget_Email, aEmail_SubjectMsg, aBodyMsg_Email: string; aAttachedFilePath: string = ''): Boolean;
begin
  fMail_Is_Sent := False;

  if (aTarget_Email <> '') and (aEmail_SubjectMsg <> '') and (aBodyMsg_Email <> '') then
  begin
    // Check if the email address is valid using a suitable regular expression (Email_REGEX)
    if TRegEx.IsMatch(aTarget_Email, Email_REGEX) then    begin
      // Proceed if all the required conditions are met

      // Set the parameter values
      fUserMsg.fUserEmail := aTarget_Email;
      fUserMsg.fMsgSubject := aEmail_SubjectMsg;
      fUserMsg.fMsg := aBodyMsg_Email;

      // Set the email subject
      f_IdMsg.subject := fUserMsg.fMsgSubject;

      // Add the recipient
      f_IdMsg.Recipients.Add;
      f_IdMsg.Recipients.EMailAddresses := fUserMsg.fUserEmail;

      // Create the email body
      f_IdText := TIdText.Create(f_IdMsg.MessageParts);
      f_IdText.Body.Add(fUserMsg.fMsg);
      f_IdText.ContentType := 'text/html; text/plain; charset=iso-8859-1';

      try
        // Connect to the SMTP server and authenticate
        f_SMTP.Connect;
        f_SMTP.Authenticate;

        // Attach the file if a path is provided
        if aAttachedFilePath <> EmptyStr then   begin
          if FileExists(aAttachedFilePath) then
          begin
            TIdAttachmentFile.Create(f_IdMsg.MessageParts, aAttachedFilePath);
          end;
        end;

        // Send the message
        if f_SMTP.Connected then  begin
          try
            f_SMTP.Send(f_IdMsg);
            fMail_Is_Sent := True;
          except
            fMail_Is_Sent := False;
          end;
        end;

        // Disconnect from the SMTP server
        while f_SMTP.Connected do  begin
          f_SMTP.Disconnect;
        end;
      except
        fMail_Is_Sent := False;
      end;
    end else  begin       // Return false if the email address is invalid
      Result := False;
      Exit;
    end;
  end else  begin     // Return false if any of the parameters are empty
    Result := False;
    Exit;
  end;

  Result := fMail_Is_Sent;
end;


{ TUserEmail_Msg }

procedure TUserEmail_Msg.Clear;
begin
  fUserEmail  := EmptyStr;
  fMsgSubject := EmptyStr;
  fMsg        := EmptyStr;
end;

end.

