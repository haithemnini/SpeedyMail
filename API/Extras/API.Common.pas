unit API.Common;

interface

var
  SF: Single; // Global Screen Scale Factor

type
  TMsgKind    = (Tk_Success, Tk_Error, Tk_Info, Tk_Warn);
  TMsgDlgKind = (TkInfo, TkWarn, TkError, TkConfirm);
  TToastKind  = (tkShort, tkLong);

implementation

end.
