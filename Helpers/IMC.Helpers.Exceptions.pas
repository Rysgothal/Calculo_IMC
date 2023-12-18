unit IMC.Helpers.Exceptions;

interface

uses
  System.SysUtils;

type
  EPesoNaoInformado = class(Exception);
  EPesoIncorreto = class(Exception);
  EPesoZerado = class(Exception);

  EAlturaNaoInformada = class(Exception);
  EAlturaIncorreta = class(Exception);
  EAlturaZerada = class(Exception);

  ESexoNaoInformado = class(Exception);

  ENascimentoNaoInformado = class(Exception);
  EDataIncorreta = class(Exception);
  EDataInvalida = class(Exception);

implementation

end.
