unit Lyt.Config;

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
  Vcl.Dialogs,
  Vcl.ExtCtrls,
//
  Base.Lyt.Main, scControls, scGPControls, Vcl.StdCtrls, sLabel, Vcl.Mask,
  scGPExtControls ;

type
  TLyt_Config = class(TBaseLyt_Main)
  {$REGION ' ...Component '}
    Btn_Save: TscGPButton;
    Edt_Host_SMTP: TscGPEdit;
    Lbl_Address: TsImgLabel;
    Edt_Port: TscGPEdit;
    Lbl_Host_Port: TsImgLabel;
    Edt_Email: TscGPEdit;
    Lbl_Email: TsImgLabel;
    Edt_Password: TscGPEdit;
    Lbl_Password: TsImgLabel;
    Edt_TitleRecipient: TscGPEdit;
    Lbl_NameRecipient: TsImgLabel;
    procedure FormShow(Sender: TObject);
  {$ENDREGION}
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  Lyt_Email_Configuration: TLyt_Email_Configuration;

implementation

uses
  udm.API;

{$R *.dfm}

procedure TLyt_Config.FormShow(Sender: TObject);
begin
  inherited;
  dmAPI.GetConfig_Email;
end;

end.
