unit IMC.Classes.FabricaShapeCor;

interface

uses
  IMC.Interfaces.FabricaShapeCores, IMC.Interfaces.CoresShape;

type
  { Factory Method }
  TFabricaShapeCor = class(TInterfacedObject, IFabricaShapeCores)
    function ConsultarCorShape(const pHabilitar: Boolean): IShapeCor;
  end;

implementation

uses
  IMC.Classes.ShapeCores;

{ TFabricaShapeCor }

function TFabricaShapeCor.ConsultarCorShape(const pHabilitar: Boolean): IShapeCor;
begin
  case pHabilitar of
    True: Result := TShapeHabilitado.Create;
    else Result := TShapeDesabilitado.Create;
  end;
end;

end.
