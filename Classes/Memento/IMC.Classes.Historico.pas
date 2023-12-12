unit IMC.Classes.Historico;

interface

uses
  System.SysUtils, IMC.Classes.Restaurar, System.Generics.Collections;


type
  { Memento }
  THistorico = class
  private
    FLista: TObjectDictionary<Integer, TRestaurar>;
  public
    property Lista: TObjectDictionary<Integer, TRestaurar> read FLista write FLista;
    constructor Create;
    destructor Destroy; override;
    procedure Adicionar(const pIDPaciente: Integer; pRestaurar: TRestaurar);
    function Recuperar(const pIDPaciente: Integer): TRestaurar;
  end;

implementation

{ THistorico }

constructor THistorico.Create;
begin
  FLista := TObjectDictionary<Integer, TRestaurar>.Create([doOwnsValues]);
end;

destructor THistorico.Destroy;
begin
  FreeAndNil(FLista);
  inherited;
end;

function THistorico.Recuperar(const pIDPaciente: Integer): TRestaurar;
begin
  Result := Lista.Items[pIDPaciente];
end;

procedure THistorico.Adicionar(const pIDPaciente: Integer; pRestaurar: TRestaurar);
var
  lPaciente: TRestaurar;
begin
  try
    if not Lista.TryGetValue(pIDPaciente, lPaciente) then
    begin
      Lista.Add(pIDPaciente, pRestaurar);
      Exit;
    end;

    Lista[pIDPaciente] := pRestaurar;
  finally
    FreeAndNil(lPaciente);
  end;
end;

end.
