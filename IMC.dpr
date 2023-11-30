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
  IMC.Classes.Paciente in 'Classes\Strategy\IMC.Classes.Paciente.pas',
//  IMC.Classes.PesoIMC in 'Classes\Factory_Method\IMC.Classes.PesoIMC.pas',
  IMC.Interfaces.StrategyIMC in 'Interfaces\Strategy\IMC.Interfaces.StrategyIMC.pas';
//  IMC.Interfaces.FactoryMethodIMC in 'Interfaces\Factory_Method\IMC.Interfaces.FactoryMethodIMC.pas',
//  IMC.Classes.FabricaStatusIMC in 'Classes\Factory_Method\IMC.Classes.FabricaStatusIMC.pas',
//  IMC.Interfaces.FabricaStatusIMC in 'Interfaces\Factory_Method\IMC.Interfaces.FabricaStatusIMC.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
