unit FMX.Slides;


interface


uses
  System.JSON,FMX.Ani,FMX.Layouts,FMX.Types,System.UITypes,
   FMX.TabControl, FMX.Objects,FMX.Effects,FMX.StdCtrls,Data.DB,
   System.SysUtils,FMX.Graphics;


type

   TLayoutHelper = class helper for TLayout

      procedure Slide(jso:TJSONArray);

      procedure ProximoClick(Sender: TObject);

      procedure AnteriorClick(Sender: TObject);

      procedure AnimaFinish(Sender: TObject);

      function SetAsBase64(const ASource: string):TBitmap;

end;



implementation

uses
  System.Classes, System.NetEncoding;



{ TLayoutHelper }


procedure TLayoutHelper.AnimaFinish(Sender: TObject);

begin


   if (TTabControl(FindComponent(Self.Name+'TabSlide')).TabCount -1) <>
      (TTabControl(FindComponent(Self.Name+'TabSlide')).TabIndex) then
       TTabControl(FindComponent(Self.Name+'TabSlide')).Next
   else
      TTabControl(FindComponent(Self.Name+'TabSlide')).GotoVisibleTab(0,      TTabTransition.Slide,TTabTransitionDirection.Reversed );

   TFloatAnimation(Sender).Start;

end;


procedure TLayoutHelper.AnteriorClick(Sender: TObject);
begin

   TTabControl(FindComponent(Self.Name+'TabSlide')).Previous;

end;


procedure TLayoutHelper.ProximoClick(Sender: TObject);
begin

  if (TTabControl(FindComponent(Self.Name+'TabSlide')).TabCount -1) <>
      (TTabControl(FindComponent(Self.Name+'TabSlide')).TabIndex) then
       TTabControl(FindComponent(Self.Name+'TabSlide')).Next
  else
      TTabControl(FindComponent(Self.Name+'TabSlide')).GotoVisibleTab(0);

end;

function TLayoutHelper.SetAsBase64(const ASource: string):TBitmap;
var
  LInputStream: TStringStream;
  LOutputStream: TBytesStream;
begin
  LInputStream := TStringStream.Create(ASource);
  Result := TBitmap.Create;
  try
    LInputStream.Position := 0;
    LOutputStream := TBytesStream.Create;
    try
      TNetEncoding.Base64.Decode(LInputStream, LOutputStream);
      LOutputStream.Position := 0;
      Result.LoadFromStream(LOutputStream);
    finally
      LOutputStream.Free;
    end;
  finally
    LInputStream.Free;
  end;

end;

procedure TLayoutHelper.Slide(jso:TJSONArray);
var
   TabSlide : TTabControl;
   TabItem :TTabItem;
   Fundo :TRectangle;
   Proximo, Anterior :TSpeedButton;
   Sombra : TShadowEffect;
   Animacao :TFloatAnimation;
   I:Integer;
   s:String;
begin


   Self.BeginUpdate;


   TabSlide := TTabControl.Create(Self);
   Self.AddObject(TabSlide);
   TabSlide.Align := TAlignLayout.Client;
   TabSlide.TabPosition := TTabPosition.None;
   TabSlide.Name := Self.Name+'TabSlide';
   s:= jso.tostring;

   for i := 0 to jso.Size - 1 do
   begin

      TabItem := TTabItem.Create(TabSlide);
      TabItem.Text := 'Slide '+ inttostr(i);


      Fundo := TRectangle.Create(TabItem);
      TabItem.AddObject(Fundo);
      Fundo.Fill.Color := TAlphaColorRec.White;
      Fundo.Stroke.Color := TAlphaColorRec.White;
      Fundo.Align := TAlignLayout.Client;
      Fundo.Margins.Top := 10;
      Fundo.Margins.Left := 10;
      Fundo.Margins.Right := 10;
      Fundo.Margins.Bottom := 10;
//      Fundo.Fill.Bitmap.Bitmap := bmp;
      Fundo.Fill.Bitmap.Bitmap := SetAsBase64(jso.Get(i).GetValue<String>('imagem'));
      Fundo.Fill.Kind := TBrushKind.Bitmap;
      Fundo.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;


      Fundo.YRadius := 5;
      Fundo.XRadius := 5;


      Sombra := TShadowEffect.Create(Fundo);
      Fundo.AddObject(Sombra);
      Sombra.Distance := 0.1;
      Sombra.Opacity := 0.1;

      TabSlide.AddObject(TabItem);


   end;


   Proximo := TSpeedButton.Create(Self);

   Self.AddObject(Proximo);
   Proximo.BringToFront;
   Proximo.Text := '>';
   Proximo.Size.Height := 25;
   Proximo.Size.Width := 25;
   Proximo.Position.X := Self.Width - 30;
   Proximo.Position.Y := (Self.Height/2)- 15;
   Proximo.OnClick := ProximoClick;


   Anterior := TSpeedButton.Create(Self);
   Self.AddObject(Anterior);
   Anterior.BringToFront;
   Anterior.Text := '<';
   Anterior.Size.Height := 25;
   Anterior.Size.Width := 25;
   Anterior.Position.X := 5;
   Anterior.Position.Y := (Self.Height/2)- 15;
   Anterior.OnClick := AnteriorClick;


   Animacao := TFloatAnimation.Create(TabSlide);
   TabSlide.AddObject(Animacao);
   Animacao.Duration := 3;
   Animacao.PropertyName := 'Opacity';
   Animacao.StartValue := 1;
   Animacao.StopValue := 1;
   Animacao.OnFinish := AnimaFinish;
   Animacao.Start;

   Self.EndUpdate;

end;


end.


