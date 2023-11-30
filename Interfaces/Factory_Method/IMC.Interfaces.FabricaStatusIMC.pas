unit IMC.Interfaces.FabricaStatusIMC;

interface

uses
  IMC.Helpers.Enumerados;

type
  IFabricaStatusIMC = interface
    function ConsultarStatusIMC(const pIMC: Single): TStatusIMC;
  end;

implementation

end.
