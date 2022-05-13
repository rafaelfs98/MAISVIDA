unit uFrmStatus;


interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects, FMX.TabControl, uFancyDialog,
  FMX.Edit, FMX.Layouts, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.ListView, FMX.Filter.Effects,FMX.WebBrowser,

  {$IFDEF ANDROID}

  Androidapi.Helpers, FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNIBridge, Androidapi.JNI.OS, Androidapi.JNI.JavaTypes, Androidapi.JNI.Util,iduri,
  Androidapi.Jni.Net;

{$ENDIF}
{$IFDEF IOS}

 ,Macapi.Helpers, iOSapi.Foundation, FMX.Helpers.iOS, FMX.WebBrowser ;
  {$ENDIF IOS}




 type
   TCommand = (fcPut, fcPatch, fcPost, fcGet, fcRemove);

   TRetornoWS = class
    private
    FRetorno: string;
    FCodigo: Integer;
    procedure SetCodigo(const Value: Integer);
    procedure SetRetorno(const Value: string);
    public
      property Codigo :Integer read FCodigo write SetCodigo;
      property Retorno : string read FRetorno write SetRetorno;
  end;



type
  TfrmStatus = class(TForm)
    Rectangle1: TRectangle;
    TabControl1: TTabControl;
    TabItem2: TTabItem;
    TabItem1: TTabItem;
    Rectangle5: TRectangle;
    Label8: TLabel;
    Image8: TImage;
    Rectangle2: TRectangle;
    Label1: TLabel;
    Image1: TImage;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    lvPedido: TListView;
    imgLixo: TImage;
    Rectangle10: TRectangle;
    Label16: TLabel;
    Image14: TImage;
    FillRGBEffect6: TFillRGBEffect;
    Image15: TImage;
    btnRetirarNaLoja: TRectangle;
    Label7: TLabel;
    Image4: TImage;
    FillRGBEffect5: TFillRGBEffect;
    Image5: TImage;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    Label2: TLabel;
    Rectangle3: TRectangle;
    Label3: TLabel;
    Image3: TImage;
    Rectangle4: TRectangle;
    Label4: TLabel;
    Image6: TImage;
    Rectangle11: TRectangle;
    Label12: TLabel;
    lbEndereco2: TLabel;
    Line3: TLine;
    Rectangle12: TRectangle;
    lbPagamento: TLabel;
    Line4: TLine;
    imgPagamento: TImage;
    lvCarrinho: TListView;
    Image7: TImage;
    btnReclamacao: TRectangle;
    Label15: TLabel;
    Layout2: TLayout;
    Image9: TImage;
    lnRealizado: TLine;
    layout: TLayout;
    lytEmSeparacao: TLayout;
    lnEmsepara��o: TLine;
    Layout4: TLayout;
    Image10: TImage;
    lytEntregue: TLayout;
    lytEn: TLayout;
    Image11: TImage;
    lytEmRota: TLayout;
    lnEmRota: TLine;
    Layout9: TLayout;
    Image12: TImage;
    Label9: TLabel;
    Label10: TLabel;
    Label14: TLabel;
    Label17: TLabel;
    Layout10: TLayout;
    Rectangle6: TRectangle;
    lblAcompanha: TLabel;
    Line6: TLine;
    Rectangle7: TRectangle;
    Label6: TLabel;
    FillRGBEffect2: TFillRGBEffect;
    imgLupa: TImage;
    imgDinheiro: TImage;
    imgCartao: TImage;
    imgPicpay: TImage;
    Label5: TLabel;
    Rectangle8: TRectangle;
    Label11: TLabel;
    FillRGBEffect1: TFillRGBEffect;
    Layout1: TLayout;
    TabItem5: TTabItem;
    TabItem6: TTabItem;
    Rectangle9: TRectangle;
    Label13: TLabel;
    Image2: TImage;
    Rectangle13: TRectangle;
    Label18: TLabel;
    Image13: TImage;
    FillRGBEffect3: TFillRGBEffect;
    Image16: TImage;
    Rectangle14: TRectangle;
    Label19: TLabel;
    Image17: TImage;
    FillRGBEffect4: TFillRGBEffect;
    Image18: TImage;
    WebBrowser1: TWebBrowser;
    Image19: TImage;
    Layout3: TLayout;

   
    procedure Image1Click(Sender: TObject);
    
    procedure FormShow(Sender: TObject);
    procedure imgAba1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure imgAba4Click(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Rectangle7Click(Sender: TObject);
    procedure lvPedidoItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure btnRetirarNaLojaClick(Sender: TObject);
    procedure Rectangle8Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Rectangle13Click(Sender: TObject);
    procedure btnReclamacaoClick(Sender: TObject);
    procedure Image19Click(Sender: TObject);
    procedure Rectangle10Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Rectangle14Click(Sender: TObject);
    procedure Layout10Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);



  private


    procedure fechaTela(Sender:Tobject);
    procedure buscaLista;
    function SendData(const ACommand: TCommand;
      Params: TRESTRequestParameterList; ADataOwner: boolean;
      URL: string): TRetornoWS;
    procedure addListaProduto(venda, compra,status: String; valor: Real);
    procedure buscarItens(pedido: integer);
    procedure addListaProdutos2(cod, descricao, qtd: String; valor: Real);
    procedure ApplyStyle;
    { Private declarations }
  public
  diag:TFancyDialog;
  troco,rTotal:Real;
  sId,sStatus,sCliente,sSobreNome :string;

    { Public declarations }
  end;

var
  frmStatus: TfrmStatus;

implementation

uses
 FMX.PhoneDialer,FMX.Platform,ufrmPrincipal, uStyle, uDm, System.JSON,System.Permissions,ufrmPerfil,Loading,uFrmEntrega;

{$R *.fmx}



procedure TfrmStatus.addListaProduto(venda,compra,status:String;valor:Real);
begin
 with lvPedido.Items.Add do
   begin
     Detail := venda;
     TListItemText(Objects.FindDrawable('txtDescricao')).Text :='Data Pedido  '+Compra;
     TListItemText(Objects.FindDrawable('Text2')).Text := 'Pre�o R$ '+formatFloat('0.00',valor);
     TListItemText(Objects.FindDrawable('Text5')).Text := venda;
     TListItemText(Objects.FindDrawable('Text7')).Text := 'Valor  '+'R$'+''+ formatFloat('0.00',valor);;
     TListItemImage(Objects.FindDrawable('Image4')).Bitmap := imgLupa.Bitmap;
   end;
end;
procedure TfrmStatus.addListaProdutos2(cod,descricao,qtd:String;valor:Real);
begin
 with lvCarrinho.Items.Add do
   begin
     Detail := cod;
     TListItemText(Objects.FindDrawable('txtDescricao')).Text := descricao;
     TListItemText(Objects.FindDrawable('Text2')).Text := qtd +'x  '+'R$'+formatFloat('0.00',valor);

end;
end;
procedure TfrmStatus.fechaTela(Sender:Tobject);
begin
   close;
   frmPrincipal.mudarAba(frmPrincipal.imgAba1);

end;
procedure TfrmStatus.btnReclamacaoClick(Sender: TObject);
begin
 TabControl1.GotoVisibleTab(4,TTabTransition.None,TTabTransitionDirection.Normal);
end;

procedure TfrmStatus.btnRetirarNaLojaClick(Sender: TObject);
begin
TabControl1.GotoVisibleTab(1,TTabTransition.None,TTabTransitionDirection.Normal);
  sStatus := 'H';
   buscaLista;

end;

procedure TfrmStatus.buscaLista;
var
  strlist:TStringList;
  strResp,strREC:TStringStream;
  jso,jsoItem,jsonFinal,ResultsObj:TJSONObject;
  ResultsArray:TJSONArray;
  sJson:String;
  irespota,x:Integer;
  arrayItens:TJSONArray;
  resultsObjP:TJSONPair;
  jsop:TJSONPair;
  id,total,status,cliente,dataPedido,nome,endereco,fone,sobrenome,email,pagamento,numero,cep,bairro,cidade:string;
  rPreco,rPromocao:Real;
  cpf,cnpj:string;
  str,sRetorno:string;
  retorno:TRetornoWS;
  mpFormData: TRESTRequestParameterList;
  sRespota:string;
  jsoValue:TJSONValue;
  imgitens2:TImage;
  foto64:TBitmap;
  data,usado:string;
 t: TThread;
begin
   lvpedido.Items.Clear;


   try

     mpformData := TRESTRequestParameterList.Create(self);

     with mpFormData.AddItem do
      begin
        ContentType:= ctAPPLICATION_JSON;
        Name  := 'x-access-token';
        Value := frmPrincipal.buscaToken;
        Kind  := pkHTTPHEADER;
      end;

      retorno := SendData(fcGet, mpFormData, False,dm.URI+'/pedidos/lista');

      strResp := TStringStream.Create(retorno.FRetorno);
if(retorno.FCodigo = 200)then
     begin

      try
        jso := nil;
        jso := TJsonObject.Create();

        jso := TJSONObject.ParseJSONValue(retorno.FRetorno) as TJSONObject;
        jsoValue:= jso.Get('result').JSonValue;

        {strlist := TStringList.Create();
        strlist.Text := jso.ToString;
        strlist.SaveToFile('C:\temp\JIJIJIJ.txt');
        Exit;                                }

        if ('true'.Equals(jsoValue.value)) then
         begin

           arrayItens  :=  (jso.GetValue('dados') as TJSONArray);

            for x := 0 to arrayItens.Size - 1 do
             begin
               ResultsObj := (arrayItens.Get(x) as TJSONObject);
              for resultsObjP in ResultsObj do
                begin

                  if resultsObjP.JsonString.Value = 'id_pedido' then
                    begin
                      id := (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'total'  then
                    begin
                      total:= (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'status'  then
                    begin
                      status := (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'cliente'  then
                    begin
                      cliente := (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'cpf'  then
                    begin
                      cpf := (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'data_pedido'  then
                    begin
                      dataPedido := Copy((resultsObjP.JsonValue As TJSONString).Value,1,10);
                    end
                  else
                  if resultsObjP.JsonString.Value = 'nome'  then
                    begin
                      nome := (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'sobrenome'  then
                    begin
                      sobrenome := (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'endereco'  then
                    begin
                      endereco := (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'email'  then
                    begin
                      email := (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'fone'  then
                    begin
                      fone := (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'forma_pagamento'  then
                    begin
                      pagamento := (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'numero' then
                    begin
                     numero:= (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'cep' then
                    begin
                     cep := (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'bairro' then
                    begin
                      bairro := (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'cidade' then
                    begin
                      cidade := (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else




                end;

                 data := Copy(dataPedido,9,2);
                 data := data+'/'+Copy(dataPedido,6,2);
                 data := data+'/'+Copy(dataPedido,1,4);

                 if cpf = dm.scpf then
              begin

                  sSobreNome := sobrenome;
                  sCliente := nome;




                if status = '0' then
                 begin
                  status   := 'NOVO';
                 end
                else
                if status = '1' then
                 begin
                  status := 'SEPARA��O';
                 end
                else
                if status = '2' then
                 begin
                 status   := 'GERAR DAV';
                 end
                else
                if status = '3' then
                 begin
                  status   := 'EM TRANSITO';
                 end
                else
                if status = '4' then
                 begin
                  status := 'ENTREGUE';
                 end
                else
                if status = '10' then
                 begin
                  status  := 'PAGO';
                 end
                else
                if status = '12' then
                 begin
                  status  := 'EXPIRADO';
                 end;




                      if sStatus = 'D' then
                   begin
                    if sId = id then
                    begin


                    lbEndereco2.text := cep+#13+ endereco+'  ' +numero + '  '+bairro+'   '+cidade
                    + #13 +'Data De Compra'+':' +data +#13 +nome+'  '+sobrenome+'    '+fone;

                    if pagamento = '2' then
                    begin

                     imgPagamento.Bitmap := imgDinheiro.Bitmap;
                     lbPagamento.Text := 'Dinheiro'  + #13 + 'R$'+total;

                    end
                    else
                    if pagamento = '0' then
                    begin
                     imgPagamento.Bitmap := imgCartao.Bitmap;
                     lbPagamento.Text := 'Cart�o'  + #13 + 'R$'+total;

                    end
                    else
                    begin
                     imgPagamento.Bitmap := imgPicPay.Bitmap;
                     lbPagamento.Text := 'PicPay'  + #13 + 'R$'+total;

                    end;




                     buscarItens(sId.ToInteger);

                    end;
                   end;





                   if sStatus = 'A' then
                   begin
                    if sId = id then
                    begin


                    lblAcompanha.Text:= 'Numero do Pedido: ' + id;
                     Label5.Text := 'Data da Compra: '  + data;

                    if status = 'SEPARA��O' then
                    begin
                     lnRealizado.Visible := True;
                     lytEmSeparacao.visible := True;
                     lnEmsepara��o.Visible := False;
                     lytEntregue.visible := False;
                     lytemrota.visible := False;
                     lnEmrota.Visible := False;


                    end
                    else
                    if status= 'EM TRANSITO' then
                    begin
                      lnRealizado.Visible := True;
                     lytEmSeparacao.visible := True;
                     lnEmsepara��o.Visible := True;
                     lytemrota.visible := True;
                      lnEmrota.Visible := False;
                     lytEntregue.visible := False;

                    end
                    else
                     if status = 'ENTREGUE' then
                    begin
                      lnRealizado.Visible := True;
                     lytEmSeparacao.visible := True;
                     lnEmsepara��o.Visible := True;
                     lytemrota.visible := True;
                     lnEmrota.Visible := True;
                     lytEntregue.visible := True;

                    end
                    else
                    begin
                    lnRealizado.Visible := False;
                     lytEmSeparacao.visible := false;
                     lnEmsepara��o.Visible := false;
                     lytemrota.visible := false;
                     lnEmrota.Visible := false;
                     lytEntregue.visible := false;

                    end;





                    end;
                   end;


                     total := StringReplace(total,'.',',',[rfReplaceAll]);

                      if sStatus = 'N'then
                   begin
                    if status <>'ENTREGUE' then
                      addListaProduto(id,data,status,StrToFloat(total));

                   end
                   else if sStatus = 'H'then
                   begin
                     if status = 'ENTREGUE' then
                      addListaProduto(id,data,status,StrToFloat(total));
                   end;














              end;


             end;





         end
        else
         begin

         end;
      except
         on E:Exception do
          begin
             ShowMessage(e.Message)
          end;
      end;

     end
    else
    begin

    end;

   except

   end;


   if Assigned(strResp) then
      FreeAndNil(strResp);

   if Assigned(jso) then
     FreeAndNil(jso);


end;
procedure TfrmStatus.FormCreate(Sender: TObject);
var
FPermisaoDicar : string;
begin
 ApplyStyle;


  {$IFDEF ANDROID}
  FPermisaoDicar := JStringToString(TJManifest_permission.JavaClass.CALL_PHONE);
  PermissionsService.RequestPermissions([FPermisaoDicar],nil,nil);
  {$ENDIF ANDROID}


end;

procedure TfrmStatus.FormShow(Sender: TObject);
var jsoObj:Tjsonobject;
ResultsObj:TJSONObject;
begin

 TabControl1.GotoVisibleTab(0,TTabTransition.None,TTabTransitionDirection.Normal);

end;



procedure TfrmStatus.Image19Click(Sender: TObject);
begin
 WebBrowser1.GoBack;
  TabControl1.GotoVisibleTab(4,TTabTransition.None,TTabTransitionDirection.Normal);
end;

procedure TfrmStatus.Image1Click(Sender: TObject);
begin

 TabControl1.GotoVisibleTab(0,TTabTransition.None,TTabTransitionDirection.Normal);

end;
procedure TfrmStatus.Image2Click(Sender: TObject);
begin

   TabControl1.GotoVisibleTab(3,TTabTransition.None,TTabTransitionDirection.Normal);

end;

procedure TfrmStatus.Image3Click(Sender: TObject);
begin
  TabControl1.GotoVisibleTab(3,TTabTransition.None,TTabTransitionDirection.Normal);
end;

procedure TfrmStatus.Image8Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmStatus.imgAba1Click(Sender: TObject);
begin
 sStatus := 'NOVO';

 buscaLista;
end;

procedure TfrmStatus.imgAba4Click(Sender: TObject);
begin
 

 buscaLista;
end;

procedure TfrmStatus.Label6Click(Sender: TObject);
begin
  TabControl1.GotoVisibleTab(2,TTabTransition.None,TTabTransitionDirection.Normal);
end;

procedure TfrmStatus.Layout10Click(Sender: TObject);
begin
  TabControl1.GotoVisibleTab(2,TTabTransition.None,TTabTransitionDirection.Normal);
end;

procedure TfrmStatus.lvPedidoItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin
   if TListView(Sender).Selected <> nil then
    begin

       if ItemObject is TListItemImage then
        begin

           if TListItemImage(ItemObject).Name = 'Image4' then
             begin

               TabControl1.GotoVisibleTab(3,TTabTransition.None,TTabTransitionDirection.Normal);

               sId := (lvPedido.Items[lvPedido.Selected.Index].Detail);
               sStatus := 'D';
               buscaLista;

             end;









        end;
    end;
end;

procedure TfrmStatus.Rectangle10Click(Sender: TObject);
begin
TabControl1.GotoVisibleTab(1,TTabTransition.None,TTabTransitionDirection.Normal);
  sStatus := 'N';
   buscaLista;
end;

procedure TfrmStatus.Rectangle13Click(Sender: TObject);

var
        pedido,nome,sobrenome,mensagem : string;
        ret : boolean;

{$IFDEF ANDROID}
       Intend : JIntent;
{$ENDIF ANDROID}

{$IFDEF IOS}
        NSU: NSUrl;
{$ENDIF IOS}
begin

        nome := sCliente;
        sobrenome := sSobreNome;
        pedido := sId;



        mensagem := 'Ol� Me chamo '+'*'+nome +' '+sobrenome+'*'+' estou falando em Rela��o ao Pedido de N� '+'*'+pedido +'*';
        mensagem :=  'https://api.whatsapp.com/send?phone='+'5581987870582'+'&text=' + mensagem+'&source=&data=#23';
        {$IFDEF ANDROID}
         mensagem := 'Ol� Me chamo '+'*'+nome +' '+sobrenome+'*'+' estou falando em Rela��o ao Pedido de N� '+'*'+pedido +'*';
        mensagem := 'whatsapp://send?phone='+'5581987870582'+'&text=' + mensagem+'&source=&data=#23';
        Intend := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW);
        Intend.setData(TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(mensagem))));
        SharedActivity.startActivity(Intend);
      Intend.setPackage(StringToJString('com.whatsapp.w4b'));

        {$ENDIF ANDROID}

        {$IFDEF IOS}
        //NSU := StrToNSUrl(mensagem);
        //ret := SharedApplication.openUrl(NSU);
         TabControl1.GotoVisibleTab(5,TTabTransition.None,TTabTransitionDirection.Normal);
        WebBrowser1.URL  := mensagem;

        {$ENDIF IOS}

end;

procedure TfrmStatus.Rectangle14Click(Sender: TObject);
var
 chamada: IFMXPhoneDialerService;
begin

   TPlatformServices.Current.SupportsPlatformService(IFMXPhoneDialerService, IInterface(chamada));



  if Assigned(chamada) then
     chamada.Call('81987870582');



end;


procedure TfrmStatus.Rectangle7Click(Sender: TObject);
begin
 TabControl1.GotoVisibleTab(2,TTabTransition.None,TTabTransitionDirection.Normal);
 sStatus := 'A';
 buscaLista;
end;

procedure TfrmStatus.Rectangle8Click(Sender: TObject);
begin
 TabControl1.GotoVisibleTab(3,TTabTransition.None,TTabTransitionDirection.Normal);
 sStatus := 'D';
  buscaLista;
end;

{ TRetornoWS }

function TfrmStatus.SendData(const ACommand: TCommand;
  Params: TRESTRequestParameterList; ADataOwner: boolean;
  URL: string): TRetornoWS;
 var
  Retorno:TRetornoWS;
begin
  Retorno:= TRetornoWS.Create;

  RESTClient1.BaseURL := URL;
  case ACommand of
    fcPut:
      begin
        RESTClient1.ContentType := 'application/json';
        RESTClient1.Accept := 'application/json';
        RESTRequest1.Method  := rmPUT;
        RESTRequest1.Params  := Params;
        RESTRequest1.Timeout := 10000;
        RESTRequest1.Execute;
      end;
    fcPost:
      begin
        RESTClient1.ContentType := 'application/json';
        RESTClient1.Accept := 'application/json';
        RESTRequest1.Method := rmPOST;
        RESTRequest1.Params := Params;
        RESTRequest1.Timeout := 10000;
        RESTRequest1.Execute;
      end;
    fcPatch:
      begin
        RESTClient1.ContentType := 'application/json';
        RESTClient1.Accept := 'application/json';
        RESTRequest1.Method := rmPATCH;
        RESTRequest1.Params := Params;
        RESTRequest1.Timeout := 10000;
        RESTRequest1.Execute;
      end;
    fcGet:
      begin
        RESTClient1.ContentType := 'application/json';
        RESTClient1.Accept := 'application/json';
        RESTRequest1.Method := rmGET;
        RESTRequest1.Params := Params;
        RESTRequest1.Timeout := 10000;
        RESTRequest1.Execute;
      end;
    fcRemove:
      begin
        RESTClient1.ContentType := 'application/json';
        RESTClient1.Accept := 'application/json';
        RESTRequest1.Method := rmDELETE;
        RESTRequest1.Params := Params;
        RESTRequest1.Timeout := 10000;
        RESTRequest1.Execute;
      end;
  end;


  Retorno.Codigo := RESTResponse1.StatusCode;
  Retorno.Retorno:= RESTResponse1.JSONText;

  Result := Retorno;


end;

procedure TRetornoWS.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TRetornoWS.SetRetorno(const Value: string);
begin
  FRetorno := Value;
end;
procedure TfrmStatus.buscarItens(pedido: integer);
var
  strlist:TStringList;
  strResp,strREC:TStringStream;
  jso,jsoItem,jsonFinal,ResultsObj:TJSONObject;
  ResultsArray:TJSONArray;
  sJson:String;
  irespota,x:Integer;
  arrayItens:TJSONArray;
  resultsObjP:TJSONPair;
  jsop:TJSONPair;
  codigo,total,qtd,descricao:string;
  rPreco,rPromocao:Real;
  cpf,cnpj:string;
  str,sRetorno:string;
  retorno:TRetornoWS;
  mpFormData: TRESTRequestParameterList;
  sRespota:string;
  jsoValue:TJSONValue;
  imgitens2:TImage;
  foto64:TBitmap;
  data,usado:string;
begin


   lvCarrinho.Items.Clear;

   try

     mpformData := TRESTRequestParameterList.Create(self);

     with mpFormData.AddItem do
      begin
        ContentType:= ctAPPLICATION_JSON;
        Name  := 'x-access-token';
        Value := frmPrincipal.buscaToken;
        Kind  := pkHTTPHEADER;
      end;

      retorno := SendData(fcGet, mpFormData, False,dm.URI+'/pedidos/itens/'+IntToStr(pedido));

      strResp := TStringStream.Create(retorno.FRetorno);




    if(retorno.FCodigo = 200)then
     begin

      try
        jso := nil;
        jso := TJsonObject.Create;
        jso.Parse(BytesOf(retorno.FRetorno), 0);
        jsoValue:= jso.Get('result').JSonValue;
        //sRespota := jsoValue;

        //  sRespota :=  jsoValue.value;

        if ('true'.Equals(jsoValue.value)) then
         begin

           arrayItens  :=  (jso.GetValue('dados') as TJSONArray);

            for x := 0 to arrayItens.Size - 1 do
             begin
               ResultsObj := (arrayItens.Get(x) as TJSONObject);
              for resultsObjP in ResultsObj do
                begin

                  if resultsObjP.JsonString.Value = 'codigo' then
                    begin
                      codigo := (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'descricao'  then
                    begin
                      descricao:= (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'qtd'  then
                    begin
                      qtd := (resultsObjP.JsonValue As TJSONString).Value;
                    end
                  else
                  if resultsObjP.JsonString.Value = 'valor'  then
                    begin
                      total := (resultsObjP.JsonValue As TJSONString).Value;
                    end;

                end;


                  total := StringReplace(total,'.',',',[rfReplaceAll]);

                addListaProdutos2(codigo
                                    ,descricao
                                    ,qtd
                                    ,StrToFloat(total));





             end;

         end
        else
         begin
           showmessage(jso.GetValue('erro').Value);
         end;
      except

         on E:Exception do
          begin
            ShowMessage('error '+e.Message);
          end;
      end;

     end
    else
    begin

    end;



   except

   end;
end;
procedure TfrmStatus.ApplyStyle;
begin
  TabControl1.TabPosition  := TTabPosition.None;
  frmStatus.Fill.Color  := BACKGROUND;
  Rectangle5.Fill.Color    := PRIMARY;
  Rectangle2.Fill.Color    := PRIMARY;
  Rectangle3.Fill.Color    := PRIMARY;
  Rectangle4.Fill.Color    := PRIMARY;
  Rectangle9.Fill.Color    := PRIMARY;
 // btnRetirarNaLoja.Fill.Color    := PRIMARY;
  //btnReclamacao.Fill.Color     := PRIMARY;
 { btnComprar.Fill.Color    := BTN;
  rctMais.Fill.Color       := PRIMARY;
  rctMenos.Fill.Color      := PRIMARY;
  RctPesquisa.Stroke.Color := PRIMARY; }

end;
end.
