unit IMC.Interfaces.StrategyIMC;

interface

uses
  IMC.Helpers.TiposAuxiliares;

type
  { Strategy }
  IIMC = interface
    function VerificarIMC(const pIMC: Single): TStatusIMC;
  end;

implementation

end.
