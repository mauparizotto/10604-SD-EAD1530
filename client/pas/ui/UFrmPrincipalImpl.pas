unit UFrmPrincipalImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    edtDocumentoCliente: TLabeledEdit;
    cmbTamanhoPizza: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cmbSaborPizza: TComboBox;
    Button1: TButton;
    mmRetornoWebService: TMemo;
    Label3: TLabel;
    edtEnderecoBackend: TLabeledEdit;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  WSDLPizzariaBackendControllerImpl, Rtti, REST.JSON, UPizzaTamanhoEnum,
  UPizzaSaborEnum;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  if edtDocumentoCliente.Text = '' then
  begin
    ShowMessage('Campo "Documento" deve ser preenchido!');
    edtDocumentoCliente.SetFocus;
    Exit;
  end;

  if cmbTamanhoPizza.Text = '' then
  begin
    ShowMessage('Campo "Tamanho da Pizza" deve ser preenchido!');
    cmbTamanhoPizza.SetFocus;
    Exit;
  end;

  if cmbSaborPizza.Text = '' then
  begin
    ShowMessage('Campo "Sabor da Pizza" deve ser preenchido!');
    cmbSaborPizza.SetFocus;
    Exit;
  end;


  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text := TJson.ObjectToJsonString(oPizzariaBackendController.efetuarPedido(TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text), TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text), edtDocumentoCliente.Text));

  cmbSaborPizza.ItemIndex   := -1;
  cmbTamanhoPizza.ItemIndex := -1;
  edtDocumentoCliente.Text  := '';
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  if edtDocumentoCliente.Text = '' then
  begin
    ShowMessage('Campo "Documento" deve ser preenchido!');
    edtDocumentoCliente.SetFocus;
    Exit;
  end;

  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text := TJson.ObjectToJsonString(oPizzariaBackendController.ConsultaPedido(edtDocumentoCliente.Text));

  cmbSaborPizza.ItemIndex   := -1;
  cmbTamanhoPizza.ItemIndex := -1;
  edtDocumentoCliente.Text  := '';

end;

end.
