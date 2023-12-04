unit IMC.Interfaces.CoresShape;

interface

uses
  System.UITypes;

type
  { Factory Method }
  IShapeCor = interface
    function CorAbaixoPeso: TColor;
    function CorPesoIdeal: TColor;
    function CorPoucoAcimaPeso: TColor;
    function CorAcimaPeso: TColor;
    function CorObeso: TColor;
  end;

implementation

end.
