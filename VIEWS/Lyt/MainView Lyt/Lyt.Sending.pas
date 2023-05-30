unit Lyt.Sending;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
//
  sLabel, scControls,
  scGPControls,
//
  Base.Lyt.Main, Vcl.Mask, scGPExtControls;

type
  TLyt_Sending = class(TBaseLyt_Main)
    Btn_Send: TscGPButton;
    Edt_ToEmail: TscGPEdit;
    Lbl_To: TsImgLabel;
    Edt_Subject: TscGPEdit;
    Lbl_Subject: TsImgLabel;
    Edt_Msg: TscGPEdit;
    Lbl_2: TsImgLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  Lyt_Dashboard: TLyt_Dashboard;

implementation

uses
  udm.API;

{$R *.dfm}

{ TLytDashboard }

end.
