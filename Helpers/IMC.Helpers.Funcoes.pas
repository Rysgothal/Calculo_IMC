unit IMC.Helpers.Funcoes;

interface

uses
  Vcl.StdCtrls, System.SysUtils, Vcl.Controls;

type
  TPositions = array of Integer;
  TChars = array of Char;

  THelpers = class abstract
  public
    class function FormatarCurr(pValor: string): string;
    class function DigitarNumeros(pValor: string): string;
    class function DigitarLetras(pValor: string): string;
    class function VerificarCampoVazio(pComponente: TCustomEdit): Boolean; overload;
    class function VerificarCampoVazio(pValor: string): Boolean; overload;
    class procedure MoverFinal(const pEdit: TCustomEdit);
    class function ValidarDigitado(pValor: string; pCharSet: TSysCharSet): string;
    class function FormatarData(const pValor: string): string; overload;
    class procedure FormatarData(const pEdit: TCustomEdit); overload;
    class procedure InsertChar(var pValor: string; const pPos: Integer; const pChar: Char); overload;
    class procedure InsertChars(var pValor: string; const pPos: TPositions; const pChars: TChars); overload;
    class procedure InsertChars(var pValor: string; const pPos: TPositions; const pChar: Char); overload;
    class procedure Focar(const pComponente: TWinControl);
  end;

implementation

uses
  System.DateUtils, System.Math;

{ THelpers }

class function THelpers.DigitarNumeros(pValor: string): string;
begin
  Result := ValidarDigitado(pValor, ['0'..'9'])
end;

class function THelpers.DigitarLetras(pValor: string): string;
begin
  Result := ValidarDigitado(pValor, ['A'..'Z', 'a'..'z', #32]); // #32 SPACE
end;

class procedure THelpers.Focar(const pComponente: TWinControl);
begin
  if pComponente.CanFocus then
  begin
    pComponente.SetFocus;
  end;
end;

class function THelpers.FormatarCurr(pValor: string): string;
begin
  Result := DigitarNumeros(pValor).PadLeft(3, '0').Substring(0, 16);
  Result.Insert(Result.Length - 2, ',');
  Result := FormatCurr(',0.00', StrToCurrDef(Result, 0));
end;

class procedure THelpers.FormatarData(const pEdit: TCustomEdit);
begin
  pEdit.Text := FormatarData(pEdit.Text).Substring(0, 10);
  MoverFinal(pEdit);
end;

class procedure THelpers.InsertChar(var pValor: string; const pPos: Integer; const pChar: Char);
begin
  if pValor.Length > pPos then
  begin
    pValor.Insert(pPos, pChar);
  end;
end;

class procedure THelpers.InsertChars(var pValor: string; const pPos: TPositions; const pChar: Char);
begin
   InsertChars(pValor, pPos, [pChar]);
end;

class procedure THelpers.InsertChars(var pValor: string; const pPos: TPositions;
  const pChars: TChars);
var
  I, vPosCount, vCharsCount: Integer;
  pChar: Char;
begin
  vPosCount := Length(pPos);
  for I := 0 to Pred(vPosCount) do
  begin
    vCharsCount := Pred(Length(pChars));
    pChar := pChars[Min(vCharsCount, I)];
    InsertChar(pValor, pPos[i], pChar);
  end;
end;

class function THelpers.FormatarData(const pValor: string): string;
begin
  Result := DigitarNumeros(pValor).Substring(0, 14);
  InsertChars(Result, [4, 2], '/')
end;

class procedure THelpers.MoverFinal(const pEdit: TCustomEdit);
begin
  pEdit.SelStart := Length(pEdit.Text);
end;

class function THelpers.ValidarDigitado(pValor: string; pCharSet: TSysCharSet): string;
begin
  for var vChar in pValor do
  begin
    if CharInSet(vChar, pCharSet) then
    begin
      Result := Result + vChar;
    end;
  end;
end;

class function THelpers.VerificarCampoVazio(pValor: string): Boolean;
begin
  Result := pValor.Trim = EmptyStr;
end;

class function THelpers.VerificarCampoVazio(pComponente: TCustomEdit): Boolean;
begin
  Result := VerificarCampoVazio(pComponente.Text);
end;

end.
