unit IMC.Classes.FabricaStatusIMC;

interface

uses
  IMC.Helpers.Enumerados, IMC.Interfaces.FabricaStatusIMC;

type
  TFabricaStatusIMC = class(TInterfacedObject, IFabricaStatusIMC)
  public
    function ConsultarStatusIMC(const pIMC: Single): TStatusIMC;
  end;

implementation

{ TFabricaStatusIMC }

function TFabricaStatusIMC.ConsultarStatusIMC(const pIMC: Single): TStatusIMC;
begin
end;

end.
