program MaisVida;

uses
  System.StartUpCopy,
  FMX.Forms,
  ufrmPrincipal in 'src\ufrmPrincipal.pas' {frmPrincipal},
  uStyle in 'src\style\uStyle.pas',
  uDm in 'uDm.pas' {dm: TDataModule},
  uFrmEntrega in 'src\uFrmEntrega.pas' {frmEntrega},
  ufrmPerfil in 'src\ufrmPerfil.pas' {frmPerfil},
  uFancyDialog in 'src\uFancyDialog.pas',
  Loading in 'src\Loading.pas',
  ufrmMaps in 'src\ufrmMaps.pas' {frmMaps},
  u99Permissions in 'u99Permissions.pas',
  uFmxSlide in 'src\uFmxSlide.pas',
  FMX.Slides in 'src\FMX.Slides.pas',
  uFrmStatus in 'src\uFrmStatus.pas' {frmStatus};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];

