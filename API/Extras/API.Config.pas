unit API.Config;

interface

type
  TConfig = record
   Host_SMTP, Email, Password, TitleRecipient : string;
   Port : Integer;
   IsEmpty : Boolean;
  end;

implementation


end.
