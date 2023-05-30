unit Lyt.Loading;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Dialogs,
  Vcl.Forms,
//
  scGPControls,
  scControls,
//
  API.Interf.Layouts;

type
  TLyt_Loading = class(TForm, I_Loading)
  {$REGION 'Component'}
    Timer_Loading: TTimer;
    Pnl_Loading: TPanel;
    Loadind_Bar: TscGPActivityBar;
    procedure FormShow(Sender: TObject);
    procedure Timer_LoadingTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  {$ENDREGION}
  private
   { Public declarations }
  public
    { Public declarations }
    constructor Create(aOwner: TComponent; aParent: TWinControl); reintroduce; overload;
    destructor  Destroy; override;
    //====<< I_Loading >>=====
    class function New(aOwner: TComponent; aParent: TWinControl): I_Loading;
    function ShowLoading(aLoadingTime: Cardinal = 2500) : I_Loading;
  end;

//var
//  Lyt_Loading: TLyt_Loading;

implementation

uses
//  udm.Res,
  Base.Main;

{$R *.dfm}

constructor TLyt_Loading.Create(aOwner: TComponent; aParent: TWinControl);
begin
  inherited Create(aOwner);

  Parent := aParent;
end;

class function TLyt_Loading.New(aOwner: TComponent; aParent: TWinControl): I_Loading;
begin
  Result := Self.Create(aOwner, aParent);
end;

destructor TLyt_Loading.Destroy;
begin
  inherited;
end;

procedure TLyt_Loading.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree; // free this form when calling close ...
  // never use this with Object of type Interface  and don't provide allocating of object each time you call this window !!!
end;

procedure TLyt_Loading.FormShow(Sender: TObject);
begin
  Timer_Loading.Enabled := True;
  Loadind_Bar.Active    := True;
end;

function TLyt_Loading.ShowLoading(aLoadingTime: Cardinal = 2500): I_Loading;
begin
  with Result do
  try
    Position    := poDefaultSizeOnly;
    BorderStyle := bsNone;
    Color       := clWhite;
    Anchors     := [akLeft, akTop, akRight, akBottom];
    //Screen.Cursor := crHourGlass;
    SetBounds(0, 0, Parent.Width, Parent.Height);
    Timer_Loading.Interval := aLoadingTime;
  finally
    Show;
  end;
  Result := Self;

end;

procedure TLyt_Loading.Timer_LoadingTimer(Sender: TObject);
begin
  Timer_Loading.Enabled := False;
  Loadind_Bar.Active    := False;
  //Screen.Cursor := crDefault;

  with(Application.MainForm as TBaseMain) do begin
    Pnl_Loading.Visible := False;
  end;

  Close;
end;

end.
