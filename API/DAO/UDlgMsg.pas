unit uDlgMsg;

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.Forms,
  Vcl.Controls,
  //
  Base.Msg,
  //
  Lyt.Dimmer;

type
  TMsgKind  = (Mk_info, Mk_warn, Mk_error, Mk_confirm, Mk_closeToTry);

  TDlg = class(TBaseMsg)
  private

  protected
    function  Prepare_Dlg: Boolean; override;
    procedure Ok_Click(Sender: TObject); override;
    procedure Cancel_Click(Sender: TObject); override;
  public
  end;

  function ShowDlgMsg(aMsg: string; aMsgKind: TMsgKind = mk_INFO): TModalResult;

implementation

uses
  Udm.Res;

function ShowDlgMsg(aMsg: string; aMsgKind: TMsgKind = mk_INFO): TModalResult;
var
  DlgMsg: TBaseMsg;
begin

  DlgMsg := TBaseMsg(TDlg.Create(nil));

  DlgMsg.Img_LogoDlg.Images     := dmRes.ImgLst_MsgDlg;
  DlgMsg.Img_LogoDlg.ImageIndex := -1;

  try
    DlgMsg.Lbl_Msg.Caption := aMsg;

    case aMsgKind of
      Mk_info:
      begin
        DlgMsg.Lbl_Title.Caption := 'Information';
        DlgMsg.Btn_ok.Caption := 'ok';
        DlgMsg.Btn_Cancel.Visible := False;
        DlgMsg.Img_LogoDlg.ImageIndex := 0;

      end;
      Mk_warn:
      begin
        DlgMsg.Lbl_Title.Caption := 'Warning';
        DlgMsg.Btn_ok.Caption := 'ok';
        DlgMsg.Btn_Cancel.Visible := False;
        DlgMsg.Img_LogoDlg.ImageIndex := 1;
      end;
      Mk_error:
      begin
        DlgMsg.Lbl_Title.Caption := 'Wrong';
        DlgMsg.Btn_ok.Caption := 'ok';
        DlgMsg.Btn_Cancel.Visible := False;
        DlgMsg.Img_LogoDlg.ImageIndex := 2;
      end;
      Mk_confirm:
      begin
//        DlgMsg.Btn_Cancel.Visible := False;
        DlgMsg.Lbl_Title.Caption := 'Confirmation';
        DlgMsg.Img_LogoDlg.ImageIndex := 0;
      end;
      Mk_closeToTry:
      begin
//        DlgMsg.Btn_Cancel.Visible := False;
        DlgMsg.Lbl_Title.Caption := 'Close To Try';
      end;
    end;


    //if Assigned(DlgMsg.Dimmer) then DlgMsg.Dimmer.ShowDimmer();
   //if Assigned(DlgMsg.Dimmer) then DlgMsg.Dimmer.ShowDimmer(Application.MainForm);


//    Center_Left := Application.MainForm.Left +
//                 ((Application.MainForm.Width div 2)-(DlgMsg.Width div 2));
//    Center_Top  := Application.MainForm.Top +
//                 ((Application.MainForm.Height div 2)-(DlgMsg.Height div 2));

  finally
    Result := DlgMsg.ShowModal;
  end;
end;

{ TDlg }

procedure TDlg.Cancel_Click(Sender: TObject);
begin
  inherited;
  MResult := mrCancel;
end;

procedure TDlg.Ok_Click(Sender: TObject);
begin
  inherited;
  MResult := mrOk;
end;

function TDlg.Prepare_Dlg: Boolean;
begin
  Result := True;
end;

end.

