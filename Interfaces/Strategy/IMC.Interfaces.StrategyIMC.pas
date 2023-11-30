unit IMC.Interfaces.StrategyIMC;

interface

uses
  IMC.Helpers.Enumerados;

type
  { Strategy }
  IIMC = interface
    function VerificarIMC(const pIMC: Single): TStatusIMC;
  end;

implementation

end.
