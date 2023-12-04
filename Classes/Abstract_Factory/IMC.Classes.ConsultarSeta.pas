unit IMC.Classes.ConsultarSeta;

interface

uses
  IMC.Interfaces.AbstractFactory, IMC.Helpers.Enumerados;

type
  { Abstract Factory }
  TNaoCalculado = class(TInterfacedObject, IFabricaStatusIMC)
  public
    function ConsultarConfSeta: ISetaConfiguracao;
  end;

  { Abstract Factory }
  TAbaixoPeso = class(TInterfacedObject, IFabricaStatusIMC)
  public
    function ConsultarConfSeta: ISetaConfiguracao;
  end;

  { Abstract Factory }
  TPesoIdeal = class(TInterfacedObject, IFabricaStatusIMC)
  public
    function ConsultarConfSeta: ISetaConfiguracao;
  end;

  { Abstract Factory }
  TPoucoAcimaPeso = class(TInterfacedObject, IFabricaStatusIMC)
  public
    function ConsultarConfSeta: ISetaConfiguracao;
  end;

  { Abstract Factory }
  TAcimaPeso = class(TInterfacedObject, IFabricaStatusIMC)
  public
    function ConsultarConfSeta: ISetaConfiguracao;
  end;

  { Abstract Factory }
  TObeso = class(TInterfacedObject, IFabricaStatusIMC)
  public
    function ConsultarConfSeta: ISetaConfiguracao;
  end;

implementation

uses
  IMC.Classes.ConfigSeta;

{ TNaoCalculado }

function TNaoCalculado.ConsultarConfSeta: ISetaConfiguracao;
begin
  Result := TSetaNaoCalculado.Create;
end;

{ TAbaixoPeso }

function TAbaixoPeso.ConsultarConfSeta: ISetaConfiguracao;
begin
  Result := TSetaAbaixoPeso.Create;
end;

{ TPesoIdeal }

function TPesoIdeal.ConsultarConfSeta: ISetaConfiguracao;
begin
  Result := TSetaPesoIdeal.Create;
end;

{ TPoucoAcimaPeso }

function TPoucoAcimaPeso.ConsultarConfSeta: ISetaConfiguracao;
begin
  Result := TSetaPoucoAcimaPeso.Create;
end;

{ TAcimaPeso }

function TAcimaPeso.ConsultarConfSeta: ISetaConfiguracao;
begin
  Result := TSetaAcimaPeso.Create;
end;

{ TObeso }

function TObeso.ConsultarConfSeta: ISetaConfiguracao;
begin
  Result := TSetaObeso.Create;
end;

end.
