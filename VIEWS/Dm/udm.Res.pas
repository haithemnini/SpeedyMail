unit udm.Res;

interface

uses
  System.SysUtils,
  System.Classes,
  System.ImageList,
  Vcl.ImgList,
  Vcl.Controls,
//
  PngImageList;

type
  TdmRes = class(TDataModule)
    ImgLst_SubBtn: TPngImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmRes: TdmRes;

implementation


{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}


end.
