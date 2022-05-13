unit uFmxSlide;

interface

uses FMX.Types,FMX.Layouts,System.UITypes,FMX.Graphics,
     FMX.TabControl,FMX.Objects,FMX.Effects,FMX.StdCtrls,
     System.ioutils, System.Classes, System.SysUtils,FMX.Gestures;


type
   TLayoutHelper = class helper for TLayout
      procedure Slide(img:string;bmp:TImage);
      procedure ProximoClick(Sender:TObject);
      procedure AnteriorClick(Sender:TObject);
      procedure AnimaFish(Sender:TObject);
      procedure proximo;
      procedure anterior;
      procedure gestos;
      procedure LayoutGesture(Sender:TObject;
                const EnvetInfo:TGestureEventInfo; var Handled:Boolean);
   end;

implementation

uses
  FMX.Ani;
var GestureManager:TGestureManager;


{ TLayoutHelper }

procedure TLayoutHelper.AnimaFish(Sender: TObject);
begin

   if (TTabControl(FindComponent(Self.Name+'TabSlide')).TabCount -1) <>
      (TTabControl(FindComponent(Self.Name+'TabSlide')).TabIndex) then
       TTabControl(FindComponent(Self.Name+'TabSlide')).Next
   else
      TTabControl(FindComponent(Self.Name+'TabSlide')).GotoVisibleTab(0,TTabTransition.Slide,TTabTransitionDirection.Reversed );

   TFloatAnimation(Sender).Start;

end;

procedure TLayoutHelper.anterior;
begin
   TTabControl(FindComponent(Self.Name+'tabSlide')).Previous()
end;

procedure TLayoutHelper.AnteriorClick(Sender: TObject);
begin
  anterior();
end;

procedure TLayoutHelper.gestos;
begin
   GestureManager := TGestureManager.Create(self);
   GestureManager.Sensitivity  := 10;
   Self.Touch.GestureManager   := GestureManager;
   Self.Touch.StandardGestures := [TStandardGesture.sgLeft,TStandardGesture.sgRight];
   Self.OnGesture := layoutGesture;
end;

procedure TLayoutHelper.LayoutGesture(Sender: TObject;
  const EnvetInfo: TGestureEventInfo; var Handled: Boolean);
begin
  if EnvetInfo.GestureID = sgiLeft then
    proximo
  else
   if EnvetInfo.GestureID = sgiRight then
      anterior;




end;

procedure TLayoutHelper.proximo;
begin
    if (TTabControl(FindComponent(Self.Name+'tabSlide')).TabCount -1) <>
       (TTabControl(FindComponent(Self.Name+'tabSlide')).tabIndex) then
        TTabControl(FindComponent(Self.Name+'tabSlide')).Next
    else
        TTabControl(FindComponent(Self.Name+'tabSlide')).GotoVisibleTab(0,TTabTransition.Slide,TTabTransitionDirection.Reversed);
   // TFloatAnimation(Sender).Start;

end;

procedure TLayoutHelper.proximoClick(Sender: TObject);
begin
    proximo;
end;

procedure TLayoutHelper.slide(img: string;bmp:TImage);
var tabSlide:TTabControl;
    tabItem:TTabItem;
    fundo:TRectangle;
    btnProximo,btnAnterior:TSpeedButton;
    i:Integer;
    animacao:TFloatAnimation;

begin

   Self.HitTest := True;

   tabSlide := TTabControl.Create(self);
   tabSlide.Name := Self.Name+'tabSlide';
   Self.AddObject(tabSlide);
   tabSlide.Align := TAlignLayout.Client;
   tabSlide.TabPosition := TTabPosition.Dots;
   tabSlide.HitTest := False;


   for i := 0 to 3 do
     begin
       tabItem := TTabItem.Create(tabSlide);
       tabItem.Text := 'slide '+ inttoStr(i);

       fundo := TRectangle.Create(tabItem);
       tabItem.AddObject(fundo);

       fundo.Fill.Bitmap.Bitmap := bmp.Bitmap;
       fundo.Fill.Kind := TBrushKind.Bitmap;
       fundo.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
       fundo.HitTest := False;
       fundo.Align := TAlignLayout.Client;
       fundo.Margins.Top := 10;
       fundo.Margins.Left := 10;
       fundo.Margins.Right := 10;
       fundo.Margins.Bottom := 10;

       tabSlide.AddObject(tabItem);
     end;


     btnProximo := TSpeedButton.Create(self);
     Self.AddObject(btnProximo);
     btnProximo.BringToFront;
     btnProximo.Text := '>';
     btnProximo.Size.Height := 25;
     btnProximo.Size.Width  := 25;
     btnProximo.Position.X  := Self.Width-30;
     btnProximo.Position.Y  := (Self.Height/2)-15;
     btnProximo.OnClick     := ProximoClick;

     btnAnterior := TSpeedButton.Create(self);
     Self.AddObject(btnAnterior);
     btnAnterior.BringToFront;
     btnAnterior.Text := '<';
     btnAnterior.Size.Height := 25;
     btnAnterior.Size.Width  := 25;
     btnAnterior.Position.X  := 5;
     btnAnterior.Position.Y  := (Self.Height/2)-15;
     btnAnterior.OnClick     := AnteriorClick;


     animacao := TFloatAnimation.Create(tabSlide);
     tabSlide.AddObject(animacao);
     animacao.Duration     := 3;
     animacao.PropertyName := 'Opacity';
     animacao.StartValue   := 1;
     animacao.StopValue    := 1;
     animacao.OnFinish     := AnimaFish;
     animacao.Start;


end;

end.
