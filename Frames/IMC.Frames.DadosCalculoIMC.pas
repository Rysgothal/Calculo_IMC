unit IMC.Frames.DadosCalculoIMC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  IMC.Interfaces.Subject, System.Classes, IMC.Interfaces.Observer,
  System.Generics.Collections, IMC.Classes.Paciente, Vcl.ExtCtrls,
  IMC.Forms.Historico, IMC.Helpers.Exceptions;

type
  TfrmDadosCalculoIMC = class(TFrame, ISubject)
    gbxDadosPaciente: TGroupBox;
    lblNome: TLabel;
    lblNascimento: TLabel;
    lblIdadeCompleta: TLabel;
    lblAnoMesesSemanasDias: TLabel;
    sbtnLimpar: TSpeedButton;
    lblIMC: TLabel;
    lblSeta: TLabel;
    btnHistorico: TSpeedButton;
    rgpSexo: TRadioGroup;
    edtNome: TEdit;
    edtNascimento: TEdit;
    edtIMC: TEdit;
    gbxDadosCalculo: TGroupBox;
    lblPeso: TLabel;
    lblAltura: TLabel;
    sbtnCalcular: TSpeedButton;
    edtPeso: TEdit;
    edtAltura: TEdit;
    procedure edtPesoChange(Sender: TObject);
    procedure edtPesoExit(Sender: TObject);
    procedure edtAlturaChange(Sender: TObject);
    procedure edtAlturaExit(Sender: TObject);
    procedure sbtnCalcularClick(Sender: TObject);
    procedure btnHistoricoClick(Sender: TObject);
    procedure sbtnLimparClick(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure edtNascimentoExit(Sender: TObject);
    procedure edtNascimentoChange(Sender: TObject);
    procedure edtNomeExit(Sender: TObject);
    procedure rgpSexoClick(Sender: TObject);
  private
    { Private declarations }
    FPacientes: TPacientes;

    procedure Notificar;
    procedure Calcular;
    procedure SalvarHistorico;
    procedure CalcularIMC;
    procedure LimparDados;
    procedure Limpar;
    procedure TratarExcessoes(pE: Exception);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AdicionarObserver(pObserver: IObserver);
    procedure RemoverObserver(pObserver: IObserver);
  end;

implementation

uses
  IMC.Helpers.Funcoes, IMC.Helpers.Enumerados, IMC.Forms.Principal, IMC.Frames.ResultadoIMC;

{$R *.dfm}

{ TfrmDadosCalculoIMC }

procedure TfrmDadosCalculoIMC.AdicionarObserver(pObserver: IObserver);
begin
  FPacientes.AdicionarObserver(pObserver);
end;

procedure TfrmDadosCalculoIMC.btnHistoricoClick(Sender: TObject);
begin
  if not Assigned(frmHistorico) then
  begin
    frmHistorico := TfrmHistorico.Create(FPacientes);

    try
      frmHistorico.ShowModal;
    finally
      FreeAndNil(frmHistorico);
    end;
  end;

  edtNome.Text := FPacientes.Atual.Nome;
  edtNascimento.Text := FPacientes.Atual.Nascimento;
  edtPeso.Text := FPacientes.Atual.Peso;
  edtAltura.Text := FPacientes.Atual.Altura;
  edtIMC.Text := FPacientes.Atual.MediaIMC.ToString;
  rgpSexo.ItemIndex := Ord(FPacientes.Atual.Sexo);
  Calcular;
end;

procedure TfrmDadosCalculoIMC.Calcular;
begin
  try
    if THelpers.VerificarCampoVazio(edtNome) then
    begin
      Application.MessageBox('O nome não foi preenchido, verifique', 'Atenção', MB_OK + MB_ICONINFORMATION);
      THelpers.Focar(edtNome);
      Exit;
    end;

    if THelpers.VerificarCampoVazio(edtNascimento) then
    begin
      Application.MessageBox('A data de nascimento não foi preenchida, verifique', 'Atenção', MB_OK + MB_ICONINFORMATION);
      THelpers.Focar(edtNascimento);
      Exit;
    end;

    CalcularIMC;
    btnHistorico.Enabled := True;
    sbtnLimpar.Enabled := True;
    Notificar;
  except
    on E: Exception do
    begin
      TratarExcessoes(E);
    end;
  end;
end;

procedure TfrmDadosCalculoIMC.CalcularIMC;
begin
  FPacientes.Atual.VerificarIMC(FPacientes.Atual.Sexo);
  edtIMC.Text := FormatFloat('#,##0.00', FPacientes.Atual.MediaIMC);
end;

constructor TfrmDadosCalculoIMC.Create(AOwner: TComponent);
begin
  inherited;
  FPacientes := TPacientes.Create;
end;

destructor TfrmDadosCalculoIMC.Destroy;
begin
  FreeAndNil(FPacientes);
  inherited;
end;

procedure TfrmDadosCalculoIMC.edtAlturaChange(Sender: TObject);
begin
  if THelpers.VerificarCampoVazio(edtAltura) then
  begin
    Exit;
  end;

  edtAltura.Text := THelpers.FormatarCurr(THelpers.DigitarNumeros(edtAltura.Text));
  THelpers.MoverFinal(edtAltura);
end;

procedure TfrmDadosCalculoIMC.edtAlturaExit(Sender: TObject);
begin
  try
    FPacientes.Atual.Altura := edtAltura.Text;
  except
    on E: Exception do
    begin
      TratarExcessoes(E);
    end;
  end;
end;

procedure TfrmDadosCalculoIMC.edtNascimentoChange(Sender: TObject);
begin
  THelpers.FormatarData(edtNascimento);
end;

procedure TfrmDadosCalculoIMC.edtNascimentoExit(Sender: TObject);
begin
  try
    FPacientes.Atual.Nascimento := THelpers.FormatarData(edtNascimento.Text);
    lblAnoMesesSemanasDias.Caption := FPacientes.Atual.Idade;
  except
    on E: Exception do
    begin
      TratarExcessoes(E);
    end;
  end;
end;

procedure TfrmDadosCalculoIMC.edtNomeChange(Sender: TObject);
begin
  edtNome.Text := THelpers.DigitarLetras(edtNome.Text);
end;

procedure TfrmDadosCalculoIMC.edtNomeExit(Sender: TObject);
begin
  FPacientes.Atual.Nome := THelpers.DigitarLetras(edtNome.Text);
end;

procedure TfrmDadosCalculoIMC.edtPesoChange(Sender: TObject);
begin
  if THelpers.VerificarCampoVazio(edtPeso) then
  begin
    Exit;
  end;

  edtPeso.Text := THelpers.FormatarCurr(THelpers.DigitarNumeros(edtPeso.Text));
  THelpers.MoverFinal(edtPeso);
end;

procedure TfrmDadosCalculoIMC.edtPesoExit(Sender: TObject);
begin
  try
    FPacientes.Atual.Peso := edtPeso.Text;
  except
    on E: Exception do
    begin
      TratarExcessoes(E);
    end;
  end;
end;

procedure TfrmDadosCalculoIMC.Limpar;
begin
  LimparDados;
  sbtnLimpar.Enabled := False;
  Notificar; // Ver isso aqui
end;

procedure TfrmDadosCalculoIMC.LimparDados;
begin
  FPacientes.Atual.Limpar;
  edtNome.Clear;
  edtNascimento.Clear;
  edtPeso.Clear;
  edtAltura.Clear;
  edtIMC.Text := '0,0';
  sbtnLimpar.Enabled := False;
  rgpSexo.ItemIndex := - 1;
end;

procedure TfrmDadosCalculoIMC.Notificar;
var
  lObserver: IObserver;
begin
  for lObserver in FPacientes.Observers do
  begin
    lObserver.Atualizar(FPacientes.Atual.StatusIMC);
  end;
end;

procedure TfrmDadosCalculoIMC.RemoverObserver(pObserver: IObserver);
begin
  FPacientes.RemoverObserver(pObserver);
end;

procedure TfrmDadosCalculoIMC.rgpSexoClick(Sender: TObject);
begin
  FPacientes.Atual.Sexo := TSexoPaciente(rgpSexo.ItemIndex);
end;

procedure TfrmDadosCalculoIMC.SalvarHistorico;
var
  lDataHoraAtual: string;
begin
  lDataHoraAtual := FormatDateTime('dd/mm/yyyy hh:nn:ss:zzz', Now);
  FPacientes.Historico.Adicionar(lDataHoraAtual, FPacientes.Salvar);
end;

procedure TfrmDadosCalculoIMC.sbtnCalcularClick(Sender: TObject);
begin
  Calcular;
  SalvarHistorico;
end;

procedure TfrmDadosCalculoIMC.sbtnLimparClick(Sender: TObject);
begin
  Limpar;
end;

procedure TfrmDadosCalculoIMC.TratarExcessoes(pE: Exception);
begin
  Application.MessageBox(PChar('Houve uma inconsistencia, verifique:' + sLineBreak + pE.Message), 'Atenção', MB_OK +
    MB_ICONINFORMATION);

  if (pE.ClassType = EPesoNaoInformado) or (pE.ClassType = EPesoIncorreto) then
  begin
    THelpers.Focar(edtPeso);
  end else
  if (pE.ClassType = EAlturaNaoInformada) or (pE.ClassType = EAlturaIncorreta) then
  begin
    THelpers.Focar(edtAltura);
  end else
  if (pE.ClassType = ENascimentoNaoInformado) then
  begin
    THelpers.Focar(edtNascimento);
  end else
  if (pE.ClassType = ESexoNaoInformado) then
  begin
    rgpSexo.SetFocus
  end;
end;

end.
