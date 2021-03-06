unit ufrmMaps;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Maps, System.Sensors,
  System.Sensors.Components,FMX.DialogService,ufancyDialog;

type
  TfrmMaps = class(TForm)
    MapView1: TMapView;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Image1: TImage;
    btnConfirmarLocal: TRectangle;
    Label2: TLabel;
    LocationSensor1: TLocationSensor;
    Image2: TImage;
    Image3: TImage;
    Timer1: TTimer;
    Rectangle2: TRectangle;
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation,
      NewLocation: TLocationCoord2D);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnConfirmarLocalClick(Sender: TObject);
  private
    Location: TLocationCoord2D;
    Fgeocoder:Tgeocoder;
    procedure onGeocodeReverseEvent(const Address:TCivicAddress);
    { Private declarations }
  public
    diag:TfancyDialog;
    { Public declarations }
  end;

var
  frmMaps: TfrmMaps;

implementation

uses
  ufrmPrincipal, uStyle, ufrmPerfil, uDm;

{$R *.fmx}

procedure TfrmMaps.btnConfirmarLocalClick(Sender: TObject);
begin
  try
    // Tratando a instancia TGeocoder...
    if not Assigned(FGeocoder) then
    begin
            if Assigned(TGeocoder.Current) then
                    FGeocoder := TGeocoder.Current.Create;

            if Assigned(FGeocoder) then
                    FGeocoder.OnGeocodeReverse := OnGeocodeReverseEvent;
    end;

    // Tratar a traducao do endereco...
    if Assigned(FGeocoder) and not FGeocoder.Geocoding then
            FGeocoder.GeocodeReverse(Location);
  except
    showmessage('Erro no servi?o Geocoder');
  end;

end;

procedure TfrmMaps.FormCreate(Sender: TObject);
var posicao :TMapCoordinate;
begin
   btnConfirmarLocal.Fill.Color :=  PRIMARY;
   Rectangle1.Fill.Color := PRIMARY;
   MapView1.MapType := TMapType.Normal;

   //Centraliza mapa


   posicao.Latitude  := -7.955424741681496;
   posicao.Longitude := -35.095356638110275;
   MapView1.Location := posicao;

   //Zoom
   MapView1.Zoom := 11;
   Image3.Visible := false;

end;

procedure TfrmMaps.FormShow(Sender: TObject);
begin
  Timer1.Enabled := true;
end;

procedure TfrmMaps.Image1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmMaps.LocationSensor1LocationChanged(Sender: TObject;
  const OldLocation, NewLocation: TLocationCoord2D);
var
        posicao : TMapCoordinate;
        marcador : TMapMarkerDescriptor;
begin


        LocationSensor1.Active := false;

        // Obtem nova localizacao...
        Location := NewLocation;
        posicao.Latitude := NewLocation.Latitude;
        posicao.Longitude := NewLocation.Longitude;

        // Criar o marcador...
        marcador := TMapMarkerDescriptor.Create(posicao, '');
        marcador.Snippet := '';
        marcador.Visible := true;

        // Icone do marcador...
        marcador.Icon := Image3.Bitmap;

        // Adiciona marcardor no mapa...
        MapView1.AddMarker(marcador);

        // Centraliza mapa no marcador...
        MapView1.Location := posicao;

        // Zoom...
        MapView1.Zoom := 17;

        //lbl_botao.Text := 'Obter Localiza??o';

end;

procedure TfrmMaps.onGeocodeReverseEvent(const Address: TCivicAddress);
var
   msg : string;
   sEndereco : TStringList;
begin
       { msg :=  Address.AdminArea + ', ' +
                Address.CountryCode + ', ' +
                Address.CountryName + ', ' +
                Address.FeatureName + ', ' +
                Address.Locality + ', ' +
                Address.PostalCode + ', ' +
                Address.SubAdminArea + ', ' +
                Address.SubLocality + ', ' +
                Address.SubThoroughfare + ', ' +
                Address.Thoroughfare;

        TDialogService.ShowMessage(msg);}

        frmPerfil.edtCEP.Text      := stringReplace(Address.PostalCode,'-','',[]);

         sEndereco := TStringList.Create();

   sEndereco := dm.buscaCEP(stringReplace(Address.PostalCode,'-','',[]));
  if sEndereco.Count = 0 then
    begin
      diag.Show(TIconDialog.Error,'','Cep inv?lido','OK');
    end
  else
    begin
      frmPerfil.edtCidade.Text   := sEndereco[3].ToUpper;
    end;
      frmPerfil.edtNumero.Text   := Address.SubThoroughfare;
      frmPerfil.edtBairro.Text   := Address.SubLocality.ToUpper;
      frmPerfil.edtEndereco.Text := Address.Thoroughfare.ToUpper;

      close;

end;

procedure TfrmMaps.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := false;
  LocationSensor1.Active := true;
end;

end.
