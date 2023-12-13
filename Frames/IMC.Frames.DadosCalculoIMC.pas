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
    procedure rgpSexoExit(Sender: TObject);
  private
    { Private declarations }
    procedure Notificar;
    procedure Calcular;
    procedure SalvarHistorico;
    procedure CalcularIMC;
    procedure LimparDados;
    procedure Limpar;
    procedure TratarExcessoes(pE: Exception);
  public
    { Public declarations }
  end;

implementation

uses
  IMC.Helpers.Funcoes, IMC.Helpers.Enumerados, IMC.Forms.Principal, IMC.Frames.ResultadoIMC;

{$R *.dfm}

{ TfrmDadosCalculoIMC }

procedure TfrmDadosCalculoIMC.btnHistoricoClick(Sender: TObject);
var
  lPacientes: TPacientesSingleton;
begin
  lPacientes := TPacientesSingleton.ObterInstancia;

  if not Assigned(frmHistorico) then
  begin
    frmHistorico := TfrmHistorico.Create(Self);
  end;

  try
    frmHistorico.ShowModal;

    if frmHistorico.ModalResult = mrCancel then
    begin
      Exit;
    end;

    edtNome.Text := lPacientes.Atual.Nome;
    edtNascimento.Text := lPacientes.Atual.Nascimento;
    edtPeso.Text := lPacientes.Atual.Peso;
    edtAltura.Text := lPacientes.Atual.Altura;
    edtIMC.Text := lPacientes.Atual.MediaIMC.ToString;
    rgpSexo.ItemIndex := Ord(lPacientes.Atual.Sexo);
    Calcular;
  finally
    FreeAndNil(frmHistorico);
  end;
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
var
  lPacientes: TPacientesSingleton;
begin
  lPacientes := TPacientesSingleton.ObterInstancia;
  lPacientes.Atual.VerificarIMC(lPacientes.Atual.Sexo);

  edtIMC.Text := FormatFloat('#,##0.00', lPacientes.Atual.MediaIMC);
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
var
  lPacientes: TPacientesSingleton;
begin
  lPacientes := TPacientesSingleton.ObterInstancia;

  try
    lPacientes.Atual.Altura := edtAltura.Text;
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
var
  lPacientes: TPacientesSingleton;
begin
  lPacientes := TPacientesSingleton.ObterInstancia;

  try
    lPacientes.Atual.Nascimento := THelpers.FormatarData(edtNascimento.Text);
    lblAnoMesesSemanasDias.Caption := lPacientes.Atual.Idade;
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
var
  lPacientes: TPacientesSingleton;
begin
  lPacientes := TPacientesSingleton.ObterInstancia;
  lPacientes.Atual.Nome := THelpers.DigitarLetras(edtNome.Text);
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
var
  lPacientes: TPacientesSingleton;
begin
  lPacientes := TPacientesSingleton.ObterInstancia;

  try
    lPacientes.Atual.Peso := edtPeso.Text;
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
  Notificar;
end;

procedure TfrmDadosCalculoIMC.LimparDados;
var
  lPacientes: TPacientesSingleton;
begin
  lPacientes := TPacientesSingleton.ObterInstancia;

  lPacientes.Atual.Limpar;
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
  lPacientes: TPacientesSingleton;
begin
  lPacientes := TPacientesSingleton.ObterInstancia;

  for lObserver in lPacientes.Observers do
  begin
    lObserver.Atualizar(lPacientes.Atual.StatusIMC);
  end;
end;

procedure TfrmDadosCalculoIMC.rgpSexoClick(Sender: TObject);
var
  lPacientes: TPacientesSingleton;
begin
  lPacientes := TPacientesSingleton.ObterInstancia;
  lPacientes.Atual.Sexo := TSexoPaciente(rgpSexo.ItemIndex);
end;

procedure TfrmDadosCalculoIMC.rgpSexoExit(Sender: TObject);
var
  lPacientes: TPacientesSingleton;
begin
  lPacientes := TPacientesSingleton.ObterInstancia;
  lPacientes.Atual.Sexo := TSexoPaciente(rgpSexo.ItemIndex);
end;

procedure TfrmDadosCalculoIMC.SalvarHistorico;
var
  lPacientes: TPacientesSingleton;
  lDataHora: string;
begin
  lDataHora := FormatDateTime('dd/mm/yyyy hh:mm:ss', Now);

  lPacientes := TPacientesSingleton.ObterInstancia;
  lPacientes.Historico.Adicionar(lDataHora, lPacientes.Salvar);
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
