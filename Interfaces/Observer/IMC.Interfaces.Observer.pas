unit IMC.Interfaces.Observer;

interface

uses
  IMC.Helpers.TiposAuxiliares;

type
  IObserver = interface
    procedure Atualizar(pInformacao: TStatusIMC);
  end;

implementation

end.
