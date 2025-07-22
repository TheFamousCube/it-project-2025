unit mainScreen_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Skia, Vcl.ExtCtrls, logicEditor;

type
  TfrmStart = class(TForm)
    imgPlay: TImage;
    imgSettings: TImage;
    imgQuit: TImage;
    procedure FormCreate(Sender: TObject);
    procedure imgPlayClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function LoadResourceFont(const ResourceName: string): Boolean;
    procedure imgQuitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStart: TfrmStart;
  frmGame : TfrmGame;

implementation

{$R *.dfm}

procedure TfrmStart.FormCreate(Sender: TObject);
begin
  AllocConsole;
  //LoadResourceFont('Adlam.ttf');
  //AddFontResource(PChar('Adlam.ttf'));
end;

procedure TfrmStart.FormResize(Sender: TObject);
begin
  imgPlay.Left := (frmStart.ClientWidth div 2) - (imgPlay.Width div 2);
  imgPlay.Top := (frmStart.ClientHeight div 7);
  imgSettings.Left := (frmStart.ClientWidth div 2) - (imgSettings.Width div 2);
  imgSettings.Top := (frmStart.ClientHeight div 7) * 3;
  imgQuit.Left := (frmStart.ClientWidth div 2) - (imgQuit.Width div 2);
  imgQuit.Top := (frmStart.ClientHeight div 7) * 5;
end;

procedure TfrmStart.FormShow(Sender: TObject);
begin
  frmStart.WindowState := TWindowState.wsMaximized;
  with Screen.MonitorFromWindow(frmStart.Handle).WorkAreaRect do
    frmStart.SetBounds(Left, Top, Right - Left, Bottom - Top);
end;

procedure TfrmStart.imgPlayClick(Sender: TObject);
begin
  //frmGame := TfrmGame.Create(nil);
  frmGame.Show;
  frmStart.Hide;
end;

procedure TfrmStart.imgQuitClick(Sender: TObject);
begin
  Application.Terminate;
end;

function TfrmStart.LoadResourceFont(const ResourceName: string): Boolean;
var
  ResStream: TResourceStream;
  FontsCount: Integer;
  hFont: THandle;
begin
  ResStream := TResourceStream.Create(hInstance, ResourceName, RT_RCDATA);
  hFont := AddFontMemResourceEx(ResStream.Memory, ResStream.Size, nil, @FontsCount);
  Result := (hFont <> 0);
  ResStream.Free;
end;

end.
