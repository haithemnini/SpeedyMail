unit Base.Lyt.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.ExtCtrls,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Dialogs,
  Vcl.Forms,
  //
  Base.Lyt.Meta, Vcl.StdCtrls, sLabel;

type
  TBaseLyt_Main = class(TBaseLytMeta)
    Pnl_Views: TPanel;
  private
    { Private declarations }
  protected
    procedure Preview; override;
  public
    { Public declarations }
  end;

// var
 // BaseMenu_Lyt: TBaseMenu_Lyt;

implementation

{$R *.dfm}

{ TBaseMenu_Lyt }


procedure TBaseLyt_Main.Preview;
begin
  inherited;
  Pnl_Views.OnMouseDown := (parent as TPanel).OnMouseDown;
//
end;


end.
