unit IMC.Interfaces.FabricaShapeCores;

interface

uses
  IMC.Interfaces.CoresShape;

type
  { Factory Method }
  IFabricaShapeCores = interface
    function ConsultarCorShape(const pFeitoCalculo: Boolean): IShapeCor;
  end;

implementation

end.
