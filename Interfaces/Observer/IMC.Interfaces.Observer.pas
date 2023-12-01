unit IMC.Interfaces.Observer;

interface

uses
  IMC.Helpers.Enumerados;

type
  IObserver = interface
    procedure Atualizar(pInformacao: TStatusIMC);
  end;

implementation

end.
