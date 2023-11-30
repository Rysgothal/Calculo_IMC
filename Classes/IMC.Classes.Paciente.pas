unit IMC.Classes.Paciente;

interface

uses
  IMC.Interfaces.StrategyIMC, IMC.Helpers.Enumerados, IMC.Classes.Pessoa,
  IMC.Classes.Historico, IMC.Classes.Restaurar;

type
  { Strategy - Contexto }
  TPaciente = class(TPessoa)
  private
    FIMC: IIMC;
  public
    // Strategy
    procedure VerificarIMC(pSexo: TSexoPaciente);
  end;

  { Singleton }
  { Memento   }
  TPacientes = class
  private
    FAtual: TPaciente;
    FHistorico: THistorico;
  public
    property Atual: TPaciente read FAtual write FAtual;
    property Historico: THistorico read FHistorico write FHistorico;
    constructor Create;
    destructor Destroy; override;

    // Memento
    function Salvar: TRestaurar;
    procedure Restaurar(pRestaurar: TRestaurar);
  end;

implementation

uses
  IMC.Classes.IMCMasc, IMC.Classes.IMCFemi, IMC.Helpers.Funcoes,
  IMC.Helpers.Exceptions, System.SysUtils;

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

  StatusIMC := FIMC.VerificarIMC(MediaIMC);
end;

{ TPacientes }

constructor TPacientes.Create;
begin
  FHistorico := THistorico.Create;
  FAtual := TPaciente.Create;
end;

destructor TPacientes.Destroy;
begin
  FreeAndNil(FAtual);
  FreeAndNil(FHistorico);
  inherited;
end;

procedure TPacientes.Restaurar(pRestaurar: TRestaurar);
begin
  Atual.Nome := pRestaurar.Nome;
  Atual.Nascimento := pRestaurar.Nascimento;
  Atual.Idade := pRestaurar.Idade;
  Atual.Peso := pRestaurar.Peso;
  Atual.Altura := pRestaurar.Altura;
  Atual.StatusIMC := pRestaurar.StatusIMC;
  Atual.MediaIMC := pRestaurar.MediaIMC;
end;

function TPacientes.Salvar: TRestaurar;
begin
  Result := TRestaurar.Create;

  Result.Nome := Atual.Nome;
  Result.Nascimento := Atual.Nascimento;
  Result.Idade := Atual.Idade;
  Result.Peso := Atual.Peso;
  Result.Altura := Atual.Altura;
  Result.StatusIMC := Atual.StatusIMC;
  Result.MediaIMC := Atual.MediaIMC;
end;

end.
