unit IMC.Interfaces.CoresShape;

interface

uses
  System.UITypes, IMC.Helpers.TiposAuxiliares;

type
  { Factory Method }
  IConfiguracaoResultado = interface
    function ConfigAbaixoPeso: TConfig;
    function ConfigPesoIdeal: TConfig;
    function ConfigPoucoAcimaPeso: TConfig;
    function ConfigAcimaPeso: TConfig;
    function ConfigObeso: TConfig;
  end;

implementation

end.
