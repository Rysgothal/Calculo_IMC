unit IMC.Classes.IMCMasc;

interface

uses
  IMC.Interfaces.StrategyIMC, IMC.Helpers.TiposAuxiliares;

type
  { Strategy }
  TPacienteMasculino = class(TInterfacedObject, IIMC)
  public
    function VerificarIMC(const pIMC: Single): TStatusIMC;
  end;

implementation

{ TPacienteMasculino }

function TPacienteMasculino.VerificarIMC(const pIMC: Single): TStatusIMC;
begin
  Result := siObeso;

  if pIMC <= 20.7 then  // Menor que 20.7
  begin
    Result := siAbaixo;
  end else
  if pIMC <= 26.4 then  // Entre 20.7 e 26.4
  begin
    Result := siIdeal;
  end else
  if pIMC <= 27.8 then  // Entre 26.4 e 27.8
  begin
    Result := siPoucoAcima;
  end else
  if pIMC <= 31.1 then  // Entre 27.8 e 31.1
  begin
    Result := siAcima;
  end;
end;

end.
