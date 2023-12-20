unit IMC.Forms.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, System.DateUtils, IMC.Classes.Paciente, IMC.Helpers.Exceptions, IMC.Frames.ResultadoIMC,
  IMC.Frames.DadosCalculoIMC;

type
  TfrmPrincipal = class(TForm)
    sttsbarInformacao: TStatusBar;
    Imagens: TImageList;
    tmrHorario: TTimer;
    frmResultadoIMC: TfrmResultadoIMC;
    frmDadosPaciente: TfrmDadosCalculoIMC;
    procedure FormCreate(Sender: TObject);
    procedure tmrHorarioTimer(Sender: TObject);
    procedure frmDadosPacientesbtnCalcularClick(Sender: TObject);
    procedure frmDadosPacientebtnHistoricoClick(Sender: TObject);
    procedure frmDadosPacientesbtnLimparClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  IMC.Helpers.Funcoes, IMC.Forms.Historico;

{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
var
  lPacientes: TPacientesSingleton;
begin
  lPacientes := TPacientesSingleton.ObterInstancia;

  sttsbarInformacao.Panels[0].Text := DateToStr(Now);
  tmrHorario.Enabled := True;
  lPacientes.AdicionarObserver(frmResultadoIMC);
end;

procedure TfrmPrincipal.frmDadosPacientebtnHistoricoClick(Sender: TObject);
begin
  ActiveControl := nil;
  frmDadosPaciente.btnHistoricoClick(Sender);
end;

procedure TfrmPrincipal.frmDadosPacientesbtnCalcularClick(Sender: TObject);
begin
  ActiveControl := nil;
  frmDadosPaciente.sbtnCalcularClick(Sender);
end;

procedure TfrmPrincipal.frmDadosPacientesbtnLimparClick(Sender: TObject);
begin
  ActiveControl := nil;
  frmDadosPaciente.sbtnLimparClick(Sender);
end;

procedure TfrmPrincipal.tmrHorarioTimer(Sender: TObject);
begin
  sttsbarInformacao.Panels[1].Text := TimeToStr(Now);
end;

end.
