unit IMC.Classes.ShapeCores;

interface

uses
  IMC.Interfaces.CoresShape, System.UITypes, IMC.Helpers.TiposAuxiliares;

type
  { Factory Method }
  TShapeHabilitado = class(TInterfacedObject, IConfiguracaoResultado)
  public
    function ConfigAbaixoPeso: TConfig;
    function ConfigPesoIdeal: TConfig;
    function ConfigPoucoAcimaPeso: TConfig;
    function ConfigAcimaPeso: TConfig;
    function ConfigObeso: TConfig;
  end;

  { Factory Method }
  TShapeDesabilitado = class(TInterfacedObject, IConfiguracaoResultado)
  public
    function ConfigAbaixoPeso: TConfig;
    function ConfigPesoIdeal: TConfig;
    function ConfigPoucoAcimaPeso: TConfig;
    function ConfigAcimaPeso: TConfig;
    function ConfigObeso: TConfig;
  const
    POSICAO_SETA_DESABILITADA = 375;
  end;

implementation

{ TShapeHabilitado }

function TShapeHabilitado.ConfigAbaixoPeso: TConfig;
begin
  Result.CorShape := $00D1B499;
  Result.PosicaoSeta := 80;
end;

function TShapeHabilitado.ConfigAcimaPeso: TConfig;
begin
  Result.CorShape := $008CC6FF;
  Result.PosicaoSeta := 526;
end;

function TShapeHabilitado.ConfigObeso: TConfig;
begin
  Result.CorShape := $007D7DFF;
  Result.PosicaoSeta := 673;
end;

function TShapeHabilitado.ConfigPesoIdeal: TConfig;
begin
  Result.CorShape := $00C0DCC0;
  Result.PosicaoSeta := 229;
end;

function TShapeHabilitado.ConfigPoucoAcimaPeso: TConfig;
begin
  Result.CorShape := $00BBFFFF;
  Result.PosicaoSeta := 375;
end;

{ TShapeDesabilitado }

function TShapeDesabilitado.ConfigAbaixoPeso: TConfig;
begin
  Result.CorShape := $00E6E6E6;
  Result.PosicaoSeta := POSICAO_SETA_DESABILITADA;
end;

function TShapeDesabilitado.ConfigAcimaPeso: TConfig;
begin
  Result.CorShape := $00BCBCBC;
  Result.PosicaoSeta := POSICAO_SETA_DESABILITADA;
end;

function TShapeDesabilitado.ConfigObeso: TConfig;
begin
  Result.CorShape := $00A8A8A8;
  Result.PosicaoSeta := POSICAO_SETA_DESABILITADA;
end;

function TShapeDesabilitado.ConfigPesoIdeal: TConfig;
begin
  Result.CorShape := $00D7D7D7;
  Result.PosicaoSeta := POSICAO_SETA_DESABILITADA;
end;

function TShapeDesabilitado.ConfigPoucoAcimaPeso: TConfig;
begin
  Result.CorShape := $00C9C9C9;
  Result.PosicaoSeta := POSICAO_SETA_DESABILITADA;
end;

end.
