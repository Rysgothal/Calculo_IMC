unit IMC.Classes.PesoIMC;

interface

uses
  IMC.Interfaces.FactoryMethodIMC, IMC.Helpers.Enumerados;

type
  { Factory Method - Base }
  TPesoIMC = class(TInterfacedObject, IStatusIMC)
  public
    function ConsultarStatusIMC: TStatusIMC; virtual; abstract;
  end;

  TIMCAbaixoPeso = class(TPesoIMC)
  public
    function ConsultarStatusIMC: TStatusIMC; override;
  end;

  TIMCPesoIdeal = class(TPesoIMC)
  public
    function ConsultarStatusIMC: TStatusIMC; override;
  end;

  TIMCPoucoAcimaPeso = class(TPesoIMC)
  public
    function ConsultarStatusIMC: TStatusIMC; override;
  end;

  TIMCAcimaPeso = class(TPesoIMC)
  public
    function ConsultarStatusIMC: TStatusIMC; override;
  end;

  TIMCObeso = class(TPesoIMC)
  public
    function ConsultarStatusIMC: TStatusIMC; override;
  end;


implementation

{ TIMCAbaixoPeso }

function TIMCAbaixoPeso.ConsultarStatusIMC: TStatusIMC;
begin
  Result := siAbaixo;
end;

{ TIMCPesoIdeal }

function TIMCPesoIdeal.ConsultarStatusIMC: TStatusIMC;
begin
  Result := siIdeal;
end;

{ TIMCPoucoAcimaPeso }

function TIMCPoucoAcimaPeso.ConsultarStatusIMC: TStatusIMC;
begin
  Result := siPoucoAcima;
end;

{ TIMCAcimaPeso }

function TIMCAcimaPeso.ConsultarStatusIMC: TStatusIMC;
begin
  Result := siAcima;
end;

{ TIMCObeso }

function TIMCObeso.ConsultarStatusIMC: TStatusIMC;
begin
  Result := siObeso;
end;

end.
