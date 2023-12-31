unit IMC.Interfaces.AbstractFactory;

interface

uses
  IMC.Helpers.TiposAuxiliares, Vcl.Graphics;

type
  { Abstract Factory }
  ISetaConfiguracao = interface
    function PosicaoSeta: Word;
    function CorSeta: TColor;
  end;

  IFabricaStatusIMC = interface
    function ConsultarConfSeta: ISetaConfiguracao;
  end;

implementation

end.
