unit IMC.Classes.FabricaShapeCor;

interface

uses
  IMC.Interfaces.FabricaShapeCores, IMC.Interfaces.CoresShape;

type
  { Factory Method }
  TFabricaConfiguracaoResultado = class(TInterfacedObject, IFabricaConfiguracaoResultado)
  public
    function ConsultarConfiguracaoResultado(const pHabilitar: Boolean): IConfiguracaoResultado;
  end;

implementation

uses
  IMC.Classes.ShapeCores;

{ TFabricaShapeCor }

function TFabricaConfiguracaoResultado.ConsultarConfiguracaoResultado(const pHabilitar: Boolean): IConfiguracaoResultado;
begin
  case pHabilitar of
    True: Result := TShapeHabilitado.Create;
    else Result := TShapeDesabilitado.Create;
  end;
end;

end.
