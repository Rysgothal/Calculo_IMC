unit IMC.Classes.Paciente;

interface

uses
  IMC.Interfaces.StrategyIMC, IMC.Helpers.Enumerados, IMC.Classes.Pessoa;

type
  { Strategy - Contexto }
  TPaciente = class(TPessoa)
  private
    FIMC: IIMC;
  public
    procedure VerificarIMC(pSexo: TSexoPaciente);
  end;

implementation

uses
  IMC.Classes.IMCMasc, IMC.Classes.IMCFemi, IMC.Helpers.Funcoes,
  IMC.Helpers.Exceptions;

{ TPaciente }

procedure TPaciente.VerificarIMC(pSexo: TSexoPaciente);
begin
  case pSexo of
    spMasculino: FIMC := TPacienteMasculino.Create;
    spFeminino: FIMC := TPacienteFeminino.Create;
    else raise ESexoNaoInformado.Create('O sexo não foi informado');
  end;

  if THelpers.VerificarCampoVazio(Peso) then
  begin
    raise EPesoNaoInformado.Create('O peso não foi informado');
  end;

  if THelpers.VerificarCampoVazio(Altura) then
  begin
    raise EAlturaNaoInformada.Create('A altura não foi informada');
  end;

  PesoIMC :=  FIMC.VerificarIMC(MediaIMC);
end;

end.
