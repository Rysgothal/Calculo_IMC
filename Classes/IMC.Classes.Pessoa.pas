unit IMC.Classes.Pessoa;

interface

uses
  IMC.Helpers.TiposAuxiliares, IMC.Helpers.Exceptions;

type
  { Base }
  TPessoa = class
  private
    FNome: string;
    FNascimento: string;
    FPeso: string;
    FAltura: string;
    FStatusIMC: TStatusIMC;
    FMediaIMC: Single;
    FIdade: string;
    FSexo: TSexoPaciente;
    procedure SetAltura(const pValor: string);
    procedure SetNascimento(const pValor: string);
    procedure SetPeso(const pValor: string);
    procedure CalcularIdade;
    procedure CalcularMediaIMC;
    function CalcularAnos(lDataNascimento: TDate): Integer;
    function CalcularMeses(lDataNascimento: TDate; lAnos: Integer): Integer;
    function CalcularSemanas(lDataNascimento: TDate; lAnos: Integer; lMeses: Integer): Integer;
    function CalcularDias(lDataNascimento: TDate; lAnos: Integer; lMeses: Integer; lSemanas: Integer): Integer;
  public
    property Nome: string read FNome write FNome;
    property Nascimento: string read FNascimento write SetNascimento;
    property Idade: string read FIdade write FIdade;
    property Peso: string read FPeso write SetPeso;
    property Altura: string read FAltura write SetAltura;
    property StatusIMC: TStatusIMC read FStatusIMC write FStatusIMC;
    property MediaIMC: Single read FMediaIMC write FMediaIMC;
    property Sexo: TSexoPaciente read FSexo write FSexo;
    constructor Create;
    procedure Limpar;
  end;

implementation

uses
  IMC.Helpers.Funcoes, System.DateUtils, System.Math, System.SysUtils;

{ TPessoa }

procedure TPessoa.CalcularIdade;
var
  lDataNascimento: TDate;
  lAnos, lMeses, lSemanas, lDias: Integer;
begin
  Idade := EmptyStr;
  lDataNascimento := StrToDate(FNascimento);

  lAnos := CalcularAnos(lDataNascimento);
  lMeses := CalcularMeses(lDataNascimento, lAnos);
  lSemanas := CalcularSemanas(lDataNascimento, lAnos, lMeses);
  lDias := CalcularDias(lDataNascimento, lAnos, lMeses, lSemanas);

  case lAnos of
    0: ;
    1: Idade   := lAnos.ToString + ' Ano; ';
    else Idade := lAnos.ToString + ' Anos; ';
  end;

  case lMeses of
    0: ;
    1: Idade   := Idade + lMeses.ToString + ' Mês; ';
    else Idade := Idade + lMeses.ToString + ' Meses; ';
  end;

  case lSemanas of
    0: ;
    1: Idade   := Idade + lSemanas.ToString + ' Semana; ';
    else Idade := Idade + lSemanas.ToString + ' Semanas; ';
  end;

  case lDias of
    0: ;
    1: Idade   := Idade + lDias.ToString + ' Dia. ';
    else Idade := Idade + lDias.ToString + ' Dias. ';
  end;

  case THelpers.VerificarCampoVazio(Idade) of
    True: Idade := 'Recém-Nascido';
    else  Idade := Copy(Idade, 1, Length(Idade) - 2) + '.';
  end;
end;

procedure TPessoa.CalcularMediaIMC;
begin
  if THelpers.VerificarCampoVazio(Peso) or THelpers.VerificarCampoVazio(Altura) then
  begin
    Exit;
  end;

  MediaIMC := StrToFloat(Peso) / Power(StrToFloat(Altura), 2);
end;

constructor TPessoa.Create;
begin
  FNome := EmptyStr;
  FNascimento := EmptyStr;
  FPeso := EmptyStr;
  FAltura := EmptyStr;
  FStatusIMC := siNaoCalculado;
  FSexo := spNaoInformado;
  FMediaIMC := 0;
  FIdade := EmptyStr;
end;

procedure TPessoa.Limpar;
begin
  FNome := EmptyStr;
  FNascimento := EmptyStr;
  FPeso := EmptyStr;
  FAltura := EmptyStr;
  FStatusIMC := siNaoCalculado;
  FMediaIMC := 0;
  FIdade := 'anos; meses; semanas; dias;';
end;

function TPessoa.CalcularDias(lDataNascimento: TDate; lAnos: Integer; lMeses: Integer; lSemanas: Integer): Integer;
begin
  Result := DaysBetween(IncWeek(IncMonth(IncYear(lDataNascimento, lAnos), lMeses), lSemanas), Now);
end;

function TPessoa.CalcularSemanas(lDataNascimento: TDate; lAnos: Integer; lMeses: Integer): Integer;
begin
  Result := WeeksBetween(IncMonth(IncYear(lDataNascimento, lAnos), lMeses), Now);
end;

function TPessoa.CalcularMeses(lDataNascimento: TDate; lAnos: Integer): Integer;
begin
  Result := MonthsBetween(IncYear(lDataNascimento, lAnos), Now);
end;

function TPessoa.CalcularAnos(lDataNascimento: TDate): Integer;
begin
  Result := YearsBetween(lDataNascimento, Now);
end;

procedure TPessoa.SetAltura(const pValor: string);
var
  lAltura: Single;
begin
  if THelpers.VerificarCampoVazio(pValor) then
  begin
    FAltura := EmptyStr;
    Exit;
  end;

  if not TryStrToFloat(pValor, lAltura) then
  begin
    raise EAlturaIncorreta.Create('A altura informada não é válida.');
  end;

  if lAltura = 0 then
  begin
    raise EAlturaZerada.Create('A altura informada não pode ser zero.');
  end;

  FAltura := pValor;
  CalcularMediaIMC;
end;

procedure TPessoa.SetNascimento(const pValor: string);
var
  lDataNascimento: TDateTime;
begin
  FNascimento := pValor;

  if THelpers.VerificarCampoVazio(pValor) then
  begin
    FNascimento := EmptyStr;
    FIdade := 'anos; meses; semanas; dias;';
    Exit;
  end;

  if not TryStrToDate(Nascimento, lDataNascimento) then
  begin
    FNascimento := EmptyStr;
    FIdade := 'anos; meses; semanas; dias;';
    raise EDataIncorreta.Create('A data inserida não está correta.');
  end;

  if (YearsBetween(lDataNascimento, Date) > 150) or (lDataNascimento > Now) then
  begin
    FNascimento := EmptyStr;
    FIdade := 'anos; meses; semanas; dias;';
    raise EDataInvalida.Create('Data incoerente com os dias atuais.');
  end;

  CalcularIdade;
end;

procedure TPessoa.SetPeso(const pValor: string);
var
  lPeso: Single;
begin
  if THelpers.VerificarCampoVazio(pValor) then
  begin
    FPeso := EmptyStr;
    Exit;
  end;

  if not TryStrToFloat(pValor, lPeso) then
  begin
    raise EPesoIncorreto.Create('O peso informado não é válido.');
  end;

  if lPeso = 0 then
  begin
    raise EPesoZerado.Create('O peso informado não pode ser zero.');
  end;

  FPeso := pValor;
  CalcularMediaIMC;
end;

end.
