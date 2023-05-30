unit Base.Lyt.Meta;

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
  Base.Lyt,
  API.Interf.Layouts;

type
  TBaseLytMeta = class(TBaseLyt, I_BaseLayout)
  private
    { Private declarations }
    procedure Slide_ShowLyt(aAfter: TProc = nil);
    procedure LytBounds;
  public
    { Public declarations }
    constructor Create(aOwner: TComponent; aParent: TWinControl); reintroduce; overload;
    destructor  Destroy; override;
    //====<< I_BaseLytMeta >>=====
    class function New(aOwner: TComponent; aParent: TWinControl): I_BaseLayout;
    function ShowLayout(aAfter: TProc = nil) : I_BaseLayout;
    function FinishLayout(aAfter: TProc = nil) : I_BaseLayout;
  end;

//var
//  BaseLytMeta: TBaseLytMeta;

implementation

uses
  API.Animation,
  API.Common;

{$R *.dfm}

{ TBaseLytMeta }

{$REGION '  UX Design ...'}

procedure TBaseLytMeta.LytBounds;
begin
  Align   := alCustom;
  Anchors := [akLeft, akTop, akRight, akBottom];
  SetBounds(0, 0, Parent.Width, Parent.Height);
end;

constructor TBaseLytMeta.Create(aOwner: TComponent; aParent: TWinControl);
begin
  inherited Create(aOwner);
  Parent := aParent;
end;

class function TBaseLytMeta.New(aOwner: TComponent; aParent: TWinControl): I_BaseLayout;
begin
  Result := Self.Create(aOwner, aParent);
end;

destructor TBaseLytMeta.Destroy;
begin
  inherited;
end;
{$ENDREGION}

function TBaseLytMeta.ShowLayout(aAfter: TProc = nil): I_BaseLayout;
begin
 with Result do
  try
    Preview;
    OnMouseDown := (parent as TPanel).OnMouseDown;
  finally
    Slide_ShowLyt(aAfter);    LytBounds;
  end;
  Result := Self;
end;

function TBaseLytMeta.FinishLayout(aAfter: TProc = nil): I_BaseLayout;
begin
  Close;
  //Self := nil;
end;


{$REGION '  slide/s...'}
procedure TBaseLytMeta.Slide_ShowLyt(aAfter: TProc = nil);
begin
  Show;
  if Assigned(aAfter) then
   Show_Effect(Self,
   procedure begin
      aAfter;
   end) else
  Show_Effect(Self);
end;
{$ENDREGION}

end.
