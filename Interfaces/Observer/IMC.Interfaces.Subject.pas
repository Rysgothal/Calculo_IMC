unit IMC.Interfaces.Subject;

interface

uses
  IMC.Interfaces.Observer;

type
  ISubject = interface
    procedure Notificar;
  end;

implementation

end.
