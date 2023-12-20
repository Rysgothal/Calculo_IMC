unit IMC.Interfaces.FabricaShapeCores;

interface

uses
  IMC.Interfaces.CoresShape;

type
  { Factory Method }
  IFabricaConfiguracaoResultado = interface
    function ConsultarConfiguracaoResultado(const pFeitoCalculo: Boolean): IConfiguracaoResultado;
  end;

implementation

end.
