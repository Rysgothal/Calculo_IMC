unit IMC.Classes.Pessoa;

interface

uses
  IMC.Helpers.Enumerados, IMC.Helpers.Exceptions;

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
    FID: Integer;
    procedure SetAltura(const pValor: string);
    procedure SetNascimento(const pValor: string);
    procedure SetPeso(const pValor: string);
    procedure CalcularIdade;
    procedure CalcularMediaIMC;
  public
    property Nome: string read FNome write FNome;
    property Nascimento: string read FNascimento write SetNascimento;
    property Idade: string read FIdade write FIdade;
    property Peso: string read FPeso write SetPeso;
    property Altura: string read FAltura write SetAltura;
    property StatusIMC: TStatusIMC read FStatusIMC write FStatusIMC;
    property MediaIMC: Single read FMediaIMC write FMediaIMC;
    property Sexo: TSexoPaciente read FSexo write FSexo;
    property ID: Integer read FID write FID;
    constructor Create;
    procedure Limpar;
  end;

var
  ID_GERADOR_PACIENTE: Integer = 0;

implementation

uses
  IMC.Helpers.Funcoes, System.SysUtils, System.DateUtils, System.Math;

{ TPessoa }

procedure TPessoa.CalcularIdade;
var
  lDataNascimento: TDateTime;
  lAnos, lMeses, lSemanas, lDias: Integer;
begin
  if not TryStrToDate(Nascimento, lDataNascimento) or (YearsBetween(lDataNascimento, Date) > 110) then
  begin
    raise EDataIncorreta.Create('Data incoerente com os dias atuais');
  end;

  lAnos    := YearsBetween(lDataNascimento, Date);
  lMeses   := MonthsBetween(IncYear(lDataNascimento, lAnos), Date);
  lSemanas := WeeksBetween(IncMonth(IncYear(lDataNascimento, lAnos), lMeses), Date);
  lDias    := DaysBetween(IncWeek(IncMonth(IncYear(lDataNascimento, lAnos), lMeses), lSemanas), Date);

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

  Idade := Copy(Idade, 1, Length(Idade) - 2) + '.';
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

  Inc(ID_GERADOR_PACIENTE);
  FID := ID_GERADOR_PACIENTE;
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
    raise EAlturaIncorreta.Create('A altura informada não é válida');
  end;

  FAltura := pValor;
  CalcularMediaIMC;
end;

procedure TPessoa.SetNascimento(const pValor: string);
begin
  FNascimento := pValor;

  case THelpers.VerificarCampoVazio(pValor) of
    True: FIdade := 'anos; meses; semanas; dias;';
    else CalcularIdade;
  end;
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
    raise EPesoIncorreto.Create('O peso informado não é válido');
  end;

  FPeso := pValor;
  CalcularMediaIMC;
end;

end.
