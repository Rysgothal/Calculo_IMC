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
    constructor Create;
    procedure Limpar;
  end;

implementation

uses
  IMC.Helpers.Funcoes, System.SysUtils, System.DateUtils, System.Math;

{ TPessoa }

procedure TPessoa.CalcularIdade;
var
  lDataNascimento: TDateTime;
  lAnos, lMeses, lSemanas, lDias: Integer;
begin
  Idade := EmptyStr;
  lDataNascimento := StrToDate(FNascimento);

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
    1: Idade   := Idade + lMeses.ToString + ' M�s; ';
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
    raise EAlturaIncorreta.Create('A altura informada n�o � v�lida.');
  end;

  if lAltura = 0 then
  begin
    raise EAlturaZerada.Create('A altura informada n�o pode ser zero.');
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

  if not TryStrToDate(Nascimento, lDataNascimento) or (YearsBetween(lDataNascimento, Date) > 110) or
    (lDataNascimento > Now) then
  begin
    FNascimento := EmptyStr;
    FIdade := 'anos; meses; semanas; dias;';
    raise EDataIncorreta.Create('Data incoerente com os dias atuais');
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
    raise EPesoIncorreto.Create('O peso informado n�o � v�lido.');
  end;

  if lPeso = 0 then
  begin
    raise EPesoZerado.Create('O peso informado n�o pode ser zero.');
  end;

  FPeso := pValor;
  CalcularMediaIMC;
end;

end.
