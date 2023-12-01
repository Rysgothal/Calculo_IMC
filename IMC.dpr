program IMC;

uses
  Vcl.Forms,
  IMC.Forms.Principal in 'Forms\IMC.Forms.Principal.pas' {frmPrincipal},
  IMC.Helpers.Enumerados in 'Helpers\IMC.Helpers.Enumerados.pas',
  IMC.Helpers.Exceptions in 'Helpers\IMC.Helpers.Exceptions.pas',
  IMC.Helpers.Funcoes in 'Helpers\IMC.Helpers.Funcoes.pas',
  IMC.Classes.Pessoa in 'Classes\IMC.Classes.Pessoa.pas',
  IMC.Classes.IMCFemi in 'Classes\Strategy\IMC.Classes.IMCFemi.pas',
  IMC.Classes.IMCMasc in 'Classes\Strategy\IMC.Classes.IMCMasc.pas',
  IMC.Classes.Restaurar in 'Classes\Memento\IMC.Classes.Restaurar.pas',
  IMC.Classes.Historico in 'Classes\Memento\IMC.Classes.Historico.pas',
  IMC.Classes.Paciente in 'Classes\IMC.Classes.Paciente.pas',
  IMC.Forms.Historico in 'Forms\IMC.Forms.Historico.pas' {frmHistorico},
  IMC.Interfaces.StrategyIMC in 'Interfaces\Strategy\IMC.Interfaces.StrategyIMC.pas',
  IMC.Frames.ResultadoIMC in 'Frames\IMC.Frames.ResultadoIMC.pas' {frmResultadoIMC: TFrame},
  IMC.Interfaces.Observer in 'Interfaces\Observer\IMC.Interfaces.Observer.pas',
  IMC.Interfaces.Subject in 'Interfaces\Observer\IMC.Interfaces.Subject.pas',
  IMC.Frames.DadosCalculoIMC in 'Frames\IMC.Frames.DadosCalculoIMC.pas' {frmDadosCalculoIMC: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
