unit uDm;

interface

uses
  System.SysUtils, System.Classes, System.JSON, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Authenticator.Basic,
  REST.Response.Adapter,System.Net.HTTPClientComponent,Datasnap.DBClient,
  Data.DB,System.IOUtils,System.IniFiles;


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
  Tdm = class(TDataModule)
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTClient1: TRESTClient;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    HTTPBasicAuthenticator1: THTTPBasicAuthenticator;
  procedure buscaItens(nPagina:integer;grupo,descricao:String; var jso: TJSONObject);
  function buscaToken: string;
  function SendData(const ACommand: TCommand;
      Params: TRESTRequestParameterList; ADataOwner: boolean;
      URL: string): TRetornoWS;
  function VerificaInternet: Boolean;
  procedure MeuCarrinho(var jso: TJSONObject);
  procedure DataModuleCreate(Sender: TObject);
  procedure GravaPerfil(cpf: string);
  procedure carregaCliente(var jso:TJSONObject);
  function cadastrarCliente(cpf
                           ,nome
                           ,email
                           ,endereco
                           ,fone
                           ,sobrenome
                           ,empresa
                           ,cep
                           ,numero
                           ,bairro
                           ,cidade:String): string;
    procedure BuscaItem(codigo: string; var jso: TJSONObject);
    procedure buscaMsg(var jso:TJSONObject);
    procedure buscaSlides(var jso: TJSONObject);
    procedure buscaBanners(var jso: TJSONObject);
    procedure BuscaImagem(produto:String;var jso: TJSONObject);
    function buscaValor():real;
    function enviaVenda(entrega,formaPagamento:integer;total:real): string;
    function LerPerfil: string;
    function SendData2(const ACommand: TCommand;
      Params: TRESTRequestParameterList; ADataOwner: boolean;
      URL: string): TRetornoWS;
    procedure deleteItem(codProduto: string);
    function buscaCEP(cep: string): TStringList;
    function paginas: Integer;
  procedure VerificarCep(cep :string;var jso:TJSONObject);

    { Private declarations }
  private





  public
     nPaginas:integer;
     sCpf:string;
     sCadastrado:string;
     sFrete,sCod,sValor : string;
     rValorMin : Real;
     token:string;


 //   const sCnpj= '24395280';
     // const sValorMin = 200;
//    const sCnpj = '00262676';
    const sCnpj = '43172320';
    const URI = 'https://sridesconto.wposcash.com.br';
  //  const URI = 'http://192.168.0.2:3001';
//  const URI = 'http://127.0.0.1:3001';
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

uses
  System.Net.HttpClient, FMX.Dialogs, ufrmPrincipal,uFrmEntrega;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ Tdm }

function TDm.cadastrarCliente(cpf
                           ,nome
                           ,email
                           ,endereco
                           ,fone
                           ,sobrenome
                           ,empresa
                           ,cep
                           ,numero
                           ,bairro
                           ,cidade:String):string;
var
  strResp,strREC:TStringStream;
  jso,jsoItem,jsonFinal,ResultsObj:TJSONObject;
  ResultsArray:TJSONArray;
  sJson:String;
  irespota,x:Integer;
  arrayItens:TJSONArray;
  resultsObjP:TJSONPair;
  jsop:TJSONPair;
  sResult:string;
  str,sRetorno:string;
  retorno:TRetornoWS;
  mpFormData: TRESTRequestParameterList;
  JsonValue:TJSONValue;
  strList:TStringList;
  telefone:string;
begin

    telefone := StringReplace(fone,'-','',[rfReplaceAll,rfIgnoreCase]);
    telefone := StringReplace(telefone,'(','',[rfReplaceAll,rfIgnoreCase]);
    telefone := StringReplace(telefone,')','',[rfReplaceAll,rfIgnoreCase]);
    telefone := StringReplace(telefone,' ','',[rfReplaceAll,rfIgnoreCase]);
    sCpf := cpf;


  try

 //       URI:= 'http://127.0.0.1:3001/lista';

      mpFormData:= TRESTRequestParameterList.Create(Self);
      jsoItem:= TJSONObject.Create;
      jsoItem.AddPair( TJSONPair.Create('cpf',cpf));
      jsoItem.AddPair( TJSONPair.Create('nome',UpperCase(nome)));
      jsoItem.AddPair( TJSONPair.Create('email',email));
      jsoItem.AddPair( TJSONPair.Create('endereco',UpperCase(endereco)));
      jsoItem.AddPair( TJSONPair.Create('fone',telefone));
      jsoItem.AddPair( TJSONPair.Create('sobrenome',UpperCase(sobrenome)));
      jsoItem.AddPair( TJSONPair.Create('empresa',sCnpj));
      jsoItem.AddPair( TJSONPair.Create('cep',cep));
      jsoItem.AddPair( TJSONPair.Create('numero',numero));
      jsoItem.AddPair( TJSONPair.Create('bairro',bairro));
      jsoItem.AddPair( TJSONPair.Create('cidade',cidade));

      {strlist := TstringList.create;
      strlist.Text := jsoItem.ToString;
      strList.SaveToFile('C:\temp\mmmmm.txt');

      Exit;  }

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
        Value := buscaToken;
        Kind  := pkHTTPHEADER;
      end;

      retorno := SendData(fcPost, mpFormData, False,URI+'/cadastro');

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
        ShowMessage('Opah! que pena não consegui fazer o seu cadastro');
      end;
  end;


end;

function TDM.buscaCEP(cep: string): TStringList;
var
  obj, data: TJSONObject;
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  Endereco: TStringList;
begin
  RESTClient := TRESTClient.Create(nil);
  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);
  RESTRequest.Client := RESTClient;
  RESTRequest.Response := RESTResponse;
//  RESTClient1.BaseURL := 'https://ddd.pricez.com.br/cep/' + CEP + '.json';
  RESTClient.BaseURL := 'https://viacep.com.br/ws/'+cep+'/json/';
  RESTRequest.Execute;
  obj := RESTResponse.JSONValue as TJSONObject;
  try
    Endereco := TStringList.Create;
    if Assigned(obj) then
    begin
      //data := obj.Values['payload'] as TJSONObject;
      if obj.Count <> 0 then
      begin
        Endereco.Add(obj.Values['logradouro'].Value);
        Endereco.Add(obj.Values['bairro'].Value);
        Endereco.Add(obj.Values['uf'].Value);
        Endereco.Add(obj.Values['localidade'].Value);

      end;
      Result := Endereco;
    end;
  finally
    FreeAndNil(obj);
  end;

  //exemplo
  {
  "cep": "01001-000",
  "logradouro": "Praça da Sé",
  "complemento": "lado ímpar",
  "bairro": "Sé",
  "localidade": "São Paulo",
  "uf": "SP",
  "ibge": "3550308",
  "gia": "1004",
  "ddd": "11",
  "siafi": "7107"
}

end;

function TDm.enviaVenda(entrega,formaPagamento:integer;total:real): string;
var
  strResp,strREC:TStringStream;
  jso,jsoItem,jsonFinal,ResultsObj,JsonDetalhe:TJSONObject;
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
  jsoObj:TjsonObject;
begin
     arrayItens := TJSONArray.Create;
     strResp := TStringStream.Create;
     jsonFinal := TJSONObject.Create;



  try
      mpFormData:= TRESTRequestParameterList.Create(Self);

      jsoItem:= TJSONObject.Create;
      jsoItem.AddPair( TJSONPair.Create('data_pedido',FormatDateTime('yyyy-mm-dd',Date)));
      jsoItem.AddPair( TJSONPair.Create('cliente',sCPF));
      jsoItem.AddPair( TJSONPair.Create('empresa',sCnpj));
      jsoItem.AddPair( TJSONPair.Create('status','0'));
      jsoItem.AddPair( TJSONPair.Create('total',TJSONNumber.Create(total)));
      jsoItem.AddPair( TJSONPair.Create('entrega',TJSONNumber.Create(entrega)));
      jsoItem.AddPair( TJSONPair.Create('forma_pagamento',TJSONNumber.Create(formaPagamento)));


     if Entrega = 2 then
       begin
          jsoItem.AddPair( TJSONPair.Create('endereco',UpperCase(frmEntrega.edtEndereco.text)));
          jsoItem.AddPair( TJSONPair.Create('numero',frmEntrega.edtNumero.Text));
          jsoItem.AddPair( TJSONPair.Create('cep',frmEntrega.edtCep.Text));
          jsoItem.AddPair( TJSONPair.Create('bairro',UpperCase(frmEntrega.edtBairro.Text)));
          jsoItem.AddPair( TJSONPair.Create('cidade',UpperCase(frmEntrega.edtCidade.Text)));
          jsoItem.AddPair( TJSONPair.Create('nome_favorecido',UpperCase(frmEntrega.edtNome.Text)));
          jsoItem.AddPair( TJSONPair.Create('sobrenome_favorecida',''));
          jsoItem.AddPair( TJSONPair.Create('fone_favorecido',FrmEntrega.edtTelefone.Text));
          jsoItem.AddPair( TJSONPair.Create('obs',''));
           jsoItem.AddPair( TJSONPair.Create('presente','N'));

       end
      else
       begin


           dm.carregaCliente(jsoObj);

          jsoItem.AddPair( TJSONPair.Create('endereco',(jsoObj.GetValue('dados') as TJSONObject).GetValue('endereco').Value));
          jsoItem.AddPair( TJSONPair.Create('numero',(jsoObj.GetValue('dados') as TJSONObject).GetValue('numero').Value));
          jsoItem.AddPair( TJSONPair.Create('cep',(jsoObj.GetValue('dados') as TJSONObject).GetValue('cep').Value));
          jsoItem.AddPair( TJSONPair.Create('bairro',(jsoObj.GetValue('dados') as TJSONObject).GetValue('bairro').Value));
          jsoItem.AddPair( TJSONPair.Create('cidade',(jsoObj.GetValue('dados') as TJSONObject).GetValue('cidade').Value));
          jsoItem.AddPair( TJSONPair.Create('nome_favorecido',(jsoObj.GetValue('dados') as TJSONObject).GetValue('nome').Value));
          jsoItem.AddPair( TJSONPair.Create('sobrenome_favorecida',(jsoObj.GetValue('dados') as TJSONObject).GetValue('sobrenome').Value));
          jsoItem.AddPair( TJSONPair.Create('fone_favorecido', (jsoObj.GetValue('dados') as TJSONObject).GetValue('fone').Value));
          jsoItem.AddPair( TJSONPair.Create('obs',''));
         { if CheckBox1.IsChecked then
          jsoItem.AddPair( TJSONPair.Create('presente','S'))
          else}
          jsoItem.AddPair( TJSONPair.Create('presente','N'));

       end;


      frmPrincipal.cdsListaItens.First;
      while not frmPrincipal.cdsListaItens.Eof do
       begin
         JsonDetalhe := TJsonObject.Create;
         JsonDetalhe.AddPair('codigo',frmPrincipal.cdsListaItenscod_produto.AsString);
         case entrega of
          0:begin
             JsonDetalhe.AddPair('valor', TJSONNumber.Create(frmPrincipal.cdsListaItensvenda.AsFloat));
            end;
          1:begin
             JsonDetalhe.AddPair('valor', TJSONNumber.Create(frmPrincipal.cdsListaItensvalor.AsFloat));
            end;
          2:begin
             JsonDetalhe.AddPair('valor', TJSONNumber.Create(frmPrincipal.cdsListaItensvenda.AsFloat));
            end;
         end;
         JsonDetalhe.AddPair('qtd', TJSONNumber.Create(frmPrincipal.cdsListaItensqtd.AsFloat));
         JsonDetalhe.AddPair('descricao', frmPrincipal.cdsListaItensdescricao.AsString);
         JsonDetalhe.AddPair('data',FormatDateTime('yyyy-mm-dd',Date));
         arrayItens.AddElement(JsonDetalhe);

         frmPrincipal.cdsListaItens.Next;
       end;

      jsoItem.AddPair('itens',arrayItens);

      {strList := TStringList.Create();
      strList.Text := jsoItem.ToString;
      strList.SaveToFile('C:\TEMP\TEMJSON.TXT');

      Exit;}

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
        Value := buscaToken;
        Kind  := pkHTTPHEADER;
      end;


      retorno := SendData(fcPost, mpFormData, False,URI+'/pedidos');

    if(retorno.FCodigo = 200)then
     begin

        jso := nil;
        jso := TJSONObject.Create();
        jso.Parse(BytesOf(retorno.FRetorno),0);
        JsonValue   := jso.Get('result').JsonValue;
        jcValue     := jso.Get('id').JsonValue;
        Result :=  jcValue.Value;


        deleteItem('todos');
     end
    else
    begin

    end;

  except
    on E: Exception do
      begin
         ShowMessage(E.Message);
      end;
  end;

 if Assigned(strResp) then
  FreeAndNil(strResp);


 if Assigned(jso) then
  FreeAndNil(jso);



end;

procedure TDm.deleteItem(codProduto: string);
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
        Value :=  buscaToken;
        Kind  := pkHTTPHEADER;
      end;

      retorno := SendData2(fcRemove, mpFormData, False,URI+'/lista/'+codProduto);

      if(retorno.FCodigo = 200)then
        begin

        end
      else
        begin
          ShowMessage('Opa! Não consegui executar a função ');
        end;



  except
    on E: Exception do
      begin
        ShowMessage(E.Message);
      end;
  end;


end;

procedure TDm.GravaPerfil(cpf: string);
var
  Ini : TIniFile;
begin
  {$IFDEF ANDROID}
    try
      Ini := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath, 'Perfil.ini'));
      Ini.WriteString('PERFIL', 'CPF', cpf);
    finally
      Ini.DisposeOf;
    end;
   {$ENDIF}

   {$IFDEF MSWINDOWS}
    try
      Ini := TIniFile.Create('C:\temp\Perfil.ini');
      Ini.WriteString('PERFIL', 'CPF', cpf);
    finally
      Ini.DisposeOf;
    end;
   {$ENDIF}

   {$IFDEF IOS}
    try
      Ini := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath, 'Perfil.ini'));
      Ini.WriteString('PERFIL', 'CPF', cpf);
    finally
      Ini.DisposeOf;
    end;
   {$ENDIF}

end;

function TDm.LerPerfil: string;
var
  sIni:string;
  Ini : TIniFile;
  sCliente: string;
begin
  {$IFDEF ANDROID}
  try
    sIni := TPath.Combine(TPath.GetDocumentsPath, 'Perfil.ini');
    if not FileExists(sini) then
     begin
       Result := '0';
     end
    else
     begin
       Ini := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath, 'Perfil.ini'));
       Result := Ini.ReadString('PERFIL', 'CPF', sCliente);
     end;
  finally
    //Ini.Free;
  end;
  {$ENDIF}

  {$IFDEF MSWINDOWS}
  try
//    sIni := 'E:\producao\android\DescontoMobile\Com Venda\App Santana\Perfil.ini';
    sIni := 'C:\temp\Perfil.ini';
    if not FileExists(sini) then
     begin
       Result := '0';
     end
    else
     begin
     //  Ini := TIniFile.Create('E:\producao\android\DescontoMobile\Com Venda\App Santana\Perfil.ini');
       Ini := TIniFile.Create('C:\temp\Perfil.ini');
       Result := Ini.ReadString('PERFIL', 'CPF', sCliente);
     end;
  finally
    //Ini.Free;
  end;
  {$ENDIF}

   {$IFDEF IOS}
  try
    sIni := TPath.Combine(TPath.GetDocumentsPath, 'Perfil.ini');
    if not FileExists(sini) then
     begin
       Result := '0';
     end
    else
     begin
       Ini := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath, 'Perfil.ini'));
       Result := Ini.ReadString('PERFIL', 'CPF', sCliente);
     end;
  finally
    //Ini.Free;
  end;
  {$ENDIF}


end;

procedure TDm.buscaMsg(var jso:TJSONObject);
var
  mpFormData: TRESTRequestParameterList;
   retorno:TRetornoWS;
   jItens:TJSONArray;
   menssagem,tipo:string;

begin
  mpFormData:= TRESTRequestParameterList.Create(Self);

     with mpFormData.AddItem do
      begin
        ContentType:= ctAPPLICATION_JSON;
        Name  := 'x-access-token';
        Value := Token;
        Kind  := pkHTTPHEADER;
      end;

  try
    retorno := SendData(fcGet, mpFormData, False,URI+'/produto/msg');

    if(retorno.FCodigo = 200)then
     begin
        jso := TJSONObject.ParseJSONValue(retorno.FRetorno) as TJSONObject;
     end
    else

  except

  end;

end;


function TDm.buscaToken: string;
var
   mpFormData:TRESTRequestParameterList;
   jsoBody,jso:TJSONObject;
   JsonValue,jcValue:TJSONValue;
   retorno:TRetornoWS;

begin

  try
      mpFormData:= TRESTRequestParameterList.Create(Self);
      jsoBody:= TJSONObject.Create;
      jsoBody.AddPair( TJSONPair.Create('usuario', 'sri'));
      jsoBody.AddPair( TJSONPair.Create('senha', '740516'));
      jsoBody.AddPair( TJSONPair.Create('cnpj',sCnpj));
      jsoBody.AddPair( TJSONPair.Create('cpf',sCPF));

      with mpFormData.AddItem do
      begin
        ContentType:= ctAPPLICATION_JSON;
        Value:= jsoBody.ToJSON;
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

 {if Assigned(jsonstrResp) then
  FreeAndNil(strResp);}


 if Assigned(jso) then
  FreeAndNil(jso);


end;

procedure TDm.carregaCliente(var jso:TJSONObject );
var arrayItens:TJSONArray;
    mpFormData: TRESTRequestParameterList;
    retorno:TRetornoWS;

begin
   arrayItens := TJSONArray.Create;

   mpFormData:= TRESTRequestParameterList.Create(Self);


   with mpFormData.AddItem do
    begin
      ContentType:= ctAPPLICATION_JSON;
      Name  := 'x-access-token';
      Value := buscaToken;
      Kind  := pkHTTPHEADER;
    end;

   retorno := SendData(fcGet, mpFormData, False,URI+'/cadastro');

  if(retorno.FCodigo = 200)then
   begin

     jso := TJSONObject.ParseJSONValue(retorno.FRetorno) as TJSONObject;

   end;

end;

function TDm.buscaValor():Real;
var arrayItens:TJSONArray;
    mpFormData: TRESTRequestParameterList;
    retorno:TRetornoWS;
    jso:TjsonObject;
    jsoDados:TJSONObject;
    sVlr:string;
    rVlr:real;
    iPos:integer;

begin
   arrayItens := TJSONArray.Create;

   mpFormData:= TRESTRequestParameterList.Create(Self);


   with mpFormData.AddItem do
    begin
      ContentType:= ctAPPLICATION_JSON;
      Name  := 'x-access-token';
      Value := buscaToken;
      Kind  := pkHTTPHEADER;
    end;

   retorno := SendData(fcGet, mpFormData, False,URI+'/lista/valorcarrinho');

  if(retorno.FCodigo = 200)then
   begin

     jso := TJSONObject.ParseJSONValue(retorno.FRetorno) as TJSONObject;
     jsoDados:= jso.GetValue('dados') as TJSONObject;
     sVlr    := jsoDados.GetValue<String>('total');
     if sVlr <> '' then
      begin
        iPos    := pos('.',svlr);
        svlr    := copy(svlr,1,ipos+2);
        svlr    := StringReplace(sVlr,'.',',',[]);
        rvlr    := strtofloat(copy(svlr,1,ipos+2));
        Result  := rvlr;
      end
     else
      begin
        Result  := 0;
      end;
   end;

end;

procedure TDm.BuscaItem(codigo:string;var jso:TJSONObject );
var arrayItens:TJSONArray;

    mpFormData: TRESTRequestParameterList;
    retorno:TRetornoWS;

begin
   arrayItens := TJSONArray.Create;

   mpFormData:= TRESTRequestParameterList.Create(Self);


   with mpFormData.AddItem do
    begin
      ContentType:= ctAPPLICATION_JSON;
      Name  := 'x-access-token';
      Value := buscaToken;
      Kind  := pkHTTPHEADER;
    end;

   retorno := SendData(fcGet, mpFormData, False,URI+'/produto/'+codigo);

  if(retorno.FCodigo = 200)then
   begin



     jso := TJSONObject.ParseJSONValue(retorno.FRetorno) as TJSONObject;



   end;

end;
procedure TDm.VerificarCep(cep :string;var jso:TJSONObject);
var arrayItens:TJSONArray;
    i :Integer;
    mpFormData: TRESTRequestParameterList;
    retorno:TRetornoWS;
    jsonArray:TJSONArray;

begin

 sFrete:= '';
   arrayItens := TJSONArray.Create;

   mpFormData:= TRESTRequestParameterList.Create(Self);


   with mpFormData.AddItem do
    begin
      ContentType:= ctAPPLICATION_JSON;
      Name  := 'x-access-token';
      Value := buscaToken;
      Kind  := pkHTTPHEADER;




   retorno := SendData(fcGet, mpFormData, False,URI+'/frete/'+cep);

   //nPaginas := nPagina + 1;

 if(retorno.FCodigo = 200)then
   begin

     jso := TJSONObject.ParseJSONValue(retorno.FRetorno) as TJSONObject;
     jsonArray:= jso.GetValue('dados') as TJSONArray;

// sFrete := (ResultsObj.GetValue('dados') as TJSONObject).GetValue('Frete').Value;

            for I := 0 to jsonArray.Size -1 do
                begin
                     sFrete:= jsonArray.get(i).GetValue<String>('frete');
                     scod :=  jsonArray.get(i).GetValue<String>('cod_produto');
                     rValorMin :=  jsonArray.get(i).GetValue<Real>('valor_min');
                end;

         sFrete := sFrete;
         sCod := sCod;
         rValorMin := rValorMin;

   end;



   end;



end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  sCpf := LerPerfil;

end;

function TDm.SendData(const ACommand: TCommand;
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

function TDm.SendData2(const ACommand: TCommand;
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

procedure Tdm.MeuCarrinho(var jso: TJSONObject);
var arrayItens:TJSONArray;
    mpFormData: TRESTRequestParameterList;
    retorno:TRetornoWS;
begin
   arrayItens := TJSONArray.Create;

   mpFormData:= TRESTRequestParameterList.Create(Self);


   with mpFormData.AddItem do
    begin
      ContentType:= ctAPPLICATION_JSON;
      Name  := 'x-access-token';
      Value := buscaToken;
      Kind  := pkHTTPHEADER;
    end;

   retorno := SendData2(fcGet, mpFormData, False,URI+'/lista');

  if(retorno.FCodigo = 200)then
   begin

     jso := TJSONObject.ParseJSONValue(retorno.FRetorno) as TJSONObject;

   end;



end;

procedure Tdm.BuscaImagem(produto:String;var jso: TJSONObject);
var arrayItens:TJSONArray;
    mpFormData: TRESTRequestParameterList;
    retorno:TRetornoWS;
begin
   arrayItens := TJSONArray.Create;

   mpFormData:= TRESTRequestParameterList.Create(Self);


   with mpFormData.AddItem do
    begin
      ContentType:= ctAPPLICATION_JSON;
      Name  := 'x-access-token';
        Value := buscaToken;
      Kind  := pkHTTPHEADER;
    end;

   retorno := SendData(fcGet, mpFormData, False,URI+'/produto/imagem/'+produto);

  if(retorno.FCodigo = 200)then
   begin

     jso := TJSONObject.ParseJSONValue(retorno.FRetorno) as TJSONObject;

   end;

   if Assigned(mpFormData) then
   FreeAndNil(mpFormData);

end;

procedure Tdm.buscaSlides(var jso: TJSONObject);
var arrayItens:TJSONArray;
    mpFormData: TRESTRequestParameterList;
    retorno:TRetornoWS;
    s:string;
begin
   arrayItens := TJSONArray.Create;

   mpFormData:= TRESTRequestParameterList.Create(Self);


   with mpFormData.AddItem do
    begin
      ContentType:= ctAPPLICATION_JSON;
      Name  := 'x-access-token';
      Value := Token;
      Kind  := pkHTTPHEADER;
    end;

   retorno := SendData(fcGet, mpFormData, False,URI+'/slide');

  if(retorno.FCodigo = 200)then
   begin
     s := retorno.FRetorno;
     jso := TJSONObject.ParseJSONValue(retorno.FRetorno) as TJSONObject;

   end;

   if Assigned(mpFormData) then
   FreeAndNil(mpFormData);

end;

procedure Tdm.buscaBanners(var jso: TJSONObject);
var arrayItens:TJSONArray;
    mpFormData: TRESTRequestParameterList;
    retorno:TRetornoWS;
    s:string;
begin
   arrayItens := TJSONArray.Create;

   mpFormData:= TRESTRequestParameterList.Create(Self);


   with mpFormData.AddItem do
    begin
      ContentType:= ctAPPLICATION_JSON;
      Name  := 'x-access-token';
      Value := Token;
      Kind  := pkHTTPHEADER;
    end;

   retorno := SendData(fcGet, mpFormData, False,URI+'/banners');

  if(retorno.FCodigo = 200)then
   begin
     s := retorno.FRetorno;
     jso := TJSONObject.ParseJSONValue(retorno.FRetorno) as TJSONObject;

   end;

   if Assigned(mpFormData) then
   FreeAndNil(mpFormData);

end;

procedure Tdm.buscaItens(nPagina:integer;grupo,descricao:String; var jso: TJSONObject);
var arrayItens:TJSONArray;
    mpFormData: TRESTRequestParameterList;
    retorno:TRetornoWS;
    sGrupo,sDescricao,sSeparador,sPara:string;
begin



   arrayItens := TJSONArray.Create;

   mpFormData:= TRESTRequestParameterList.Create(Self);

   with mpFormData.AddItem do
    begin
      ContentType:= ctAPPLICATION_JSON;
      Name  := 'x-access-token';
      Value := Token;
      Kind  := pkHTTPHEADER;
    end;

   if Length(grupo)>0 then
     sGrupo := 'grupo='+grupo
   else
     sGrupo := '';

   if Length(descricao) > 0 then
     sDescricao := 'descricao='+Descricao

   else
    sDescricao := '';

   if ((Length(grupo)>0) and (Length(descricao)>0)) then
       sSeparador := '&'
   else
       sSeparador := '';

   if ((Length(grupo)>0) OR (Length(descricao)>0)) then
       sPara := '?'
   else
       spara := '';



   retorno := SendData(fcGet, mpFormData, False,URI+'/produto/pagina/'+inttoStr(nPagina)+spara+sGrupo+sseparador+sDescricao);

   nPaginas := nPagina + 1;

  if(retorno.FCodigo = 200)then
   begin

     jso := TJSONObject.ParseJSONValue(retorno.FRetorno) as TJSONObject;

     frmPrincipal.lvItens.Tag := 0;
   end;

   if Assigned(mpFormData) then
   FreeAndNil(mpFormData);

end;

function Tdm.paginas: Integer;
var
  strResp,strREC:TStringStream;
  jso,jsoItem,jsonFinal,ResultsObj:TJSONObject;
  ResultsArray:TJSONArray;
  sJson:String;
  irespota,x:Integer;
  arrayItens:TJSONArray;
  resultsObjP:TJSONPair;
  jsop:TJSONPair;
  str,sRetorno:string;
  retorno:TRetornoWS;
  mpFormData: TRESTRequestParameterList;
  sRespota:string;
  jsoValue:TJSONValue;

begin


    mpFormData:= TRESTRequestParameterList.Create(Self);

     with mpFormData.AddItem do
      begin
        ContentType:= ctAPPLICATION_JSON;
        Name  := 'x-access-token';
        Value := buscaToken;
        Kind  := pkHTTPHEADER;
      end;

       retorno := SendData(fcGet, mpFormData, False,URI+'/produto/paginas');

    if(retorno.FCodigo = 200)then
     begin
        jso := nil;
        jso := TJsonObject.Create;
        jso.Parse(BytesOf(retorno.FRetorno), 0);
        jsoValue:= jso.Get('result').JSonValue;


        if ('true'.Equals(jsoValue.value)) then
         begin

          Result := StrToInt((jso.GetValue('dados') as TJSONObject).GetValue('qtd').Value);

         end;

     end;


 if Assigned(mpFormData) then
   FreeAndNil(mpFormData);



end;

{ TRetornoWS }

procedure TRetornoWS.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TRetornoWS.SetRetorno(const Value: string);
begin
  FRetorno := Value;
end;

function Tdm.VerificaInternet():Boolean;
var http:THTTPClient;
begin
  Result := False;

  try

   http := THTTPClient.Create;
    try
      Result := http.Head('https://google.com').StatusCode < 400
    except
    end;

  finally
    http.DisposeOf;
  end;





end;



end.
