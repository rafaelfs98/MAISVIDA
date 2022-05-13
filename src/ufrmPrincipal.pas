unit ufrmPrincipal;

interface

uses
 System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,u99Permissions,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,uFancyDialog,

  {$IFDEF ANDROID}
  Androidapi.Helpers, FMX.Helpers.Android, Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNIBridge, Androidapi.JNI.OS, Androidapi.JNI.JavaTypes, Androidapi.JNI.Util,
  {$ENDIF}

  FMX.TabControl, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView,System.Json, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.Effects,System.NetEncoding,Soap.EncdDecd, Data.DB,
  Datasnap.DBClient,
  {$IFDEF MSWINDOWS}
  MidasLib,
  {$ENDIF}
  FMX.Slides, FMX.Filter.Effects;
type
  TMyThread = class(TThread)
  private
    codigo : string;
    img : TListItemImage;
  protected
    procedure Execute; override;
    constructor Create;
  end;

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
  TExecutaClickWin = procedure(Sender: TObject) of Object;
  TExecutaClickMobile = procedure(Sender: TObject; const Point: TPointF) of Object;

  TfrmPrincipal = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    Layout1: TLayout;
    imgAba1: TImage;
    imgAba2: TImage;
    imgAba3: TImage;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTClient1: TRESTClient;
    StyleBook1: TStyleBook;
    Layout2: TLayout;
    Rectangle6: TRectangle;
    Layout3: TLayout;
    Rectangle7: TRectangle;
    Layout4: TLayout;
    Image2: TImage;
    btnComprar: TRectangle;
    Layout5: TLayout;
    imgDetalhe: TImage;
    lbQtd: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    lbTotal: TLabel;
    Layout6: TLayout;
    lbDesc: TLabel;
    lbValor: TLabel;
    lbTotalClub: TLabel;
    Label8: TLabel;
    cdsMenssagens: TClientDataSet;
    cdsMenssagenstipo: TStringField;
    cdsMenssagensmsg: TStringField;
    imgAba4: TImage;
    TabItem4: TTabItem;
    Rectangle3: TRectangle;
    Label3: TLabel;
    VertScrollBox1: TVertScrollBox;
    btnRetirarNaLoja: TRectangle;
    Label7: TLabel;
    Image4: TImage;
    Image5: TImage;
    lvCarrinho: TListView;
    imgLixo: TImage;
    Rectangle2: TRectangle;
    Label1: TLabel;
    Rectangle5: TRectangle;
    btnCompra: TRectangle;
    Label4: TLabel;
    lbSubTotal: TLabel;
    lbSubTotalClub: TLabel;
    lvItens: TListView;
    imgItens: TImage;
    imgAtv: TImage;
    imgItem: TImage;
    ImgSemImagem: TImage;
    Rectangle1: TRectangle;
    layoutToobar: TLayout;
    imgLogo: TImage;
    LayoutBotoes: TLayout;
    Image1: TImage;
    LayoutBusca: TLayout;
    Layout45: TLayout;
    rctBusca: TRectangle;
    Edit11: TEdit;
    lblCancBuscar: TLabel;
    Label2: TLabel;
    Rectangle4: TRectangle;
    ShadowEffect1: TShadowEffect;
    Edit1: TEdit;
    VertScrollBox2: TVertScrollBox;
    Image7: TImage;
    Rectangle8: TRectangle;
    Layout7: TLayout;
    Image8: TImage;
    Layout8: TLayout;
    Image9: TImage;
    Layout9: TLayout;
    Layout10: TLayout;
    Rectangle9: TRectangle;
    Edit2: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    LayoutSlide: TLayout;
    lbValorClub: TLabel;
    rctMais: TRectangle;
    rctMenos: TRectangle;
    Label9: TLabel;
    Label10: TLabel;
    ListView1: TListView;
    cdsListaItens: TClientDataSet;
    cdsListaItenscod_produto: TStringField;
    cdsListaItensdescricao: TStringField;
    cdsListaItensqtd: TFloatField;
    cdsListaItensvalor: TFloatField;
    cdsListaItensvenda: TFloatField;
    cdsListaItenstotal: TFloatField;
    rctInicial: TRectangle;
    Image3: TImage;
    Timer1: TTimer;
    Layout11: TLayout;
    Image6: TImage;
    lblVlrUnitario: TLabel;
    Layout12: TLayout;
    Layout13: TLayout;
    Label11: TLabel;
    Layout14: TLayout;
    Label12: TLabel;
    Label13: TLabel;
    Image10: TImage;
    Image11: TImage;
    AniIndicator1: TAniIndicator;
    Image12: TImage;
    LayoutBuscaImagem: TLayout;
    FillRGBEffect1: TFillRGBEffect;
    FillRGBEffect2: TFillRGBEffect;
    FillRGBEffect3: TFillRGBEffect;
    FillRGBEffect4: TFillRGBEffect;
    Layout15: TLayout;
    RctPesquisa: TRectangle;
    edtPesquisa: TEdit;
    SpeedButton3: TSpeedButton;
    FillRGBEffect5: TFillRGBEffect;
    btnClear: TSpeedButton;
    rctNotFound: TRectangle;
    Image13: TImage;
    Label14: TLabel;
    Label15: TLabel;
    Rectangle10: TRectangle;
    Label16: TLabel;
    Image14: TImage;
    FillRGBEffect6: TFillRGBEffect;
    Image15: TImage;
    Rectangle11: TRectangle;
    Label17: TLabel;
    Image16: TImage;
    FillRGBEffect7: TFillRGBEffect;
    Image17: TImage;
    procedure FormCreate(Sender: TObject);
    procedure imgAba1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function buscaToken():string;
    function SendData(const ACommand: TCommand; Params: TRESTRequestParameterList = nil; ADataOwner: boolean = true; URL: string = ''): TRetornoWS;
    procedure btnCompraClick(Sender: TObject);
    procedure AddProduto(codigo, descricao, imagem: string; preco,precoApp: Double);
    procedure montaLista(codigo,descricao,preco,promocao,imagem,usado:String);
    procedure lvItensUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure MostarMinhaCompra();
    procedure montaCarrinho(codigo,descricao,preco,promocao,imagem,qtd:String);
    procedure btnRetirarNaLojaClick(Sender: TObject);
    procedure lvItensItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure Image2Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure btnComprarClick(Sender: TObject);
    procedure lvCarrinhoUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure SpeedButton1Click(Sender: TObject);
    procedure lvItensItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ListView1UpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer;
      const LocalClickPos: TPointF; const ItemObject: TListItemDrawable);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure lvItensPaint(Sender: TObject; Canvas: TCanvas;
      const ARect: TRectF);
    procedure Label2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure FretexProduto;
    procedure deleteItem(codProduto: string);
    procedure Rectangle10Click(Sender: TObject);
  private
   StatusBarColor : Cardinal;
    function SetAsBase64(const ASource: string): TBitmap;
    function BitmapFromBase64(const base64: String): TBitmap;
    function adicionarLista(codProduto, qtd: String): String;
    procedure cargaMensagem();
    procedure banner(arrayJson:TJSONArray;
                     {$IFDEF MSWINDOWS}
                     ACallBack: TExecutaClickWin = nil
                     {$ELSE}
                     ACallBack: TExecutaClickMobile = nil
                     {$ENDIF});
    procedure clickBanner(Sender:Tobject);
    procedure ThreadTerminate(Sender: TObject);
    procedure ClickCancel(Sender: TObject);
    procedure ClickOK(Sender: TObject);

    procedure ClickFechar(Sender: TObject);
   {$IFDEF MSWINDOWS}
    procedure ClickItem(Sender: TObject);

    {$ELSE}
    procedure ClickItem(Sender: TObject; const Point: TPointF);
    {$ENDIF}

    { Private declarations }
  public
   totalPaginas:integer;
    diag:TFancyDialog;
    qtdCarrinho:LongInt;
    MyThread : TMyThread;
    sCadastrado:string;
    Scpf,sPreco,sCep,spromocao:string;
    rValorVendacDesconto,rValorVenda:Real;
    rVlrCompra:Real;
    rVlrCompraDesc:Real;
    permissao:T99permissions;
//    const sCnpj = '24395280';
 // const sCnpj = '38225966';
    const sCnpj = '43172320';

    const URI   = 'https://sridesconto.wposcash.com.br';
  //  const URI   = 'http://localhost:3001';
    procedure ApplyStyle;
    procedure mudarAba(img:TImage);



    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  uStyle, uFrmEntrega, uDm, ufrmPerfil, Loading,uFrmStatus;

{$R *.fmx}

{ TfrmPrincipal }

function TfrmPrincipal.BitmapFromBase64(const base64: String): TBitmap;
var
  Input: TStringStream;
  Output: TBytesStream;
begin

      //  Input := TStringStream.Create(base64, TEncoding.ASCII);
        Output := TBytesStream.Create(DecodeBase64(base64));
        try
                //Output := TBytesStream.Create;
                try
                     //   Soap.EncdDecd.DecodeStream(Input, Output);
                        Output.Position := 0;
                        Result := TBitmap.Create;
                        try
                                Result.LoadFromStream(Output);
                        except
                              on E:Exception do
                               begin
                                 ShowMessage('error'+e.Message);
                                 Result.Free;
                                raise;
                               end;

                        end;
                finally
                        Output.Free;
                end;
        finally
              //  Input.Free;
        end;
end;

procedure TfrmPrincipal.ApplyStyle;
begin
  TabControl1.TabPosition  := TTabPosition.None;
  frmPrincipal.Fill.Color  := BACKGROUND;
  Rectangle1.Fill.Color    := PRIMARY;
  Rectangle2.Fill.Color    := PRIMARY;
  Rectangle3.Fill.Color    := PRIMARY;
  Rectangle8.Fill.Color    := PRIMARY;
  btnCompra.Fill.Color     := PRIMARY;
  btnComprar.Fill.Color    := BTN;
  rctMais.Fill.Color       := PRIMARY;
  rctMenos.Fill.Color      := PRIMARY;
  RctPesquisa.Stroke.Color := PRIMARY;

end;


procedure TfrmPrincipal.btnClearClick(Sender: TObject);
var ResultsObj:TjsonObject;
    jsonArray:TjsonArray;
begin
  btnClear.Visible := False;
  SpeedButton3.Visible := True;
  edtPesquisa.Text := '';

  rctNotFound.Visible := False;
  lvItens.Items.clear;
  lvItens.BeginUpdate;
  TThread.CreateAnonymousThread(procedure
  begin
    dm.nPaginas := 1;
    ResultsObj := TJSONObject.Create;
    jsonArray:= nil;
    dm.buscaItens(dm.nPaginas,'','', ResultsObj);
    jsonArray:= ResultsObj.GetValue('dados') as TJSONArray;


    tthread.Synchronize(nil,procedure
      var i:Integer;
      begin
        for I := 0 to jsonArray.Size -1 do
          begin
               montaLista(jsonArray.get(i).GetValue<String>('cod_produto'),
                          jsonArray.get(i).GetValue<String>('descricao'),
                          StringReplace(jsonArray.get(i).GetValue<String>('preco'),'.',',',[]),
                          StringReplace(jsonArray.get(i).GetValue<String>('promocao'),'.',',',[]),
                          jsonArray.get(i).GetValue<String>('imagem_grande'),
                          '0');
          end;

         //nPaginas := nPaginas + 1;
         lvItens.EndUpdate;

      end);


  end).Start;
end;

procedure TfrmPrincipal.btnCompraClick(Sender: TObject);
var
jsoObj:Tjsonobject;
begin

  dm.carregaCliente(jsoObj);

   sCep := (jsoObj.GetValue('dados') as TJSONObject).GetValue('cep').Value ;


  if not Assigned(frmEntrega) then
    Application.CreateForm(TfrmEntrega,frmEntrega);

  frmEntrega.Show;

end;

procedure TfrmPrincipal.btnComprarClick(Sender: TObject);
var qtd:string;
begin
  if dm.sCadastrado = 'true' then
     begin
       TThread.CreateAnonymousThread(procedure
         begin
           qtd := StringReplace(lbQtd.Text,',','.',[rfReplaceAll,rfIgnoreCase]);
           adicionarLista(Rectangle7.TagString,qtd);
           TThread.Synchronize(nil,procedure
             begin
              Layout2.Visible := False;
             end);

         end).start;

     end
  else
     begin
      ShowMessage('Aten��o fa�a seu cadastro para obter seus descontos !!!');
      if not Assigned(frmPerfil) then
        Application.CreateForm(TfrmPerfil,frmPerfil);

       frmPerfil.Show;
      // frmPerfil.TabControl1.ActiveTab := TabItem2;
     end;
end;

function TfrmPrincipal.adicionarLista(codProduto,qtd: String): String;
var
  jso,jsoItem,jsonFinal,ResultsObj:TJSONObject;
  jsonValue:TJSONValue;
  retorno:TRetornoWS;
  mpFormData: TRESTRequestParameterList;
begin

  try

      mpFormData:= TRESTRequestParameterList.Create(Self);
      jsoItem:= TJSONObject.Create;
      jsoItem.AddPair( TJSONPair.Create('cod_produto',codProduto));
      jsoItem.AddPair( TJSONPair.Create('qtd',qtd));


     with mpFormData.AddItem do
      begin
        ContentType:= ctAPPLICATION_JSON;
        Value:= jsoItem.ToJSON;
        Kind := pkREQUESTBODY;
      end;

    with mpFormData.AddItem do
      begin
        ContentType:= ctAPPLICATION_JSON;
        Name  := 'x-access-token';
        Value := dm.buscaToken;
        Kind  := pkHTTPHEADER;
      end;

      retorno := SendData(fcPost, mpFormData, False,dm.URI+'/lista');

      if(retorno.FCodigo = 200)then
       begin

        jso := nil;
        jso := TJSONObject.Create();
        jso.Parse(BytesOf(retorno.FRetorno),0);
        JsonValue := jso.Get('result').JsonValue;
        Result :=  JsonValue.Value;
       end
      else
       begin
        Result :=  'False';
       end;

  except
    on E: Exception do
      begin
        ShowMessage(E.Message);
      end;
  end;


end;

procedure TfrmPrincipal.btnRetirarNaLojaClick(Sender: TObject);
begin


   {$IFDEF ANDROID}
    permissao.Location(nil,nil);
   {$ENDIF}





   if not Assigned(frmPerfil) then
      Application.CreateForm(TfrmPerfil,frmPerfil);

     frmPerfil.Show;



end;

function TfrmPrincipal.buscaToken: string;
var
  strResp,strREC:TStringStream;
  jso,jsoItem,jsonFinal,ResultsObj:TJSONObject;
  ResultsArray:TJSONArray;
  sJson:String;
  irespota,x:Integer;
  arrayItens:TJSONArray;
  resultsObjP:TJSONPair;
  jsop:TJSONPair;
  cpf,cnpj:string;
  sResult:string;
  str,sRetorno:string;
  retorno:TRetornoWS;
  mpFormData: TRESTRequestParameterList;
  JsonValue,jcValue:TJSONValue;
  strList:TStringList;
begin
     arrayItens := TJSONArray.Create;
     strResp := TStringStream.Create;
     jsonFinal := TJSONObject.Create;

  try
      mpFormData:= TRESTRequestParameterList.Create(Self);
      jsoItem:= TJSONObject.Create;
      jsoItem.AddPair( TJSONPair.Create('usuario', 'sri'));
      jsoItem.AddPair( TJSONPair.Create('senha', '740516'));
      jsoItem.AddPair( TJSONPair.Create('cnpj',sCnpj));
      jsoItem.AddPair( TJSONPair.Create('cpf',sCPF));

      with mpFormData.AddItem do
      begin
        ContentType:= ctAPPLICATION_JSON;
        Value:= jsoItem.ToJSON;
        Kind := pkREQUESTBODY;
      end;

      retorno := SendData(fcPost, mpFormData, False,URI+'/login');

    if(retorno.FCodigo = 200)then
     begin

        jso := nil;
        jso := TJSONObject.Create();
        jso.Parse(BytesOf(retorno.FRetorno),0);
        JsonValue   := jso.Get('token').JsonValue;
        jcValue     := jso.Get('cadastrado').JsonValue;
        sCadastrado := jcValue.Value;
        Result :=  JsonValue.Value;

     end
    else
    begin

    end;

   except
    on E: Exception do
      begin

      end;
  end;

 if Assigned(strResp) then
  FreeAndNil(strResp);


 if Assigned(jso) then
  FreeAndNil(jso);


end;


procedure TfrmPrincipal.cargaMensagem;
var jsonArray:TJSONArray;
    ResultsObj:TJSONObject;
    I:Integer;
begin
  if not dm.VerificaInternet then
     ShowMessage('Voc� est� sem internet');

  ResultsObj := TJSONObject.Create;
  jsonArray:= nil;
  dm.buscaMsg(ResultsObj);
  jsonArray:= ResultsObj.GetValue('dados') as TJSONArray;

  for I := 0 to jsonArray.Size -1 do
    begin
      cdsMenssagens.Append;
      cdsMenssagenstipo.asstring := jsonArray.get(i).GetValue<String>('tipo');
      cdsMenssagensmsg.asstring  := jsonArray.get(i).GetValue<String>('msg');
      cdsMenssagens.Post;
    end;
end;

procedure TfrmPrincipal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   diag.Show(TIconDialog.Question, 'Aten��o',
            'Deseja fechar este aplicativo?', 'Sim', ClickFechar, 'N�o', ClickCancel);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  rctNotFound.Visible := False;
  rctInicial.Visible := True;
  ApplyStyle;
  cdsMenssagens.Close;
  cdsMenssagens.CreateDataSet;
  permissao:=T99permissions.Create;
  diag := TFancyDialog.Create(self);
  Layout2.Visible := False;




  // Seta variavel global...
  frmPrincipal.StatusBarColor := PRIMARY;

  qtdCarrinho := 0;

  {$IFDEF ANDROID}
  TAndroidHelper.Activity.getWindow.clearFlags(TJWindowManager_LayoutParams.JavaClass.FLAG_TRANSLUCENT_STATUS);
  TAndroidHelper.Activity.getWindow.clearFlags(TJWindowManager_LayoutParams.JavaClass.FLAG_LAYOUT_NO_LIMITS);
  TAndroidHelper.Activity.getWindow.setStatusBarColor(PRIMARY);
  {$ENDIF}

  {$IFDEF IOS}
  frmPrincipal.SystemStatusBar.Visibility := TFormSystemStatusBar.TVisibilityMode.Visible;
  frmPrincipal.SystemStatusBar.BackgroundColor := PRIMARY;
  {$ENDIF}


end;


procedure TfrmPrincipal.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
var
  Fechar : Boolean;
begin
      if Key = vkHardwareBack then
      begin
        key := 0;
        FormCloseQuery(Sender, Fechar);
      end;


end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  Image3.AnimateFloat('opacity',1,2
                      ,TAnimationType.&In
                      ,TInterpolationType.Circular);
end;

procedure TfrmPrincipal.banner(arrayJson:TJSONArray;
                     {$IFDEF MSWINDOWS}
                     ACallBack: TExecutaClickWin = nil
                     {$ELSE}
                     ACallBack: TExecutaClickMobile = nil
                     {$ENDIF});

var
  I: Integer;
  banner:TRectangle;
begin

  for I := 0 to arrayJson.Size -1 do
    begin

      banner := TRectangle.Create(VertScrollBox2);
      VertScrollBox2.AddObject(banner);
      banner.Name                 := Self.Name+inttostr(i);
      banner.Align                := TAlignLayout.Top;
      banner.Height               := 110;
      banner.Fill.Color           := TAlphaColorRec.White;
      banner.Fill.Kind            := TBrushKind.Bitmap;
      banner.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
      banner.Fill.Bitmap.Bitmap   := SetAsBase64(arrayJson.Get(i).GetValue<String>('imagem'));
      banner.Stroke.Color         := TAlphaColorRec.White;
      banner.Stroke.Thickness     := 2;
      banner.XRadius              := 5;
      banner.yRadius              := 5;
      banner.Margins.Left         := 10;
      banner.Margins.Right        := 10;
      banner.Margins.Top          := 2;
      banner.Margins.Bottom       := 0;
      banner.Tag                  :=arrayJson.Get(i).GetValue<Integer>('grupo');
      {$IFDEF MSWINDOWS}
      banner.OnClick := ACallBack;
      {$ELSE}
      banner.OnTap := ACallBack;
      {$ENDIF}

//      banner.OnClick := clickBanner(self);
    end;

end;

procedure TfrmPrincipal.clickBanner(Sender:Tobject);
begin
 // ShowMessage(nome);
end;

procedure TfrmPrincipal.Image2Click(Sender: TObject);
begin
  Layout2.Visible := False;
end;

procedure TfrmPrincipal.AddProduto(codigo,descricao,imagem:string;preco,precoApp:Double);
begin
  with lvItens.Items.Add do
    begin
        Detail := codigo;
        TListItemText(Objects.FindDrawable('Text1')).Text := descricao;
        TListItemText(Objects.FindDrawable('Text2')).Text := 'Preco R$ '+FormatFloat('0.00',preco);
        TListItemText(Objects.FindDrawable('Text3')).Text := 'Club R$ '+FormatFloat('0.00',precoApp);
//        TListItemText(Objects.FindDrawable('Text4')).Text := descricao;
        //TListItemText(Objects.FindDrawable('Text5')).Text := descricao;
    end;

end;

procedure TfrmPrincipal.imgAba1Click(Sender: TObject);
var
jsoObj:Tjsonobject;
ResultsObj:TJSONObject;
begin



   mudarAba(TImage(Sender));
 case Timage(Sender).Tag of
   0:begin

     end;
   2:begin
      MostarMinhaCompra;

      //
     end;
   3:begin

     end;
 end;



end;

procedure TfrmPrincipal.Label2Click(Sender: TObject);
begin
  ShowMessage(lvItens.Items.Count.ToString);
end;

procedure TfrmPrincipal.ListView1ItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
begin

  if TListView(Sender).Selected <> nil then
    begin
     if ItemObject is TListItemImage then
       begin
        if TListItemImage(ItemObject).Name = 'Image4' then
          begin
             diag.TagString := ListView1.Items[ListView1.Selected.Index].Detail;
             diag.Show(TIconDialog.Question, 'Pergunta',
              'Confirma a exclus�o do Item ?', 'Sim', ClickOK, 'N�o', ClickCancel);
          end;
       end;
    end;
end;

procedure TFrmPrincipal.deleteItem(codProduto: string);
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
  cpf,cnpj:string;
  str,sRetorno:string;
  retorno:TRetornoWS;
  mpFormData: TRESTRequestParameterList;

begin


  try

      mpFormData:= TRESTRequestParameterList.Create(Self);


      with mpFormData.AddItem do
      begin
        ContentType:= ctAPPLICATION_JSON;
        Name  := 'x-access-token';
        Value :=  dm.buscaToken;
        Kind  := pkHTTPHEADER;
      end;

      retorno := SendData(fcRemove, mpFormData, False,URI+'/lista/'+codProduto);

      if(retorno.FCodigo = 200)then
        begin
         MostarMinhaCompra;
        end
      else
        begin
          diag.Show(TIconDialog.Error,'Desculpe','N�o consegui executar essa tarefa');
        end;



  except
    on E: Exception do
      begin
        ShowMessage(E.Message);
      end;
  end;

end;

procedure TFrmPrincipal.ClickOK(Sender: TObject);
begin
//    showmessage('Excluir registro: ' + diag.TagString);
    deleteItem(diag.TagString);



end;

procedure TFrmPrincipal.ClickFechar(Sender: TObject);
begin

 if dm.sCod <> ''  then
  begin
    frmPrincipal.deleteItem(dm.sCod);

  end;


   Application.Terminate;
end;


{$IFDEF MSWINDOWS}
procedure TFrmPrincipal.ClickItem(Sender: TObject);
var
    cod_item : string;
    ResultsObj:TJSONObject;
    jsonArray:TJSONArray;
begin
  cod_item := TRectangle(Sender).Tag.ToString;
  dm.nPaginas := 1;
  lvitens.items.Clear;
  lvItens.BeginUpdate;
  TThread.CreateAnonymousThread(procedure
  begin
    ResultsObj := TJSONObject.Create;
    jsonArray:= nil;
//    frmPrincipal.lvItens.Tag := 1;
    dm.buscaItens(dm.nPaginas,cod_item,'', ResultsObj);
    jsonArray:= ResultsObj.GetValue('dados') as TJSONArray;


    tthread.Synchronize(nil,procedure
      var i:Integer;
      begin
        for I := 0 to jsonArray.Size -1 do
          begin
               montaLista(jsonArray.get(i).GetValue<String>('cod_produto'),
                          jsonArray.get(i).GetValue<String>('descricao'),
                          StringReplace(jsonArray.get(i).GetValue<String>('preco'),'.',',',[]),
                          StringReplace(jsonArray.get(i).GetValue<String>('promocao'),'.',',',[]),
                          jsonArray.get(i).GetValue<String>('imagem_grande'),
                          '0');
          end;

         //nPaginas := nPaginas + 1;
         lvItens.EndUpdate;

      end);


  end).Start;
   imgAba1Click(imgAba4);
   // showmessage('Abrir detalhes categoria ' + cod_item);
end;
{$ELSE}
procedure TFrmPrincipal.ClickItem(Sender: TObject; const Point: TPointF);
var
    cod_item : string;
    ResultsObj:TJSONObject;
    jsonArray:TJSONArray;
begin
  cod_item := TRectangle(Sender).Tag.ToString;
  dm.nPaginas := 1;
  lvitens.items.Clear;
  lvItens.BeginUpdate;
  TThread.CreateAnonymousThread(procedure
  begin
    ResultsObj := TJSONObject.Create;
    jsonArray:= nil;
  //  frmPrincipal.lvItens.Tag := 1;
    dm.buscaItens(dm.nPaginas,cod_item,'', ResultsObj);
    jsonArray:= ResultsObj.GetValue('dados') as TJSONArray;


    tthread.Synchronize(nil,procedure
      var i:Integer;
      begin
        for I := 0 to jsonArray.Size -1 do
          begin
               montaLista(jsonArray.get(i).GetValue<String>('cod_produto'),
                          jsonArray.get(i).GetValue<String>('descricao'),
                          StringReplace(jsonArray.get(i).GetValue<String>('preco'),'.',',',[]),
                          StringReplace(jsonArray.get(i).GetValue<String>('promocao'),'.',',',[]),
                          jsonArray.get(i).GetValue<String>('imagem_grande'),
                          '0');
          end;

         //nPaginas := nPaginas + 1;
         lvItens.EndUpdate;

      end);


  end).Start;

   imgAba1Click(imgAba4);
  //  showmessage('Abrir detalhes categoria ' + cod_item);
end;
{$ENDIF}



procedure TFrmPrincipal.ClickCancel(Sender: TObject);
begin
   // showmessage('Cancel');
end;

procedure TfrmPrincipal.ListView1UpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
 var txt:TListItemText;
      img:TListItemImage;
begin
   with AItem do
    begin

      Height := 70;
    //  img.OwnsBitmap := True;
      img := TListItemImage(Objects.FindDrawable('Image3'));
      img.Width  := 50;
      img.Height := 50;
      img.PlaceOffset.X := 10;
      img.PlaceOffset.y := 10;


      txt := TListItemText(Objects.FindDrawable('Text1'));
      txt.Width  := ListView1.Width - 150;
      txt.Height := 25;
      txt.Font.Size := 10;
      txt.WordWrap := True;
      txt.TextAlign := TTextAlign.Leading;
      txt.TextVertAlign := TTextAlign.Leading;
      txt.PlaceOffset.X := 80;
      txt.PlaceOffset.y := 15;

      txt := TListItemText(Objects.FindDrawable('Text2'));
      txt.Width  := ListView1.Width - 120;
      txt.Height := 10;
      txt.Font.Size := 8;
      txt.WordWrap := True;
      txt.TextAlign := TTextAlign.Leading;
      txt.PlaceOffset.X := 80;
      txt.PlaceOffset.y := 45;

    end;
end;

procedure TfrmPrincipal.lvCarrinhoUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
  var txt:TListItemText;
      img:TListItemImage;
begin
   with AItem do
    begin

      Height := 70;
      img.OwnsBitmap := True;
      img := TListItemImage(Objects.FindDrawable('Image3'));
      img.Width  := 60;
      img.Height := 60;
      img.PlaceOffset.X := 10;
      img.PlaceOffset.y := 10;


     { txt := TListItemText(Objects.FindDrawable('txtDescricao'));
     { txt.Width  := lvCarrinho.Width - 120;
      txt.Height := 25;
      txt.Font.Size := 10;
      txt.WordWrap := True;
      txt.TextAlign := TTextAlign.Leading;
      txt.TextVertAlign := TTextAlign.Leading;
      txt.PlaceOffset.X := 80;
      txt.PlaceOffset.y := 15;    }
                                   {
      txt := TListItemText(Objects.FindDrawable('Text2'));
      txt.Width  := lvCarrinho.Width - 120;
      txt.Height := 10;
      txt.Font.Size := 8;
      txt.WordWrap := True;
      txt.TextAlign := TTextAlign.Leading;
      txt.PlaceOffset.X := 80;
      txt.PlaceOffset.y := 45;   }

    end;
end;

procedure TfrmPrincipal.lvItensItemClick(const Sender: TObject;
  const AItem: TListViewItem);
  var img :String;
  jso:TjsonObject;
  jsonArray:Tjsonarray;
  I: Integer;
begin

  // imgDetalhe.Visible := false;
  // LayoutBuscaImagem.Visible := true;
   //AniIndicator1.Enabled := true;

  with AItem do
   begin


     lbDesc.Text           := TListItemText(Objects.FindDrawable('Text1')).Text;
     lbQtd.Text            := '1';
     lblVlrUnitario.Text   := 'R$ '+FormatFloat('0.00',strtofloat(StringReplace(copy(TListItemText(Objects.FindDrawable('Text3')).Text,9,20),'.',',',[])));
     lbValor.Text          := 'R$ '+FormatFloat('0.00',strtofloat(StringReplace(copy(TListItemText(Objects.FindDrawable('Text3')).Text,9,20),'.',',',[])));
     lbValorClub.Text      := 'R$ '+FormatFloat('0.00',strtofloat(StringReplace(copy(TListItemText(Objects.FindDrawable('Text4')).Text,18,20),'.',',',[])));
     lbTotal.Text          := 'R$ '+FormatFloat('0.00',strtofloat(StringReplace(copy(TListItemText(Objects.FindDrawable('Text3')).Text,9,20),'.',',',[])));
     lbTotalClub.Text      := 'R$ '+FormatFloat('0.00',strtofloat(StringReplace(copy(TListItemText(Objects.FindDrawable('Text4')).Text,18,20),'.',',',[])));
     rValorVenda           := strtofloat(StringReplace(copy(TListItemText(Objects.FindDrawable('Text3')).Text,9,20),'.',',',[]));
     rValorVendacDesconto  := StrToFloat(StringReplace(copy(TListItemText(Objects.FindDrawable('Text4')).Text,18,20),'.',',',[]));
     imgDetalhe.Bitmap     := TListItemImage(Objects.FindDrawable('Image2')).Bitmap;

     Rectangle7.TagString  := Detail;
     Rectangle6.TagString  := lvItens.Items[lvItens.Selected.Index].Detail;
     Layout2.Visible       := True;
     Rectangle6.AnimateFloat('margins.buttom',0,1
                           ,TAnimationType.InOut
                           ,TInterpolationType.Circular);

    { TThread.CreateAnonymousThread(procedure
     var i:integer;
     begin
       jso := TJSONObject.Create;
       jsonArray:= nil;
       dm.BuscaImagem(Detail,jso);
       jsonArray:= jso.GetValue('dados') as TJSONArray;
       for I := 0 to jsonArray.Size -1 do
        begin
          img := jsonArray.get(i).GetValue<String>('imagem');
        end;

       tthread.Synchronize(nil,procedure
       begin

         imgDetalhe.Bitmap     := SetAsBase64(img);
         LayoutBuscaImagem.Visible := False;
         AniIndicator1.Enabled     := False;
         imgDetalhe.Visible        := true;

       end);


     end).Start;   }



     //imgDetalhe.Bitmap     := TListItemImage(Objects.FindDrawable('Image2')).Bitmap;

   END;

end;

procedure TfrmPrincipal.lvItensItemClickEx(const Sender: TObject;
  ItemIndex: Integer; const LocalClickPos: TPointF;
  const ItemObject: TListItemDrawable);
var img:TListItemImage;
   jsoOb:TJSONObject;
   jsonArray:TJSONArray;
   i:integer;
   str:TStringList;
begin
  { imgDetalhe.Bitmap := ImgSemImagem.Bitmap;

   if TListView(sender).Selected <> nil then
     begin

        if ItemObject is TListItemImage then
         begin

            if TListItemImage(ItemObject).Name = 'Image5' then
             begin

//                 imgDetalhe.Bitmap :=  TListItemImage(ItemObject).Bitmap;

                lbDesc.Text         := '';
                lbQtd.Text          := '1';
                lbValor.Text        := 'R$ '+FormatFloat('0.00',0);
                lbValorClub.Text    := 'No clube R$ '+FormatFloat('0.00',0);
                lbTotal.Text        := 'Total R$ '+FormatFloat('0.00',0);
                lbTotalClub.Text    := 'Total No clube R$ '+FormatFloat('0.00',0);

               // TListItemImage(ItemObject).Bitmap := imgDesativado.Bitmap;
               TThread.CreateAnonymousThread(procedure
                begin
                  with frmprincipal do
                   begin
                    jsonArray:= nil;
                    Dm.buscaItem(lvItens.Items[lvItens.Selected.Index].Detail,jsoOb);
                    rectangle7.TagString := lvItens.Items[lvItens.Selected.Index].Detail;
                    jsonArray:= jsoOb.GetValue('dados') as TJSONArray;


                      TThread.Synchronize(nil,procedure
                       begin
                          lbDesc.Text  := jsonArray.get(i).GetValue<String>('descricao');
                          lbQtd.Text       := '1';
                          lbValor.Text     := 'R$ '+FormatFloat('0.00',strtofloat(StringReplace(jsonArray.get(i).GetValue<String>('preco'),'.',',',[])));
                          lbValorClub.Text := 'No clube R$ '+FormatFloat('0.00',strtofloat(StringReplace(jsonArray.get(i).GetValue<String>('promocao'),'.',',',[])));
                          lbTotal.Text     := 'Total R$ '+FormatFloat('0.00',strtofloat(StringReplace(jsonArray.get(i).GetValue<String>('preco'),'.',',',[])));
                          lbTotalClub.Text := 'Total No clube R$ '+FormatFloat('0.00',strtofloat(StringReplace(jsonArray.get(i).GetValue<String>('promocao'),'.',',',[])));
                          rValorVenda           := strtofloat(stringReplace(jsonArray.Get(i).GetValue<string>('preco'),'.',',',[]));
                          rValorVendacDesconto  := StrToFloat(stringReplace(jsonArray.Get(i).GetValue<String>('promocao'),'.',',',[]));
                          imgDetalhe.Bitmap := BitmapFromBase64(jsonArray.get(i).GetValue<String>('imagem_grande'));
                       end);

                   end;

                end).start;
                Rectangle6.TagString := lvItens.Items[lvItens.Selected.Index].Detail;
                {layoutlancaitens.AnimateFloat('margins.top',0,1
                                               ,TAnimationType.InOut
                                               ,TInterpolationType.Circular);}
              {  Layout2.Visible  := True;
                Rectangle6.AnimateFloat('margins.buttom',0,1
                                               ,TAnimationType.InOut
                                               ,TInterpolationType.Circular);

             end;

         end;
     end;
           }
end;

procedure TfrmPrincipal.lvItensPaint(Sender: TObject; Canvas: TCanvas;
  const ARect: TRectF);
  var ResultsObj:TjsonObject;
      jsonArray:TJSONArray;
begin
  if dm.nPaginas >= totalPaginas +1 then
      exit;



   if lvItens.Items.Count > 0 then
      begin
        if lvItens.GetItemRect(lvItens.Items.Count - 4).Bottom <= lvItens.Height then
         begin


           if frmPrincipal.lvItens.Tag > 0 then
             begin
              Exit;
             end;

           frmPrincipal.lvItens.Tag := 1;


           lvItens.BeginUpdate;
            TThread.CreateAnonymousThread(procedure
            begin
              ResultsObj := TJSONObject.Create;
              jsonArray:= nil;


              dm.buscaItens(dm.npaginas,'','', ResultsObj);
              jsonArray:= ResultsObj.GetValue('dados') as TJSONArray;


              tthread.Synchronize(nil,procedure
                var i:Integer;
                begin
                  for I := 0 to jsonArray.Size -1 do
                    begin
                         montaLista(jsonArray.get(i).GetValue<String>('cod_produto'),
                                    jsonArray.get(i).GetValue<String>('descricao'),
                                    StringReplace(jsonArray.get(i).GetValue<String>('preco'),'.',',',[]),
                                    StringReplace(jsonArray.get(i).GetValue<String>('promocao'),'.',',',[]),
                                    jsonArray.get(i).GetValue<String>('imagem_grande'),
                                    '0');
                    end;


                   lvItens.EndUpdate;

                end);


            end).Start;

         end;
      end;
end;

procedure TfrmPrincipal.lvItensUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
  var txt:TlistitemText;
      img:TlistitemImage;
      imgitens2:TImage;
      foto64:TBitmap;
begin

  with AItem  do
    begin

      Height := 100;

       if img = nil  then
          img := TListItemImage.Create(Aitem);
       img := Objects.FindDrawable('Image2') as TListItemImage;
       img.Width  := 70;
       img.Height := 70;
       img.PlaceOffset.X := 5;
       img.PlaceOffset.y := 10;
       img.OwnsBitmap := True;
       img.Name := 'Image2';
       img.ScalingMode := TImageScalingMode.StretchWithAspect;



      //txt descricao
       txt := Objects.FindDrawable('Text1') as TListItemText;
       if txt = nil  then
          txt := TListItemText.Create(Aitem);
       txt.Font.Size     := 10;
       txt.Height        := 40;
       txt.Font.Style    := [TFontStyle.fsBold];
       txt.PlaceOffset.X := 80;
       txt.PlaceOffset.y := 20;
       txt.Name          := 'Text1';
       txt.WordWrap      := False;
       txt.Width         := frmPrincipal.lvItens.Width - 240;
       txt.TextAlign     := TTextAlign.Leading;
       txt.TextVertAlign := TTextAlign.Leading;
       txt.WordWrap      := true;


       //txt Preco
       txt := Objects.FindDrawable('Text3') as TListItemText;
       if txt = nil  then
          txt            := TListItemText.Create(Aitem);
       txt.Font.Size     := 10;
       txt.Height        := 12;
       txt.Width         := frmPrincipal.lvItens.Width - 200;
       txt.PlaceOffset.X := -10;
       txt.PlaceOffset.y := 20;
       txt.Name          := 'Text3';
       txt.TextAlign     := TTextAlign.Trailing;
       txt.Align         := TListItemAlign.Trailing;

      { txt := Objects.FindDrawable('Text6') as TListItemText;
       if txt = nil  then
          txt            := TListItemText.Create(Aitem);
       txt.Font.Size     := 10;
       txt.Height        := 12;
       txt.Width         := 100;
       txt.PlaceOffset.X := 85+frmPrincipal.lvItens.Width - 200;
       txt.PlaceOffset.y := 20;
       txt.Name          := 'Text3';
       txt.TextAlign     := TTextAlign.Leading;

       txt := Objects.FindDrawable('Text7') as TListItemText;
       if txt = nil  then
          txt            := TListItemText.Create(Aitem);
       txt.Font.Size     := 10;
       txt.Height        := 12;
       txt.Width         := 100;
       txt.PlaceOffset.X := 85+frmPrincipal.lvItens.Width - 200;
       txt.PlaceOffset.y := 35;
       txt.Name          := 'Text7';
       txt.TextAlign     := TTextAlign.Leading;   }



       //txt Preco
       txt := Objects.FindDrawable('Text4') as TListItemText;
       if txt = nil  then
          txt := TListItemText.Create(Aitem);
       txt.Font.Size     := 10;
       txt.Height        := 14;
       txt.Width         := frmPrincipal.lvItens.Width - 200;
    //   txt.PlaceOffset.X := 85+frmPrincipal.lvItens.Width - 200;
       txt.PlaceOffset.X := -10;
       txt.PlaceOffset.y := 35;
       txt.Name          := 'Text4';
       txt.Font.Style    := [TFontStyle.fsBold];
       txt.TextAlign     := TTextAlign.Trailing;
//       txt.TextAlign := TTextAlign.Center;
       txt.Align := TListItemAlign.Trailing;


      { img := Objects.FindDrawable('image5') as TListItemImage;
       if img = nil  then
          img := TListItemImage.Create(Aitem);
       img.Bitmap   := imgAtv.Bitmap;
       img.TagFloat := 0;
       img.Width  :=lvItens.Width;
       img.Height := 40;
       img.PlaceOffset.X := 1;
       img.PlaceOffset.y := 173;
       img.Name := 'Image5';
       img.Align := TListItemAlign.Trailing;
       img.ScalingMode := TImageScalingMode.Stretch;


       //txt ATIVAR
       txt := Objects.FindDrawable('Text6') as TListItemText;
       if txt = nil  then
       txt := TListItemText.Create(Aitem);
       txt.Text := 'COMPRAR';
       txt.Font.Size := 12;
       txt.Font.Style := [TFontStyle.fsBold];
       txt.TextColor := TalphaColors.White;
       txt.PlaceOffset.X := -8;
       txt.PlaceOffset.y := 175;
       txt.Name  := 'Text6';
       txt.Width := 80;
       txt.Height:= 30;
       txt.TextAlign := TTextAlign.Center;
       txt.Align := TListItemAlign.Trailing;     }
    end;
end;

procedure TfrmPrincipal.montaCarrinho(codigo, descricao, preco, promocao,
  imagem, qtd: String);
  var foto64:TBitmap;
begin

    // listView1.BeginUpdate;

 try


   if  codigo <> dm.scod  then
   begin

   with ListView1.Items.Add do
    begin
        Detail := codigo;
        TListItemText(Objects.FindDrawable('Text1')).Text     := descricao;
        TListItemText(Objects.FindDrawable('Text2')).Text     := FormatFloat('0.00',qtd.ToDouble())+' X '+FormatFloat('0.00',preco.ToDouble())+' = '+FormatFloat('0.00',qtd.ToDouble*preco.ToDouble());
        TListItemImage(Objects.FindDrawable('Image3')).OwnsBitmap := true;
        TListItemImage(Objects.FindDrawable('Image3')).Bitmap := SetAsBase64(imagem);

       { MyThread := TMyThread.Create;
        MyThread.codigo := codigo;
        MyThread.img    := TListItemImage(Objects.FindDrawable('Image3'));
        MyThread.OnTerminate := ThreadTerminate;
        MyThread.FreeOnTerminate := true;
        MyThread.Start;
        }

        TListItemImage(Objects.FindDrawable('Image4')).Bitmap := imgLixo.Bitmap;
        imagem:='';
    end;

    // listView1.EndUpdate;
  end;
 Except


 end;

end;

procedure TfrmPrincipal.montaLista(codigo, descricao, preco, promocao, imagem,
  usado: String);
  var foto64:TBitmap;
begin
   with lvItens.Items.Add do
    begin
        Detail := codigo;
        TListItemText(Objects.FindDrawable('Text1')).Text := descricao;
        TListItemText(Objects.FindDrawable('Text3')).Text := 'Pre�o R$ '+FormatFloat('0.00',preco.ToDouble());
       // TListItemText(Objects.FindDrawable('Text6')).Text := 'pre�o';
      //  TListItemText(Objects.FindDrawable('Text7')).Text := 'pre�o no Club';
        TListItemText(Objects.FindDrawable('Text4')).Text := 'Pre�o no clube R$ '+FormatFloat('0.00',promocao.ToDouble());
        TListItemImage(Objects.FindDrawable('Image2')).OwnsBitmap := true;
       // imgItem.Bitmap := SetAsBase64(imagem);
    {
      try
      // Criar Thread para busca da foto...
        MyThread := TMyThread.Create;
        MyThread.codigo := codigo;
        MyThread.img    := TListItemImage(Objects.FindDrawable('Image2'));
        MyThread.OnTerminate := ThreadTerminate;
        MyThread.FreeOnTerminate := true;
        MyThread.Start;

      finally

      end;  }


        TListItemImage(Objects.FindDrawable('Image2')).Bitmap := SetAsBase64(imagem);
  //      imagem:='';
    end;
end;

procedure TfrmPrincipal.ThreadTerminate(Sender: TObject);
begin

    if Assigned(TThread(Sender).FatalException) then
        showmessage('Erro na thread FOTO: ' + Exception(TThread(Sender).FatalException).Message);

end;


procedure TfrmPrincipal.Timer1Timer(Sender: TObject);
var jsonArray:TJSONArray;
    ArraySlide:TJSONArray;
    ResultsObj:TJSONObject;
    ResultsSlide:TJSONObject;
    ResultsBanners:TJSONObject;
    ArrayBanners:TJSONArray;
    resultsObjP:TJSONPair;
    erro,usado:string;
    codProduto,descricao,precoloja,precoApp,imagem,validade:string;
    i:Integer;
    resultado:Boolean;
begin

  Timer1.Enabled := False;

 { if not dm.VerificaInternet then
   begin
     ShowMessage('Voc� est� sem internet');
     Exit;
   end;   }
  dm.nPaginas := 1;
  dm.token := '';
  dm.token := dm.buscaToken;
  mudarAba(imgAba1);
  ResultsSlide := TJSONObject.Create;
  ArraySlide := nil;
  dm.buscaSlides(ResultsSlide);
  ArraySlide := ResultsSlide.GetValue('dados') as TJSONArray;
  LayoutSlide.Slide(ArraySlide);

   ResultsBanners := TJSONObject.Create;
   ArrayBanners := nil;
   dm.buscaBanners(ResultsBanners);
   ArrayBanners := ResultsBanners.GetValue('dados') as TJSONArray;

   banner(ArrayBanners,ClickItem);

   rctInicial.Visible := False;

   totalPaginas := dm.paginas;

  lvItens.BeginUpdate;
  TThread.CreateAnonymousThread(procedure
  begin
    ResultsObj := TJSONObject.Create;
    jsonArray:= nil;
    dm.buscaItens(dm.nPaginas,'','', ResultsObj);
    jsonArray:= ResultsObj.GetValue('dados') as TJSONArray;


    tthread.Synchronize(nil,procedure
      var i:Integer;
      begin
        for I := 0 to jsonArray.Size -1 do
          begin
               montaLista(jsonArray.get(i).GetValue<String>('cod_produto'),
                          jsonArray.get(i).GetValue<String>('descricao'),
                          StringReplace(jsonArray.get(i).GetValue<String>('preco'),'.',',',[]),
                          StringReplace(jsonArray.get(i).GetValue<String>('promocao'),'.',',',[]),
                          jsonArray.get(i).GetValue<String>('imagem_grande'),
                          '0');
          end;

         //nPaginas := nPaginas + 1;
         lvItens.EndUpdate;

      end);


  end).Start;





 // cargaMensagem;

end;

procedure TfrmPrincipal.MostarMinhaCompra;
var jsonArray:TJSONArray;
    ResultsObj:TJSONObject;
    resultsObjP:TJSONPair;
    erro,usado:string;
    codProduto,descricao,precoloja,precoApp,imagem,validade,qtd:string;
    i:Integer;
    resultado:Boolean;
    strValor:string;
    t:TThread;
begin
  if not dm.VerificaInternet then
   begin
    ShowMessage('Voc� est� sem internet');
     Exit;
   end;

   cdsListaItens.Close;
   cdsListaItens.CreateDataSet;
   rVlrCompra     := 0;
   rVlrCompraDesc := 0;

  TLoading.Show(frmPrincipal,'Aguarde...');

   t.CreateAnonymousThread(procedure
   var i:integer;
   begin

       strValor := copy(lbSubTotal.text,13,20);

    if formatfloat('0.00',dm.buscaValor) = strValor then
       begin
         t.Synchronize(nil,procedure
           begin
           TLoading.Hide;
           end);

         exit;
       end;

      ResultsObj := TJSONObject.Create;
      jsonArray:= nil;
       try
        dm.MeuCarrinho(ResultsObj);
       except
        exit
       end;

      jsonArray:= ResultsObj.GetValue('dados') as TJSONArray;


       ListView1.Items.Clear;
       qtdCarrinho := jsonArray.Size;
      for I := 0 to jsonArray.Size -1 do
        begin
          precoloja := StringReplace(jsonArray.get(i).GetValue<String>('preco'),'.',',',[]);
          precoApp  := StringReplace(jsonArray.get(i).GetValue<String>('promocao'),'.',',',[]);
          qtd       := StringReplace(jsonArray.get(i).GetValue<String>('qtd'),'.',',',[]);

          cdsListaItens.append;
          cdslistaItensCod_produto.asstring := jsonArray.get(i).GetValue<String>('codproduto');
          cdsListaItensdescricao.asstring   := jsonArray.get(i).GetValue<String>('descricao');
          cdsListaItensqtd.AsFloat          := StrToFloat(qtd);
          cdsListaItensvalor.AsFloat        := StrToFloat(precoApp);
          cdsListaItensvenda.AsFloat        := StrToFloat(precoloja);
          cdsListaItenstotal.AsFloat        := StrToFloat(precoApp)*StrToFloat(qtd);
          cdsListaItens.Post;

          t.Synchronize(nil,procedure
          begin

             montaCarrinho(jsonArray.get(i).GetValue<String>('codproduto'),
                          jsonArray.get(i).GetValue<String>('descricao'),
                          precoloja,
                          precoApp,
                          jsonArray.get(i).GetValue<String>('imagem'),
                          //'',
                          qtd);


            rVlrCompra     := rVlrCompra + qtd.ToDouble*precoLoja.ToDouble;
            rVlrCompraDesc := rVlrCompraDesc + qtd.ToDouble*precoapp.ToDouble;
          end);

        end;

        t.Synchronize(nil,procedure
          begin
           TLoading.Hide;
           lbSubTotal.Text := 'SubTotal R$ '+FormatFloat('0.00',rVlrCompra);
           lbSubTotalClub.Text := 'SubTotal no Club R$ '+FormatFloat('0.00',rVlrCompraDesc );


          end);

   end).Start;




end;

function TfrmPrincipal.SetAsBase64(const ASource: string):TBitmap;
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

procedure TfrmPrincipal.SpeedButton1Click(Sender: TObject);
begin
  if strtofloat(lbQtd.Text)> 1 then
      lbQtd.Text := FormatFloat('0',StrToFloat(lbQtd.Text)-1);
      lbTotal.Text := 'R$ '+FormatFloat('0.00',rValorVenda*StrToFloat(lbQtd.Text));
      lbTotalClub.Text := 'R$ '+FormatFloat('0.00',rValorVendacDesconto*StrToFloat(lbQtd.Text));
end;

procedure TfrmPrincipal.SpeedButton2Click(Sender: TObject);
begin
  lbQtd.Text := FormatFloat('0',StrToFloat(lbQtd.Text)+1);
  lbTotal.Text     := 'R$ '+FormatFloat('0.00',rValorVenda*StrToFloat(lbQtd.Text));
  lbTotalClub.Text := 'R$ '+FormatFloat('0.00',rValorVendacDesconto*StrToFloat(lbQtd.Text));

end;

procedure TfrmPrincipal.SpeedButton3Click(Sender: TObject);
var ResultsObj:TjsonObject;
    jsonArray:TjsonArray;
begin


  btnClear.Visible := True;
  SpeedButton3.Visible := False;
  lvItens.Items.clear;
  lvItens.BeginUpdate;
  TThread.CreateAnonymousThread(procedure
  begin
    dm.nPaginas := 1;
    ResultsObj := TJSONObject.Create;
    jsonArray:= nil;
//    frmPrincipal.lvItens.Tag := 1;
    dm.buscaItens(dm.nPaginas,'',edtPesquisa.Text, ResultsObj);
    jsonArray:= ResultsObj.GetValue('dados') as TJSONArray;


    tthread.Synchronize(nil,procedure
      var i:Integer;
      begin

        if jsonArray.Size = 0 then
          rctNotFound.Visible := True
        else
          rctNotFound.Visible := False;


        for I := 0 to jsonArray.Size -1 do
          begin
               montaLista(jsonArray.get(i).GetValue<String>('cod_produto'),
                          jsonArray.get(i).GetValue<String>('descricao'),
                          StringReplace(jsonArray.get(i).GetValue<String>('preco'),'.',',',[]),
                          StringReplace(jsonArray.get(i).GetValue<String>('promocao'),'.',',',[]),
                          jsonArray.get(i).GetValue<String>('imagem_grande'),
                          '0');
          end;

         //nPaginas := nPaginas + 1;
         lvItens.EndUpdate;

      end);


  end).Start;


end;

procedure TfrmPrincipal.mudarAba(img:Timage);
begin

   imgAba1.Opacity := 0.6;
   imgAba2.Opacity := 0.6;
   imgAba3.Opacity := 0.6;
   imgAba4.Opacity := 0.6;
   img.Opacity := 1;
   TabControl1.GotoVisibleTab(img.Tag,TTabTransition.None)
end;



procedure TfrmPrincipal.Rectangle10Click(Sender: TObject);
begin
  if not Assigned(frmStatus) then
      Application.CreateForm(TfrmStatus,frmStatus);

     frmStatus.Show;
end;

{ TRetornoWS }

function TfrmPrincipal.SendData(const ACommand: TCommand;
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

{ TMyThread }
function BitmapFromBase64(const base64: string): TBitmap;
var
        Input: TStringStream;
        Output: TBytesStream;
begin
        Input := TStringStream.Create(base64, TEncoding.ASCII);
        try
                Output := TBytesStream.Create;
                try
                        Soap.EncdDecd.DecodeStream(Input, Output);
                        Output.Position := 0;
                        Result := TBitmap.Create;
                        try
                                Result.LoadFromStream(Output);
                        except
                                Result.Free;
                                raise;
                        end;
                finally
                        Output.DisposeOf;
                end;
        finally
                Input.DisposeOf;
        end;
end;

constructor TMyThread.Create;
begin
  inherited Create(True);
end;

procedure TMyThread.Execute;
 var jsonArray:TJSONArray;
     ResultsObj:TJSONObject;
     I:integer;
     imagem : string;
     bmp  : TBitmap;
begin
  inherited;
   ResultsObj := TJSONObject.Create;
  jsonArray:= nil;
    try
      dm.BuscaImagem(codigo,ResultsObj);
    except
      exit
    end;
  jsonArray:= ResultsObj.GetValue('dados') as TJSONArray;

   for I := 0 to jsonArray.Size -1 do
    begin
       imagem :=  jsonArray.get(i).GetValue<String>('imagem');
    end;

  if Assigned(jsonArray) then
    jsonArray.DisposeOf;


  Synchronize(procedure
    begin
      bmp := BitmapFromBase64(imagem);

      self.img.Bitmap := bmp;
      self.img.OwnsBitmap := true;

    end);




end;
procedure TfrmPrincipal.FretexProduto;
var ResultsObj:TjsonObject;
    jsonArray:TjsonArray;
    i :Integer;
    cod : string;
    erro,usado:string;
    codProduto,descricao,precoloja,precoApp,imagem,validade,qtd:string;
    resultado:Boolean;
    strValor:string;

begin


    dm.nPaginas := 1;
    ResultsObj := TJSONObject.Create;
    jsonArray:= nil;
    dm.buscaItem(dm.sCod, ResultsObj);
    jsonArray:= ResultsObj.GetValue('dados') as TJSONArray;



        for I := 0 to jsonArray.Size -1 do
          begin
              cod:=(jsonArray.get(i).GetValue<String>('cod_produto'));

          end;


      adicionarLista(cod,'1');

      MostarMinhaCompra;

  





end;
end.
