unit IMC.Classes.IMCFemi;

interface

uses
  IMC.Interfaces.StrategyIMC, IMC.Helpers.TiposAuxiliares;

type
  { Strategy }
  TPacienteFeminino = class(TInterfacedObject, IIMC)
  public
    function VerificarIMC(const pIMC: Single): TStatusIMC;
  end;

implementation

uses
  System.SysUtils, System.StrUtils;

{ TPacienteFeminino }

function TPacienteFeminino.VerificarIMC(const pIMC: Single): TStatusIMC;
begin
  Result := siObeso;

  if pIMC <= 19.1 then  // Menor que 19.1
  begin
    Result := siAbaixo;
  end else
  if pIMC <= 25.8 then  // Entre 19.2 e 25.8
  begin
    Result := siIdeal;
  end else
  if pIMC <= 27.3 then  // Entre 25.9 e 27.3
  begin
    Result := siPoucoAcima;
  end else
  if pIMC <= 32.3 then  // Entre 27.3 e 32.3
  begin
    Result := siAcima;
  end;
end;

end.
