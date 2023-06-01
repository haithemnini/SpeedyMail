program SpeedyMail;

uses
  FastMM4 in 'API\FastMM4\FastMM4.pas',
  FastMM4Messages in 'API\FastMM4\FastMM4Messages.pas',
  Forms,
  udm.API in 'VIEWS\Dm\udm.API.pas' {dmAPI: TDataModule},
  udm.Res in 'VIEWS\Dm\udm.Res.pas' {dmRes: TDataModule},
  API.Email in 'API\Extras\API.Email.pas',
  API.Animation in 'API\Extras\API.Animation.pas',
  API.Utils in 'API\Extras\API.Utils.pas',
  API.Common in 'API\Extras\API.Common.pas',
  API.Config in 'API\Extras\API.Config.pas',
  API.Consts in 'API\Extras\API.Consts.pas',
  API.Ref.Lyt in 'API\Extras\API.Ref.Lyt.pas',
  API.Ref.Views in 'API\Extras\API.Ref.Views.pas',
  API.Interf.Layouts in 'API\Interfaces\API.Interf.Layouts.pas',
  Base.Lyt in 'VIEWS\Abs\Base.Lyt.pas' {BaseLyt},
  Base.Lyt.Meta in 'VIEWS\Abs\Base Meta\Base.Lyt.Meta.pas' {BaseLytMeta},
  Base.Lyt.Main in 'VIEWS\Abs\Base Lyt\Base.Lyt.Main.pas' {BaseLyt_Main},
  Lyt.Dimmer in 'VIEWS\Lyt\MainView Lyt\Other Lyt\Lyt.Dimmer.pas' {Lyt_Dimmer},
  Lyt.DlgMsg in 'VIEWS\Lyt\MainView Lyt\Other Lyt\Lyt.DlgMsg.pas' {Lyt_DlgMsg},
  Lyt.Msg in 'VIEWS\Lyt\MainView Lyt\Other Lyt\Lyt.Msg.pas' {Toast},
  Lyt.Config in 'VIEWS\Lyt\MainView Lyt\Lyt.Config.pas' {Lyt_Config},
  Lyt.Sending in 'VIEWS\Lyt\MainView Lyt\Lyt.Sending.pas' {Lyt_Sending},
   Lyt.Loading in 'VIEWS\Lyt\MainView Lyt\Lyt.Loading.pas' {Lyt_Loading},
  Base.Main in 'VIEWS\Abs\Base.Main.pas' {BaseMain},
  Main in 'Main.pas' {fMain};

{$R *.res}

begin
 // ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  //dmAPI & dmRes
  Application.CreateForm(TdmAPI, dmAPI);
  Application.CreateForm(TdmRes, dmRes);
  //dmAPI & dmRes

  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
