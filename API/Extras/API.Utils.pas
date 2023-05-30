unit API.Utils;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Param,
  System.NetEncoding, System.DateUtils,
  System.SysUtils, System.Variants,
  System.Classes, System.Hash,
  Vcl.Imaging.pngimage,
  Vcl.Controls, Vcl.ExtCtrls,
  Vcl.Dialogs, RegularExpressions,
  Winapi.Windows, sLabel,Data.DB,

{$REGION '  Uses in Send Email'}
  Wininet,IdComponent,IdTCPConnection,
  IdTCPClient, IdHTTP,
  IdBaseComponent, IdMessage,
  IdExplicitTLSClientServerBase,
  IdMessageClient,  IdSMTPBase,
  IdSMTP, IdIOHandler,
  IdIOHandlerSocket,
  IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL,
  IdAttachmentFile, IdText,
{$ENDREGION}

  API.Consts,
  API.Animation;

  function  Set_Sql_Text(aTableName: string; aSelect: string = '*'; aCondition: string = ''): string;
  function  ValidateRegex(aValueRegex,aValidationRegex: string): Boolean;
  function  IsInternetConnected: Boolean;
 // function  SendEmail(const aToAddress, aSubject: string): Boolean;
  function SendEmail(): Boolean;
  function  DayToday(TodayLang: array of string): string;
  function  DecEncodedBase64_PNG(const StringBase64: string): TPngImage;
  function  IsFieldValueExists(const aDataSet: TFDQuery; const aFieldName: string; const aFieldValue: Variant): Boolean;
  function  IsFieldValueExistsTWO(const aDataSet: TFDQuery; const aFieldName,aFieldNameTOW: string; const aFieldValue: Variant): Boolean;
  function  IsEmptyOrNull(const Value: Variant): Boolean;
  function  IsValiPass(const HashPass:string; aPass:string): Boolean;
  function  ForgetPwd(const aToAddress, aSubject: string): Boolean;
  function  Encrypt(aText:string):string;
  procedure Get_Date(aLabDate: TsImgLabel);
  procedure ThreadWithProc(aProcSend: TProc);


implementation


const
//MyKey = 'BraveSofts TEAM';
  MyAddress = 'web.bravesofts@gmail.com';
  Password  = 'wzdxkzcrvsfqdbyn';
  FromName  = 'BraveSofts';
  HostSMTP  = 'smtp.gmail.com';
  PortSMTP  = '465';

var
   Mail_Is_Sent: Boolean = False;

function Set_Sql_Text(aTableName: string; aSelect: string = '*'; aCondition: string = ''): string;
begin
  Result :=
   'SELECT '+ aSelect + #13#10 +
   'FROM '+ aTableName +' ' + aCondition + ' ORDER BY ID';
end;

procedure Get_Date(aLabDate: TsImgLabel);
begin
  aLabDate.Caption := DayToday(DateEn) ;
end;

function DayToday(TodayLang: array of string): string;
var
  DateNow : TDateTime;
begin
  DateNow := Now;
  Result := 'Today , ' + Format ('%.2d',[DayOf(DateNow)])+ ' '
                       + TodayLang[MonthOfTheYear(DateNow)-1] + ' '
                       + YearOf(DateNow).ToString ;    //Exp: Today , 10 June 2023
end;

procedure ThreadWithProc(aProcSend: TProc);
var
  MyThread: TThread;
begin
  MyThread := TThread.CreateAnonymousThread(
  procedure begin
    AProcSend;
    // MyThread.Synchronize(MyThread, AProc_Sync);
  end);
  MyThread.FreeOnTerminate := True;
  MyThread.Start;
end;

function IsInternetConnected: Boolean;
var
  dwConnectionTypes: DWORD;
begin
  dwConnectionTypes := INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN + INTERNET_CONNECTION_PROXY;
  Result := InternetGetConnectedState(@dwConnectionTypes, 0);
end;

function IsEmptyOrNull(const Value: Variant): Boolean;
begin
  Result := VarIsClear(Value) or VarIsEmpty(Value) or VarIsNull(Value) or (VarCompareValue(Value, Unassigned) = vrEqual);
  if (not Result) and VarIsStr(Value) then
    Result := Value = '';
end;

function ValidateRegex(aValueRegex, aValidationRegex: string): Boolean;
var
  RegEx: TRegEx;
begin
  RegEx := TRegex.Create(aValidationRegex);
  Result := RegEx.Match(aValueRegex).Success;
end;

function IsFieldValueExists(const aDataSet: TFDQuery; const aFieldName: string; const aFieldValue: Variant): Boolean;
var
  LookupValue: Variant;
begin
  LookupValue := aDataSet.Lookup(aFieldName, aFieldValue, aFieldName);
  Result := not VarIsNull(LookupValue);
end;

function IsFieldValueExistsTWO(const aDataSet: TFDQuery; const aFieldName,aFieldNameTOW: string; const aFieldValue: Variant): Boolean;
var
  LookupValue: Variant;
begin
  LookupValue := aDataSet.Lookup(aFieldName +';'+ aFieldNameTOW, aFieldValue, aFieldName);
  Result := not VarIsNull(LookupValue);
end;

function Encrypt(aText:string):string;
begin
  Result := UpperCase(THashMD5.GetHashString(UpperCase(aText)));
end;

function IsValiPass(const HashPass:string; aPass:string): Boolean;
begin
  Result := UpperCase(THashMD5.GetHashString(aPass)) = UpperCase(HashPass);
end;

function DecEncodedBase64_PNG(const StringBase64: string) : TPngImage;
var
  Input  : TStringStream;
  Output : TBytesStream;
begin
  Input := TStringStream.Create(StringBase64, TEncoding.ASCII);
  try
    Output := TBytesStream.Create;
    try
      TNetEncoding.Base64.Decode(Input, Output);
      Output.Position := 0;
      Result := TPngImage.Create;
      try
        Result.LoadFromStream(Output);
      except
        Result.Free;
        raise;
      end;
    finally
      Output.Free;
    end;
  finally
    Input.Free;
  end;
end;

function GenerateVerificationCode(const aLength: Integer): string;
const
  CharSequence = '0123456789';
var
  I, SequenceLength: Integer;
begin
  SequenceLength := Length(CharSequence);
  SetLength(Result, aLength);

  for I := 1 to aLength do
    Result[I] := CharSequence[Random(SequenceLength) + 1];
end;

function GenerateRecoveryEmailText(VerificationCode: string): string;
begin
  Result := '„—Õ»«°' + sLineBreak + sLineBreak +
    '·ﬁœ  ·ﬁÌ‰« ÿ·»« ·«” ⁄«œ… Õ”«»ﬂ. Ì—ÃÏ «” Œœ«„ «·—„“ «· «·Ì ·≈ﬂ„«· ⁄„·Ì… «” ⁄«œ… «·Õ”«»:' +
    sLineBreak + sLineBreak +
    '—„“ «· Õﬁﬁ: ' + VerificationCode + sLineBreak + sLineBreak +
    '≈–« ·„  ÿ·» «” ⁄«œ… «·Õ”«»° Ìı—ÃÏ  Ã«Â· Â–Â «·—”«·….' +
    sLineBreak + sLineBreak +
    '‘ﬂ—« ·ﬂ.';
end;

{$REGION ''}
//function SendEmail(const aToAddress, aSubject: string): Boolean;
//var
// SMTP: TIdSMTP;
// Msg : TIdMessage;
// SSL : TIdSSLIOHandlerSocketOpenSSL;
// IdText : TIdText;
// aBody  : string;
//begin
// SMTP := TIdSMTP.Create(nil);
// Msg  := TIdMessage.Create(nil);
// SSL  := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
//  try
//   // Check if an internet connection is available
////   if not IsInternetConnected then    begin
////     Result := False;  Exit; // No internet connection
////   end;
//
//   // SSL Processing Settings
//   SSL.SSLOptions.Method := sslvSSLv23;
//   SSL.SSLOptions.Mode   := sslmClient;
//
//   // Configure the Msg settings
//   Msg.CharSet                := 'utf-8';
//   Msg.Encoding               := meMIME;
//   Msg.Priority               := mpNormal;
//   Msg.From.Name              := FromName; // Message From Name
//   Msg.From.Address           := MyAddress; // Email the sender
//   Msg.Subject                := aSubject; // Message Subject
//
//   // add addressee in "IdMsg" settings
//   Msg.Recipients.Add;
//   Msg.Recipients.Add.Address := aToAddress;; // Email addressee
//
//   // Generate random code put into a variable at a level dmAPI.VerificationCode
//   dmAPI.VerificationCode := GenerateVerificationCode(6);
//
//   ShowMessage(dmAPI.VerificationCode);
//
//   // The VerificationCode sent to function GenerateRecoveryEmail to generate the aBody Msg
//   aBody := GenerateRecoveryEmailText(dmAPI.VerificationCode);
//
//   // Processing the content of the sent email
//   IdText := TIdText.Create(Msg.  MessageParts);
//   IdText.Body.Add(aBody);
//   IdText.ContentType := 'text/html; text/plain; charset=iso-8859-1';
//
//   // Configure the SMTP server settings
//   SMTP.IOHandler := SSL;
//   SMTP.UseTLS    := utUseImplicitTLS;
//   SMTP.AuthType  := satDefault;
//   SMTP.Host      := HostSMTP; // Replace your SMTP server address
//   SMTP.Port      := PortSMTP.toInteger;; // Replace the correct SMTP port
//   SMTP.Username  := MyAddress;   // Replace the Username SMTP
//   SMTP.Password  := Password;   // Replace the Password SMTP
//   SMTP.AuthType  := satDefault;
//
//   try
//    // send email
//    SMTP.Connect;
//    SMTP.Authenticate;
//
//            // «· ›ﬁœ „‰ √‰ «·√Ì„ «Ì· ’ÕÌÕ √„ ·«
//        SMTP.SendCmd('Helo ', 250);
//         if SMTP.Connected then
//       begin
//         try
//           SMTP.Send(Msg);
//           Result := True;
//         except on E:Exception do
//           begin
//             ShowMessage(': '+'Œÿ√ ›Ì „Õ«Ê·… «·≈—”«·' +#10+#13+ E.Message);
//           end;
//         end;
//       end;
//
//
//      // "SMTP" »⁄œ «·«‰ Â«¡ „‰ ﬂ· ‘Ì¡ ° «›’· „‰ Œ«œ„
//      while SMTP.Connected do
//      begin
//        SMTP.Disconnect;
//        Result := True; // "True" ›Ì Õ«·… «·‰Ã«Õ √⁄ÿÌ ‰ ÌÃ…
//      end;
//    IdText.Free;
//
//
////     try
////      SMTP.Send(Msg);
////      Result := True; // sent succesfully
////     finally
////      SMTP.Disconnect;
////     end;
//
//   except
//
//        on E: Exception do    begin
//         Result := False; // An error occurred while sending
//         // You can add error handling code here, eg showing an error message
//        end;
//
//   end;
//  finally
//   UnLoadOpenSSLLibrary;
//   SMTP.Free;
//   Msg.Free;
//   SSL.Free;
//  end;
//end;
{$ENDREGION}

function SendEmail(): Boolean;
var
  IdMsg   : TIdMessage;
  SMTP    : TIdSMTP;
  SSL     : TIdSSLIOHandlerSocketOpenSSL;
  IdText  : TIdText;
begin
  Mail_Is_Sent := False;
  // At RunTime // ≈‰‘«¡ «·„ﬂÊ‰«  «··«“„… ··⁄„·
  SMTP   := TIdSMTP.Create(nil);
  IdMsg  := TIdMessage.Create(nil);
  SSL    := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    try
      // "SSL"  ÃÂÌ“ ≈⁄œ«œ« 
      SSL.SSLOptions.Method := sslvSSLv23;
      SSL.SSLOptions.Mode   := sslmClient;

      // «·√Ê·Ì… Ê «·Œ«’… »«·„—”· "IdMsg"  ÃÂÌ“ ≈⁄œ«œ« 
      IdMsg.CharSet                   := 'utf-8';
      IdMsg.Encoding                  := meMIME;
      IdMsg.Priority                  := mpNormal;
      IdMsg.From.Name                 := '000';
      IdMsg.From.Address              := 'web.bravesofts@gmail.com';  // ≈Ì„«Ì· «·„—”·
      IdMsg.subject                   := 'hjjhgh'; // „Ê÷Ê⁄ «·—”«·…

      // add addressee in "IdMsg" settings
      IdMsg.Recipients.Add;
      IdMsg.Recipients.EMailAddresses  := 'haithem.nini20@gmail.com'; // ≈»„«Ì· «·„—”· ≈·ÌÂ


    //  ÃÂÌ“ „Õ ÊÏ «·≈Ì„«Ì· «·„—”·
      IdText := TIdText.Create(IdMsg.MessageParts);
      IdText.Body.Add('000');
      IdText.ContentType := 'text/html; text/plain; charset=iso-8859-1';

      // "SMTP"  ÃÂÌ“ ≈⁄œ«œ« 
      SMTP.IOHandler := SSL;
      SMTP.UseTLS    := utUseImplicitTLS;
      SMTP.AuthType  := satDefault;
      SMTP.Host      := 'smtp.gmail.com';
      SMTP.Port      := 465;
      SMTP.username  := 'web.bravesofts@gmail.com';
      SMTP.password  := 'wzdxkzcrvsfqdbyn';
      SMTP.AuthType  := satDefault;

      // «·»œ√ ›Ì «·√—”«·
        SMTP.Connect;
        SMTP.Authenticate;
        // «· ›ﬁœ „‰ √‰ «·√Ì„ «Ì· ’ÕÌÕ √„ ·«
        SMTP.SendCmd('Helo ', 250);

      //≈–« ‰ÃÕ «·« ’«· ° ›√—”· «·—”«·…
       if SMTP.Connected then
       begin
         try
           SMTP.Send(IdMsg);
         except on E:Exception do
           begin
             ShowMessage(': '+'Œÿ√ ›Ì „Õ«Ê·… «·≈—”«·' +#10+#13+ E.Message);
           end;
         end;
       end;

      // "SMTP" »⁄œ «·«‰ Â«¡ „‰ ﬂ· ‘Ì¡ ° «›’· „‰ Œ«œ„
        while SMTP.Connected do
        begin
          SMTP.Disconnect;
          Mail_Is_Sent := True; // "True" ›Ì Õ«·… «·‰Ã«Õ √⁄ÿÌ ‰ ÌÃ…
        end;
        IdText.Free;

    finally
      UnLoadOpenSSLLibrary;  // "SSL"  ›—Ì€ „Õ ÊÏ
      //  Õ—»— „Œ ·› «·„ﬂÊ‰«  «· Ì ≈‰‘√‰ Â« ”«»ﬁ«
      SMTP.Free;
      IdMsg.Free;
      SSL.Free;
    end;

  except on e:Exception do // "False" ›Ì Õ«·… «·Œÿ√  √⁄ÿÌ  ‰ ÌÃ…
    begin
      ShowMessage(': '+'Œÿ√ ›Ì „Õ«Ê·… «·√ ’«·' +#10+#13+ E.Message);
    end;
  end;
 Result := Mail_Is_Sent;
end;



function ForgetPwd(const aToAddress, aSubject: string): Boolean;
begin
// Result := False;
// dmAPI.View_Login.LogIN_LytRef[TLogIN_Lyt_Checking].ShowLayout;
 try
//  if not (Trim(aToAddress) <> '' ) then  begin
//   if not ValidateRegex(aToAddress, Email_REGEX) then
//    Result := False;  Exit;
//  end else  Result := False;  Exit;

  if SendEmail() then
       // Result := True      // Email sent successfully
       ShowMessage(' „ ≈—”«· «·»—Ìœ «·≈·ﬂ —Ê‰Ì »‰Ã«Õ.')
  else
      ShowMessage('ÕœÀ Œÿ√ √À‰«¡ ≈—”«· «·»—Ìœ «·≈·ﬂ —Ê‰Ì.');
//

//  if IsInternetConnected then
//    begin
//      if SendEmail() then
//       // Result := True      // Email sent successfully
//        ShowMessage(' „ ≈—”«· «·»—Ìœ «·≈·ﬂ —Ê‰Ì »‰Ã«Õ.')
//      else
//       ShowMessage('ÕœÀ Œÿ√ √À‰«¡ ≈—”«· «·»—Ìœ «·≈·ﬂ —Ê‰Ì.');
//    //  Result := False;  // An error occurred while sending the email
//    end
//  else//  Result := False;  Exit;   // No internet connection
//  ShowMessage('·« ÌÊÃœ « ’«· »«·≈‰ —‰ .');

 finally
  //
 end;
end;





end.
