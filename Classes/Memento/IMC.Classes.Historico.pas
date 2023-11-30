unit IMC.Classes.Historico;

interface

uses
  System.SysUtils, IMC.Classes.Restaurar, System.Generics.Collections;


type
  THistorico = class
  private
    FLista: TObjectDictionary<string, TRestaurar>;
  public
    property Lista: TObjectDictionary<string, TRestaurar> read FLista write FLista;
    constructor Create;
    destructor Destroy; override;
    procedure Adicionar(const pDataHora: string; pRestaurar: TRestaurar);
    function Recuperar(const pDataHora: string): TRestaurar;
  end;

implementation


{ THistorico }

constructor THistorico.Create;
begin
  FLista := TObjectDictionary<string, TRestaurar>.Create([doOwnsValues]);
end;

destructor THistorico.Destroy;
begin
  FreeAndNil(FLista);
  inherited;
end;

function THistorico.Recuperar(const pDataHora: string): TRestaurar;
begin
  Result := Lista.Items[pDataHora];
end;

procedure THistorico.Adicionar(const pDataHora: string; pRestaurar: TRestaurar);
begin
  Lista.Add(pDataHora, pRestaurar);
end;

end.
