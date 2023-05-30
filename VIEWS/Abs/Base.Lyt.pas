unit Base.Lyt;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.StdCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Graphics,
  Vcl.Dialogs,
  Vcl.Forms;

type
  TBaseLyt = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  protected
    procedure Preview; virtual; abstract;
  public
    { Public declarations }
  end;

//var
//  BaseLayout: TBaseLayout;

implementation

{$R *.dfm}

{ TBaseLayout }


procedure TBaseLyt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Owner = nil then
    Action := TCloseAction.caFree;
end;

end.
