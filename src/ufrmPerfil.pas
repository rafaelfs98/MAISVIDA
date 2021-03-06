unit ufrmPerfil;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, uFancyDialog,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, FMX.Layouts, FMX.Edit,
  System.Permissions,FMX.DialogService, u99Permissions;

type
  TfrmPerfil = class(TForm)
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Label1: TLabel;
    Image1: TImage;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    VertScrollBox1: TVertScrollBox;
    Layout1: TLayout;
    Line1: TLine;
    Label2: TLabel;
    lbNome: TLabel;
    Layout2: TLayout;
    Line2: TLine;
    Label4: TLabel;
    lbFone: TLabel;
    Layout3: TLayout;
    Line3: TLine;
    Label6: TLabel;
    lbCidade: TLabel;
    Layout4: TLayout;
    Line4: TLine;
    Label8: TLabel;
    lbBairro: TLabel;
    Layout5: TLayout;
    Line5: TLine;
    Label10: TLabel;
    lbNumero: TLabel;
    Layout6: TLayout;
    Line6: TLine;
    Label12: TLabel;
    lbEndereco: TLabel;
    Layout7: TLayout;
    Line7: TLine;
    Label14: TLabel;
    lbCEP: TLabel;
    Layout8: TLayout;
    Line8: TLine;
    Label16: TLabel;
    lbEmail: TLabel;
    Layout9: TLayout;
    Line9: TLine;
    Label18: TLabel;
    lbCpf: TLabel;
    Layout10: TLayout;
    Line10: TLine;
    Label20: TLabel;
    lbSobrenome: TLabel;
    TabItem5: TTabItem;
    TabItem6: TTabItem;
    TabItem7: TTabItem;
    TabItem8: TTabItem;
    Layout11: TLayout;
    edtNome: TEdit;
    Layout13: TLayout;
    Image2: TImage;
    Layout14: TLayout;
    edtCPF: TEdit;
    Layout16: TLayout;
    Image3: TImage;
    Layout17: TLayout;
    edtCEP: TEdit;
    Layout19: TLayout;
    Image4: TImage;
    Layout20: TLayout;
    edtNumero: TEdit;
    Layout22: TLayout;
    Image5: TImage;
    Layout23: TLayout;
    edtCidade: TEdit;
    Layout25: TLayout;
    Layout26: TLayout;
    Edit9: TEdit;
    Layout27: TLayout;
    Edit10: TEdit;
    Layout28: TLayout;
    Image7: TImage;
    SpeedButton1: TSpeedButton;
    btnSalvar: TRectangle;
    Label3: TLabel;
    edtSobrenome: TEdit;
    edtEmail: TEdit;
    edtEndereco: TEdit;
    edtBairro: TEdit;
    edtTelefone: TEdit;
    Image6: TImage;
    Label5: TLabel;
    Rectangle3: TRectangle;
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure edtSobrenomeExit(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
    procedure Rectangle3Click(Sender: TObject);
       procedure verificarCep;
    procedure Image4Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);

  private
    procedure fecharTela(Sender: Tobject);


    { Private declarations }
  public
    permissao:T99permissions;
    diag:TFancyDialog;


    { Public declarations }
  end;

var
  frmPerfil: TfrmPerfil;

implementation

uses
  uStyle, uDm, System.JSON, ufrmPrincipal, ufrmMaps,uFrmEntrega;

{$R *.fmx}

procedure TfrmPerfil.btnSalvarClick(Sender: TObject);
var tempToken:string;


begin

  Dm.GravaPerfil(edtCPF.Text);
  dm.sCpf := edtCPF.Text;




  if dm.cadastrarCliente(edtCPF.Text
                        ,edtNome.Text
                        ,edtEmail.Text
                        ,edtEndereco.Text
                        ,edtTelefone.Text
                        ,edtSobrenome.Text
                        ,dm.sCnpj
                        ,edtCEP.Text
                        ,edtNumero.Text
                        ,edtBairro.Text
                        ,edtCidade.Text) = 'true' then
     begin
      diag.Show(TIconDialog.Success,'Parab?ns','Tudo certo voc? pode usar agora','Ok',fecharTela);
      tempToken := dm.buscaToken;
     end
  else
        begin
      diag.show(TIconDialog.Error,'Opa !','N?o consegui fazer seu cadastro','Ok',fecharTela);
      tempToken := dm.buscaToken;
     end;


end;

procedure TfrmPerfil.edtCEPExit(Sender: TObject);
var sEndereco: TStringList;

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


  

end;



procedure TfrmPerfil.edtSobrenomeExit(Sender: TObject);
begin
 // Image2Click(sender);
end;
procedure Tfrmperfil.fecharTela(Sender:Tobject);
begin
   close;
end;

procedure TfrmPerfil.FormCreate(Sender: TObject);
begin
  diag := TFancyDialog.Create(self);
  permissao:=T99permissions.Create;
end;

procedure TfrmPerfil.FormShow(Sender: TObject);
var jsoObj:Tjsonobject;
begin


  TabControl1.TabPosition := TTabPosition.None;
  TabControl1.ActiveTab := TabItem1;
  Rectangle2.Fill.Color := PRIMARY;
  btnSalvar.Fill.Color  := BTN;
   if dm.sCadastrado = 'true' then
    begin
        TThread.CreateAnonymousThread(Procedure
        begin

           dm.carregaCliente(jsoObj);

          tthread.Synchronize(nil,procedure
          begin
                  // lbNomeUsuario.Text := (jso.GetValue('dados') as TJSONObject).GetValue('nome').Value;
            edtNome.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('nome').Value;
            edtSobrenome.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('sobrenome').Value;
            edtCPF.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('cpf').Value;
            edtEmail.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('email').Value;
            edtNumero.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('numero').Value;
            edtTelefone.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('fone').Value;
            edtEndereco.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('endereco').Value;
            edtCEP.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('cep').Value;
            edtBairro.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('bairro').Value;
            edtCidade.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('cidade').Value;

            lbnome.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('nome').Value;
            lbSobrenome.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('sobrenome').Value;
            lbCPF.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('cpf').Value;
            lbEmail.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('email').Value;
            lbNumero.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('numero').Value;
            lbfone.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('fone').Value;
            lbEndereco.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('endereco').Value;
            lbCEP.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('cep').Value;
            lbBairro.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('bairro').Value;
           lbCidade.Text := (jsoObj.GetValue('dados') as TJSONObject).GetValue('cidade').Value;


          end);


        end).Start;
    end
   else
    begin
     TabControl1.ActiveTab := TabItem2;
    end;



end;

 procedure TfrmPerfil.Rectangle3Click(Sender: TObject);
begin
  {$IFDEF ANDROID}
   if not Assigned(frmMaps) then
    Application.CreateForm(TfrmMaps,frmMaps);

    frmMaps.Show;
  {$ENDIF}

end;

procedure TfrmPerfil.Image1Click(Sender: TObject);
begin
  Close;
end;

procedure TfrmPerfil.Image2Click(Sender: TObject);
var i:Integer;
ResultsObj:TJSONObject;
begin
  i := TabControl1.ActiveTab.Index+1;
  //TabControl1.GotoVisibleTab(i,TTabTransition.Slide,TTabTransitionDirection.Normal);
  TabControl1.ActiveTab := TabItem3;

end;

procedure TfrmPerfil.Image3Click(Sender: TObject);
begin
TabControl1.ActiveTab := TabItem4;
end;

procedure TfrmPerfil.Image4Click(Sender: TObject);
var i:Integer;
ResultsObj:TJSONObject;

begin

  dm.verificarCep(edtcep.Text,ResultsObj);

           if dm.sFrete = '' then
        BEGIN

          diag.show(TIconDialog.Info,'Que Pena !','Ainda n?o entregamos em sua regi?o','Ok');

        end;


  {i := TabControl1.ActiveTab.Index+1;
  TabControl1.GotoVisibleTab(i,TTabTransition.Slide,TTabTransitionDirection.Normal);}
  TabControl1.ActiveTab := TabItem5;

end;


procedure TfrmPerfil.Image5Click(Sender: TObject);
begin
  TabControl1.ActiveTab := TabItem6;
end;

procedure TfrmPerfil.SpeedButton1Click(Sender: TObject);
begin
//  TabControl1.GotoVisibleTab(1,TTabTransition.Slide,TTabTransitionDirection.Normal);
TabControl1.ActiveTab := TabItem2;
end;
procedure TfrmPerfil.verificarCep;
var
 ResultsObj:TJSONObject;
 jsonArray:TJSONArray;


 i:integer;
begin
ResultsObj := TJSONObject.Create;
jsonArray:= nil;

dm.verificarCep(edtcep.Text,ResultsObj);
jsonArray:= ResultsObj.GetValue('dados') as TJSONArray;

// sFrete := (ResultsObj.GetValue('dados') as TJSONObject).GetValue('Frete').Value;






end;

end.
