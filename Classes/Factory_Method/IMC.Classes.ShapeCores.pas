unit IMC.Classes.ShapeCores;

interface

uses
  IMC.Interfaces.CoresShape, System.UITypes;

type
  { Factory Method }
  TShapeHabilitado = class(TInterfacedObject, IShapeCor)
    function CorAbaixoPeso: TColor;
    function CorPesoIdeal: TColor;
    function CorPoucoAcimaPeso: TColor;
    function CorAcimaPeso: TColor;
    function CorObeso: TColor;
  end;

  { Factory Method }
  TShapeDesabilitado = class(TInterfacedObject, IShapeCor)
    function CorAbaixoPeso: TColor;
    function CorPesoIdeal: TColor;
    function CorPoucoAcimaPeso: TColor;
    function CorAcimaPeso: TColor;
    function CorObeso: TColor;
  end;

implementation

{ TShapeHabilitado }

function TShapeHabilitado.CorAbaixoPeso: TColor;
begin
  Result := $00D1B499
end;

function TShapeHabilitado.CorAcimaPeso: TColor;
begin
  Result := $008CC6FF
end;

function TShapeHabilitado.CorObeso: TColor;
begin
  Result := $007D7DFF
end;

function TShapeHabilitado.CorPesoIdeal: TColor;
begin
  Result := $00C0DCC0
end;

function TShapeHabilitado.CorPoucoAcimaPeso: TColor;
begin
  Result := $00BBFFFF
end;

{ TShapeDesabilitado }

function TShapeDesabilitado.CorAbaixoPeso: TColor;
begin
   Result := $00E6E6E6;
end;

function TShapeDesabilitado.CorAcimaPeso: TColor;
begin
  Result := $00BCBCBC
end;

function TShapeDesabilitado.CorObeso: TColor;
begin
  Result := $00A8A8A8
end;

function TShapeDesabilitado.CorPesoIdeal: TColor;
begin
  Result := $00D7D7D7;
end;

function TShapeDesabilitado.CorPoucoAcimaPeso: TColor;
begin
  Result := $00C9C9C9
end;

end.
