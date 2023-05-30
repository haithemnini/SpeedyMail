unit Lyt.Dimmer;

interface

uses
  System.Classes,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Dialogs,
  //
  API.Interf.Layouts;

type
  TLyt_Dimmer = class(TForm, I_Dimmer)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormClick(Sender: TObject);
  private
     { Private declarations }
  public
    constructor Create(aOwner: TComponent; aParent: TWinControl); reintroduce; overload;
    destructor Destroy; override;
    //====<< I_Dimmer >>=====
    class function New(aOwner: TComponent; aParent: TWinControl) : I_Dimmer;
    function ShowDimmer: I_Dimmer;
    function HideDimmer: I_Dimmer;
  end;

implementation

uses
  API.Animation,
  udm.API;

{$R *.dfm}

{ TDimmer }

constructor TLyt_Dimmer.Create(aOwner: TComponent; aParent: TWinControl);
begin
  inherited Create(aOwner);  Parent := aParent;
  //Parent := TWincontrol(aParent); // This is Very important for SetBounds !!
end;

destructor TLyt_Dimmer.Destroy;
begin
  inherited;
end;

class function TLyt_Dimmer.New(aOwner: TComponent; aParent: TWinControl): I_Dimmer;
begin
  Result := Self.Create(aOwner,aParent);
end;

procedure TLyt_Dimmer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TLyt_Dimmer.FormClick(Sender: TObject);
begin
 // dmAPI.Act_MenuClose.Execute;
end;

function TLyt_Dimmer.ShowDimmer:I_Dimmer;
begin
 with Result do
  try
    Position    := poDefaultSizeOnly;
    BorderStyle := bsNone;
    Color       := clBlack ;//$7C7A79;
    Anchors     := [akLeft, akTop, akRight, akBottom];
    SetBounds(0, 0, Parent.Width, Parent.Height);
  finally
    Show;
    Animate_Ctrl(Self, 'AlphaBlendValue', 120,100);
  end;
  Result := Self;
end;

function TLyt_Dimmer.HideDimmer: I_Dimmer;
begin
  Close;  //Result := Self;
end;

end.
