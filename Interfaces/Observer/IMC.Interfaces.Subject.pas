unit IMC.Interfaces.Subject;

interface

uses
  IMC.Interfaces.Observer;

type
  ISubject = interface
    procedure AdicionarObserver(pObserver: IObserver);
    procedure RemoverObserver(pObserver: IObserver);
    procedure Notificar;
  end;

implementation

end.
