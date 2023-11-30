unit IMC.Helpers.Exceptions;

interface

uses
  System.SysUtils;

type
  EPesoNaoInformado = class(Exception);
  EPesoIncorreto = class(Exception);

  EAlturaNaoInformada = class(Exception);
  EAlturaIncorreta = class(Exception);

  ESexoNaoInformado = class(Exception);

  ENascimentoNaoInformado = class(Exception);
  EDataIncorreta = class(Exception);

implementation

end.
