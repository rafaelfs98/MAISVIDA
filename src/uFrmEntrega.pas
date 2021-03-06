unit uFrmEntrega;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects, FMX.TabControl, uFancyDialog,
  FMX.Edit, FMX.Layouts;

type
  TfrmEntrega = class(TForm)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Label1: TLabel;
    Image1: TImage;
    btnMeuEndereco: TRectangle;
    Rectangle4: TRectangle;
    Label2: TLabel;
    lbEndereco: TLabel;
    Line1: TLine;
    Label3: TLabel;
    Image2: TImage;
    Image3: TImage;
    btnRetirarNaLoja: TRectangle;
    Label4: TLabel;
    Image4: TImage;
    Image5: TImage;
    btnOutroEndereco: TRectangle;
    Label5: TLabel;
    Image6: TImage;
    Image7: TImage;
    ShadowEffect1: TShadowEffect;
    Rectangle3: TRectangle;
    Label6: TLabel;
    lbMsgEntrega: TLabel;
    Line2: TLine;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    Rectangle5: TRectangle;
    Label8: TLabel;
    Image8: TImage;
    Rectangle6: TRectangle;
    Label9: TLabel;
    Image9: TImage;
    Rectangle7: TRectangle;
    Label10: TLabel;
    Image10: TImage;
    Rectangle8: TRectangle;
    lbCartao: TLabel;
    imgCartao: TImage;
    Image12: TImage;
    Rectangle9: TRectangle;
    lbDinheiro: TLabel;
    imgDinheiro: TImage;
    Image14: TImage;
    Rectangle10: TRectangle;
    lbPicPay: TLabel;
    imgPicpay: TImage;
    Image16: TImage;
    Rectangle11: TRectangle;
    Label12: TLabel;
    lbEndereco2: TLabel;
    Line3: TLine;
    Rectangle12: TRectangle;
    lbPagamento: TLabel;
    Line4: TLine;
    imgPagamento: TImage;
    Rectangle13: TRectangle;
    lbEntrega: TLabel;
    Line5: TLine;
    lbSubTotal: TLabel;
    lbTotal: TLabel;
    btnCompra: TRectangle;
    Label15: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    LayoutTroco: TLayout;
    Rectangle14: TRectangle;
    Rectangle15: TRectangle;
    Label14: TLabel;
    Layout1: TLayout;
    edtTroco: TEdit;
    btnNao: TRectangle;
    btnSim: TRectangle;
    Label16: TLabel;
    Label17: TLabel;
    edtNome: TEdit;
    edtSobrenome: TEdit;
    edtCEP: TEdit;
    edtEndereco: TEdit;
    edtNumero: TEdit;
    edtBairro: TEdit;
    edtCidade: TEdit;
    edtTelefone: TEdit;
    Label19: TLabel;
    TabControl1: TTabControl;
    Label20: TLabel;
    Rectangle16: TRectangle;
    Label18: TLabel;
    procedure btnMeuEnderecoClick(Sender: TObject);
    procedure btnRetirarNaLojaClick(Sender: TObject);
    procedure btnOutroEnderecoClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure Image9Click(Sender: TObject);
    procedure Image10Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Rectangle8Click(Sender: TObject);
    procedure Rectangle10Click(Sender: TObject);
    procedure btnNaoClick(Sender: TObject);
    procedure btnSimClick(Sender: TObject);
    procedure btnCompraClick(Sender: TObject);
    procedure Rectangle9Click(Sender: TObject);
    procedure Rectangle16Click(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    procedure applyStyle;
    procedure aplicadesconto;
    procedure ClickCancel(Sender: TObject);
    procedure ClickOK(Sender: TObject);
    procedure fechaTela(Sender:Tobject);
    { Private declarations }
  public
  diag:TFancyDialog;
  troco,rTotal:Real;
  sCep :string;
  iEntr :Integer;
    { Public declarations }
  end;

var
  frmEntrega: TfrmEntrega;

implementation

uses
  ufrmPrincipal, uStyle, uDm, System.JSON,ufrmPerfil,Loading;

{$R *.fmx}

procedure TfrmEntrega.btnCompraClick(Sender: TObject);
var cod :String;
    total:Real;
begin
  total := StrToFloat(Copy(lbTotal.Text,3,20));
  cod := dm.enviavenda(iEntr,lbPagamento.tag,total);
  diag.Show(TIconDialog.Success, 'Sucesso', 'Compra Realizada com sucesso','OK',fechaTela);
   frmPrincipal.mudarAba(frmPrincipal.imgAba1);
   frmPrincipal.MostarMinhaCompra;
end;

procedure TfrmEntrega.btnMeuEnderecoClick(Sender: TObject);
var rFrete,frete:Real;
ResultsObj:TJSONObject;
begin

   rtotal:= StrToFloat(Copy(frmPrincipal.lbSubTotal.Text,12,20));


   iEntr := 0;



   aplicadesconto;

  TabControl1.GotoVisibleTab(2,TTabTransition.None,TTabTransitionDirection.Normal);
  lbEndereco2.Text := lbEndereco.Text;
  if frmPrincipal.cdsMenssagens.Locate('tipo','vlf',[]) then
    begin
      lbEntrega.Text := 'R$ '+StringReplace(dm.sFrete,'.',',',[rfReplaceAll]);
      frete := strtoFloat(StringReplace(dm.sFrete,'.',',',[rfReplaceAll]));
    end
  else
    begin
      lbEntrega.Text := 'R$ '+StringReplace(dm.sFrete,'.',',',[rfReplaceAll]);;
      frete := strtoFloat(StringReplace(dm.sFrete,'.',',',[rfReplaceAll]));
    end;



   lbSubTotal.Text := formatfloat('0.00',rtotal);
   lbTotal.Text    := 'R$ '+formatfloat('0.00',(rtotal+frete));
   lbSubTotal.Text := 'R$ '+lbSubTotal.Text;

end;
procedure TfrmEntrega.fechaTela(Sender:Tobject);
begin
   close;
   frmPrincipal.mudarAba(frmPrincipal.imgAba1);

end;

procedure TfrmEntrega.btnNaoClick(Sender: TObject);
begin
  LayoutTroco.Visible := False;
end;

procedure TfrmEntrega.btnOutroEnderecoClick(Sender: TObject);
begin
    iEntr := 2;
    TabControl1.GotoVisibleTab(1,TTabTransition.None,TTabTransitionDirection.Normal);
end;

procedure TfrmEntrega.btnRetirarNaLojaClick(Sender: TObject);
begin
    diag.Show(TIconDialog.Success, 'Desconto Validado',
    'Basta passar na loja para usar seu desconto','ok',fechaTela);
end;

procedure TfrmEntrega.btnSimClick(Sender: TObject);
begin
    troco := strtofloat(stringReplace(edtTroco.Text,'.','.',[]));
    LayoutTroco.Visible := False;
end;

procedure TfrmEntrega.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if dm.sCod <> ''  then
  begin
    frmPrincipal.deleteItem(dm.sCod);

  end;
end;

procedure TfrmEntrega.FormShow(Sender: TObject);
var jsoObj:Tjsonobject;
ResultsObj:TJSONObject;
begin
  diag := TFancyDialog.Create(self);
  applyStyle;


  TLoading.Show(frmPrincipal,'Aguarde...');

  TThread.CreateAnonymousThread(Procedure
  begin
      dm.VerificarCep(frmPrincipal.sCep,ResultsObj);

    if dm.sFrete = '' then
    BEGIN
      frmEntrega.btnMeuEndereco.Visible:= False;
      diag.show(TIconDialog.Info,'Que Pena !','Ainda n?o entregamos em sua regi?o','Ok');
    end
    else
    begin
      frmEntrega.btnMeuEndereco.Visible:= True;

    end;

     dm.carregaCliente(jsoObj);



      lbEndereco.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('endereco').Value+', N?'+
                         (jsoObj.GetValue('dados') as TJSONObject).GetValue('numero').Value+char(13)+' CEP: '+
                         (jsoObj.GetValue('dados') as TJSONObject).GetValue('cep').Value+char(13)+' Bairro: '+
                         (jsoObj.GetValue('dados') as TJSONObject).GetValue('bairro').Value+char(13)+' Cidade: '+
                         (jsoObj.GetValue('dados') as TJSONObject).GetValue('cidade').Value;

           tthread.Synchronize(nil,procedure
          begin
     
           TLoading.Hide;


          end);



  end).Start;








end;

procedure TfrmEntrega.Image10Click(Sender: TObject);
begin
 TabControl1.GotoVisibleTab(0,TTabTransition.None,TTabTransitionDirection.Normal);
end;

procedure TfrmEntrega.Image1Click(Sender: TObject);
begin


  Close;

end;

procedure TfrmEntrega.Image8Click(Sender: TObject);
begin

  TabControl1.GotoVisibleTab(0,TTabTransition.None,TTabTransitionDirection.Normal);
end;

procedure TfrmEntrega.Image9Click(Sender: TObject);
begin


  TabControl1.GotoVisibleTab(0,TTabTransition.None,TTabTransitionDirection.Normal);

end;

procedure TfrmEntrega.Rectangle10Click(Sender: TObject);
begin
  TabControl1.GotoVisibleTab(3,TTabTransition.None,TTabTransitionDirection.Normal);
  lbPagamento.Text    := 'Forma de pagamento: '+lbPicPay.Text;
  lbPagamento.Tag     := 1;
  imgPagamento.Bitmap := imgPicpay.Bitmap;
end;

procedure TfrmEntrega.Rectangle16Click(Sender: TObject);
var rFrete,frete:Real;
endereco :string;
ResultsObj:TJSONObject;
begin

      endereco:= edtEndereco.Text+', N?'+
                         edtNumero.Text+char(13)+' CEP: '+
                         edtCEP.Text+char(13)+' Bairro: '+
                         edtBairro.Text+char(13)+' Cidade: '+
                         edtCidade.Text;




   rtotal:= StrToFloat(Copy(frmPrincipal.lbSubTotal.Text,12,20));






   aplicadesconto;

  TabControl1.GotoVisibleTab(2,TTabTransition.None,TTabTransitionDirection.Normal);
  lbEndereco2.Text := endereco;
  if frmPrincipal.cdsMenssagens.Locate('tipo','vlf',[]) then
    begin
      lbEntrega.Text := 'R$ '+StringReplace(dm.sFrete,'.',',',[rfReplaceAll]);
      frete := strtoFloat(StringReplace(dm.sFrete,'.',',',[rfReplaceAll]));
    end
  else
    begin
      lbEntrega.Text := 'R$ '+StringReplace(dm.sFrete,'.',',',[rfReplaceAll]);;
      frete := strtoFloat(StringReplace(dm.sFrete,'.',',',[rfReplaceAll]));
    end;



   lbSubTotal.Text := formatfloat('0.00',rtotal);
   lbTotal.Text    := 'R$ '+formatfloat('0.00',(rtotal+frete));
   lbSubTotal.Text := 'R$ '+lbSubTotal.Text;

end;
procedure TfrmEntrega.aplicadesconto;
var
rFrete : Real;
ResultsObj:TJSONObject;
begin
    if dm.sFrete = '0.00' then
    begin

     dm.sfrete := '0,00';


     Exit
    end;


     if  dm.rValorMin = 0.00 then
    begin

     dm.VerificarCep(frmPrincipal.sCep,ResultsObj);
     frmPrincipal.FretexProduto;



     Exit
    end;





rfrete := dm.rValorMin;


    if not (rfrete >= rTotal)  then
    begin
     dm.sfrete := '0,00';

    end
    else
    begin

     dm.VerificarCep(frmPrincipal.sCep,ResultsObj);
      frmPrincipal.FretexProduto;


    end;
end;

procedure TfrmEntrega.applyStyle;
var rtotal,frete:Real;
begin
  TabControl1.ActiveTab := TabItem1;
  Rectangle2.Fill.Color := PRIMARY;
  Rectangle5.Fill.Color := PRIMARY;
  Rectangle6.Fill.Color := PRIMARY;
  Rectangle7.Fill.Color := PRIMARY;
  btnCompra.Fill.Color := BTN;
  btnSim.Fill.Color := BTN;
  btnNao.Fill.Color := DANGER;
  btnMeuEndereco.Stroke.Color := PRIMARY;
  btnMeuEndereco.Stroke.Thickness := 1.5;
  with frmPrincipal do
   begin
    if cdsMenssagens.Locate('tipo','ent',[]) then
     begin
      frmEntrega.Rectangle3.Height := 104;
      frmEntrega.lbMsgEntrega.Text := cdsMenssagensmsg.Text;
     end
    else
     begin
      frmEntrega.Rectangle3.Height := 34;
      frmEntrega.lbMsgEntrega.Text := '';
     end;
   end;

end;



procedure TfrmEntrega.Rectangle8Click(Sender: TObject);
begin
  TabControl1.GotoVisibleTab(3,TTabTransition.None,TTabTransitionDirection.Normal);
  lbPagamento.Text    := 'Forma de pagamento: '+lbCartao.Text;
  lbPagamento.Tag     := 0;
  imgPagamento.Bitmap := imgCartao.Bitmap;
end;

procedure TfrmEntrega.Rectangle9Click(Sender: TObject);
begin
  TabControl1.GotoVisibleTab(3,TTabTransition.None,TTabTransitionDirection.Normal);
  lbPagamento.Text    := 'Forma de pagamento: '+lbDinheiro.Text;
  lbPagamento.Tag     := 2;
  imgPagamento.Bitmap := imgDinheiro.Bitmap;
end;

procedure TFrmEntrega.ClickOK(Sender: TObject);
begin
  ///
end;

procedure TfrmEntrega.edtCEPExit(Sender: TObject);
var sEndereco: TStringList;
 i:Integer;
ResultsObj:TJSONObject;
begin
  sEndereco := TStringList.Create();

   sEndereco := dm.buscaCEP(edtCEP.Text);
  if sEndereco.Count = 0 then
    begin
      diag.Show(TIconDialog.Error,'','Cep inv?lido','OK');
    end
  else
    begin
      edtEndereco.Text := sEndereco[0].ToUpper;
      edtCidade.Text   := sEndereco[3].ToUpper;
      edtBairro.Text   := sEndereco[1].ToUpper;


    end;


 dm.verificarCep(edtcep.Text,ResultsObj);

        if dm.sFrete = '' then
        BEGIN

          diag.show(TIconDialog.Info,'Que Pena !','Ainda n?o entregamos em sua regi?o','Ok');
          Rectangle16.Visible :=False;
        end
        else
        begin
        Rectangle16.Visible := True;
        end;
end;

procedure TFrmEntrega.ClickCancel(Sender: TObject);
begin
    showmessage('Cancel');
end;


end.
