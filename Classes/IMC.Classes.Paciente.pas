unit IMC.Classes.Paciente;

interface

uses
  IMC.Interfaces.StrategyIMC, IMC.Helpers.TiposAuxiliares, IMC.Classes.Pessoa,
  IMC.Classes.Historico, IMC.Classes.Restaurar,
  IMC.Interfaces.Subject, System.Generics.Collections, IMC.Interfaces.Observer;

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
  { Observer  }
  TPacientesSingleton = class
  private
    FAtual: TPaciente;
    FHistorico: THistorico;
    FObservers: TList<IObserver>;
    constructor Create;
  public
    property Atual: TPaciente read FAtual write FAtual;
    property Historico: THistorico read FHistorico write FHistorico;
    property Observers: TList<IObserver> read FObservers;
    class function ObterInstancia: TPacientesSingleton;
    destructor Destroy; override;

    // Memento
    function Salvar: TRestaurar;
    procedure Restaurar(pRestaurar: TRestaurar);

    // Observer
    procedure AdicionarObserver(pObserver: IObserver);
    procedure RemoverObserver(pObserver: IObserver);
  end;

var
  FPacientes: TPacientesSingleton;

implementation

uses
  IMC.Classes.IMCMasc, IMC.Classes.IMCFemi, IMC.Helpers.Funcoes,
  IMC.Helpers.Exceptions, System.SysUtils;

{ TPaciente }

procedure TPaciente.VerificarIMC(pSexo: TSexoPaciente);
begin
  if (Nascimento = EmptyStr) or (Nome = EmptyStr) then
  begin
    Exit;
  end;

  case pSexo of
    spMasculino: FIMC := TPacienteMasculino.Create;
    spFeminino: FIMC := TPacienteFeminino.Create;
    else raise ESexoNaoInformado.Create('O sexo não foi informado.');
  end;

  if THelpers.VerificarCampoVazio(Peso) then
  begin
    raise EPesoNaoInformado.Create('O peso não foi informado.');
  end;

  if THelpers.VerificarCampoVazio(Altura) then
  begin
    raise EAlturaNaoInformada.Create('A altura não foi informada.');
  end;

  StatusIMC := FIMC.VerificarIMC(MediaIMC);
end;

{ TPacientes }

procedure TPacientesSingleton.AdicionarObserver(pObserver: IObserver);
begin
  FObservers.Add(pObserver);
end;

constructor TPacientesSingleton.Create;
begin
  FHistorico := THistorico.Create;
  FAtual := TPaciente.Create;
  FObservers := TList<IObserver>.Create;
end;

destructor TPacientesSingleton.Destroy;
begin
  FreeAndNil(FAtual);
  FreeAndNil(FHistorico);
  FreeAndNil(FObservers);
  inherited;
end;

class function TPacientesSingleton.ObterInstancia: TPacientesSingleton;
begin
  if not Assigned(FPacientes) then
  begin
    FPacientes := TPacientesSingleton.Create;
  end;

  Result := FPacientes;
end;

procedure TPacientesSingleton.RemoverObserver(pObserver: IObserver);
begin
  FObservers.Delete(FObservers.IndexOf(pObserver));
end;

procedure TPacientesSingleton.Restaurar(pRestaurar: TRestaurar);
begin
  Atual.Nome := pRestaurar.Nome;
  Atual.Nascimento := pRestaurar.Nascimento;
  Atual.Idade := pRestaurar.Idade;
  Atual.Peso := pRestaurar.Peso;
  Atual.Altura := pRestaurar.Altura;
  Atual.StatusIMC := pRestaurar.StatusIMC;
  Atual.MediaIMC := pRestaurar.MediaIMC;
  Atual.Sexo := pRestaurar.Sexo;
end;

function TPacientesSingleton.Salvar: TRestaurar;
begin
  Result := TRestaurar.Create;

  Result.Nome := Atual.Nome;
  Result.Nascimento := Atual.Nascimento;
  Result.Idade := Atual.Idade;
  Result.Peso := Atual.Peso;
  Result.Altura := Atual.Altura;
  Result.StatusIMC := Atual.StatusIMC;
  Result.MediaIMC := Atual.MediaIMC;
  Result.Sexo := Atual.Sexo;
end;

initialization

finalization
  FreeAndNil(FPacientes);

end.
