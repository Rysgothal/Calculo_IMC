unit IMC.Forms.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, System.DateUtils, IMC.Classes.Paciente, IMC.Helpers.Exceptions,
  IMC.Helpers.Enumerados;

type
  TfrmPrincipal = class(TForm)
    sttsbarInformacao: TStatusBar;
    gbxDadosPaciente: TGroupBox;
    lblNome: TLabel;
    lblNascimento: TLabel;
    lblIdadeCompleta: TLabel;
    lblAnoMesesSemanasDias: TLabel;
    sbtnLimpar: TSpeedButton;
    lblIMC: TLabel;
    lblSeta: TLabel;
    rgpSexo: TRadioGroup;
    edtNome: TEdit;
    edtNascimento: TEdit;
    gbxDadosCalculo: TGroupBox;
    lblPeso: TLabel;
    lblAltura: TLabel;
    sbtnCalcular: TSpeedButton;
    edtPeso: TEdit;
    edtAltura: TEdit;
    edtIMC: TEdit;
    gbxResultado: TGroupBox;
    shpAbaixoPeso: TShape;
    shpPesoIdeal: TShape;
    shpPoucoAcima: TShape;
    shpObesidade: TShape;
    lblAbaixoPeso: TLabel;
    lblPesoIdeal: TLabel;
    lblPoucoAcima: TLabel;
    lblAcimaPeso: TLabel;
    lblObesidade: TLabel;
    Imagens: TImageList;
    lblSetaBottom: TLabel;
    lblSetaTop: TLabel;
    shpAcimaPeso: TShape;
    tmrHorario: TTimer;
    btnHistorico: TSpeedButton;
    procedure edtNomeChange(Sender: TObject);
    procedure edtNascimentoChange(Sender: TObject);
    procedure edtNascimentoExit(Sender: TObject);
    procedure edtPesoChange(Sender: TObject);
    procedure edtPesoExit(Sender: TObject);
    procedure edtAlturaChange(Sender: TObject);
    procedure edtAlturaExit(Sender: TObject);
    procedure sbtnLimparClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmrHorarioTimer(Sender: TObject);
    procedure edtNomeExit(Sender: TObject);
    procedure sbtnCalcularClick(Sender: TObject);
    procedure btnHistoricoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FPacientes: TPacientes;

    procedure TratarExcessoes(pE: Exception);
    procedure CalcularIMC;
    procedure HabilitarComponentesResultado(pHabilitar: Boolean);
    procedure HabilitarShapes(pHabilitar: Boolean);
    procedure LimparDados;
    procedure Calcular;
    procedure Limpar;
    procedure MoverSetas;
    procedure ConfigurarPainelResultado(pPosSetas: Integer; pCorSeta: TColor);
    procedure SalvarHistorico;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  IMC.Helpers.Funcoes, IMC.Forms.Historico;

{$R *.dfm}

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FPacientes);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  FPacientes := TPacientes.Create;

  sttsbarInformacao.Panels[0].Text := DateToStr(Now);
  tmrHorario.Enabled := True;
end;

procedure TfrmPrincipal.HabilitarComponentesResultado(pHabilitar: Boolean);
begin
  lblAbaixoPeso.Enabled := pHabilitar;
  lblPesoIdeal.Enabled := pHabilitar;
  lblPoucoAcima.Enabled := pHabilitar;
  lblAcimaPeso.Enabled := pHabilitar;
  lblObesidade.Enabled := pHabilitar;
  sbtnLimpar.Enabled := pHabilitar;
  lblSetaBottom.Visible := pHabilitar;
  lblSetaTop.Visible := pHabilitar;

  HabilitarShapes(pHabilitar);
end;

procedure TfrmPrincipal.HabilitarShapes(pHabilitar: Boolean);
begin
  shpAbaixoPeso.Brush.Color := $00E6E6E6;
  shpPesoIdeal.Brush.Color := $00D7D7D7;
  shpPoucoAcima.Brush.Color := $00C9C9C9;
  shpAcimaPeso.Brush.Color := $00BCBCBC;
  shpObesidade.Brush.Color := $00A8A8A8;

  if pHabilitar then
  begin
    shpAbaixoPeso.Brush.Color := $00D1B499;
    shpPesoIdeal.Brush.Color := $00C0DCC0;
    shpPoucoAcima.Brush.Color := $00BBFFFF;
    shpAcimaPeso.Brush.Color := $008CC6FF;
    shpObesidade.Brush.Color := $007D7DFF;
  end;
end;

procedure TfrmPrincipal.LimparDados;
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

procedure TfrmPrincipal.MoverSetas;
begin
  case FPacientes.Atual.StatusIMC of
    siAbaixo: ConfigurarPainelResultado(80, $00D1B499);
    siIdeal: ConfigurarPainelResultado(229, $00C0DCC0);
    siPoucoAcima: ConfigurarPainelResultado(375, $00BBFFFF);
    siAcima: ConfigurarPainelResultado(526, $008CC6FF);
    siObeso: ConfigurarPainelResultado(673, $007D7DFF);
  end;
end;

procedure TfrmPrincipal.SalvarHistorico;
var
  lDataHoraAtual: string;
begin
  lDataHoraAtual := FormatDateTime('dd/mm/yyyy hh:nn:ss:zzz', Now);
  FPacientes.Historico.Adicionar(lDataHoraAtual, FPacientes.Salvar);
end;

procedure TfrmPrincipal.btnHistoricoClick(Sender: TObject);
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
  Calcular;
end;

procedure TfrmPrincipal.Calcular;
begin
  try
    if THelpers.VerificarCampoVazio(edtNome) then
    begin
      Application.MessageBox('O nome n�o foi preenchido, verifique', 'Aten��o', MB_OK + MB_ICONINFORMATION);
      THelpers.Focar(edtNome);
      Exit;
    end;

    if THelpers.VerificarCampoVazio(edtNascimento) then
    begin
      Application.MessageBox('A data de nascimento n�o foi preenchida, verifique', 'Aten��o', MB_OK + MB_ICONINFORMATION);
      THelpers.Focar(edtNascimento);
      Exit;
    end;

    CalcularIMC;
    HabilitarComponentesResultado(True);
    sbtnLimpar.Enabled := True;
    btnHistorico.Enabled := True;
    MoverSetas;
  except
    on E: Exception do
    begin
      TratarExcessoes(E);
    end;
  end;
end;

procedure TfrmPrincipal.Limpar;
begin
  LimparDados;
  sbtnLimpar.Enabled := False;
  HabilitarComponentesResultado(False);
end;

procedure TfrmPrincipal.CalcularIMC;
begin
  FPacientes.Atual.VerificarIMC(TSexoPaciente(rgpSexo.ItemIndex));
  edtIMC.Text := FormatFloat('#,##0.00', FPacientes.Atual.MediaIMC);
end;

procedure TfrmPrincipal.sbtnCalcularClick(Sender: TObject);
begin
  ActiveControl := nil;
  Calcular;
  SalvarHistorico;
end;

procedure TfrmPrincipal.sbtnLimparClick(Sender: TObject);
begin
  ActiveControl := nil;
  Limpar;
end;

procedure TfrmPrincipal.ConfigurarPainelResultado(pPosSetas: Integer; pCorSeta: TColor);
begin
  lblSetaBottom.Left := pPosSetas;
  lblSetaBottom.Font.Color := pCorSeta;
  lblSetaTop.Left := pPosSetas;
  lblSetaTop.Font.Color := pCorSeta;
end;

procedure TfrmPrincipal.tmrHorarioTimer(Sender: TObject);
begin
  sttsbarInformacao.Panels[1].Text := TimeToStr(Now);
end;

procedure TfrmPrincipal.TratarExcessoes(pE: Exception);
begin
  Application.MessageBox(PChar('Houve uma inconsistencia, verifique:' + sLineBreak + pE.Message), 'Aten��o', MB_OK +
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

procedure TfrmPrincipal.edtAlturaChange(Sender: TObject);
begin
  if THelpers.VerificarCampoVazio(edtAltura) then
  begin
    Exit;
  end;

  edtAltura.Text := THelpers.FormatarCurr(THelpers.DigitarNumeros(edtAltura.Text));
  THelpers.MoverFinal(edtAltura);
end;

procedure TfrmPrincipal.edtAlturaExit(Sender: TObject);
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

procedure TfrmPrincipal.edtNascimentoChange(Sender: TObject);
begin
  THelpers.FormatarData(edtNascimento);
end;

procedure TfrmPrincipal.edtNascimentoExit(Sender: TObject);
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

procedure TfrmPrincipal.edtNomeChange(Sender: TObject);
begin
  edtNome.Text := THelpers.DigitarLetras(edtNome.Text);
end;

procedure TfrmPrincipal.edtNomeExit(Sender: TObject);
begin
  FPacientes.Atual.Nome := THelpers.DigitarLetras(edtNome.Text);
end;

procedure TfrmPrincipal.edtPesoChange(Sender: TObject);
begin
  if THelpers.VerificarCampoVazio(edtPeso) then
  begin
    Exit;
  end;

  edtPeso.Text := THelpers.FormatarCurr(THelpers.DigitarNumeros(edtPeso.Text));
  THelpers.MoverFinal(edtPeso);
end;

procedure TfrmPrincipal.edtPesoExit(Sender: TObject);
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

end.