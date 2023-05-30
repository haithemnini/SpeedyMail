unit Lyt.Loading;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Base.Lyt.Main, scControls, scGPControls,
  Vcl.ExtCtrls;

type
  TLyt_Loading = class(TBaseLyt_Main)
    Pnl_Loading: TPanel;
    scgpctvtybrLoadind_Bar: TscGPActivityBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  Lyt_Loading: TLyt_Loading;

implementation

{$R *.dfm}

end.
