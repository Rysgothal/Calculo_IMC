unit IMC.Frames.ResultadoIMC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  IMC.Helpers.TiposAuxiliares, IMC.Interfaces.Observer,
  IMC.Interfaces.AbstractFactory, IMC.Interfaces.FabricaShapeCores;

type
  TfrmResultadoIMC = class(TFrame, IObserver)
    gbxResultado: TGroupBox;
    shpAbaixoPeso: TShape;
    shpPesoIdeal: TShape;
    shpPoucoAcima: TShape;
    shpAcimaPeso: TShape;
    shpObesidade: TShape;
    lblAbaixoPeso: TLabel;
    lblPesoIdeal: TLabel;
    lblPoucoAcima: TLabel;
    lblAcimaPeso: TLabel;
    lblObesidade: TLabel;
    lblSetaBottom: TLabel;
    lblSetaTop: TLabel;
  private
    procedure HabilitarShapes(pHabilitar: Boolean);
    procedure HabilitarComponentesResultado(pHabilitar: Boolean);
    procedure MoverSetas(pStatusIMC: TStatusIMC);
    procedure ConfigurarPainelResultado(pConfigSeta: TConfig);
    { Private declarations }
  public
    procedure Atualizar(pStatusIMC: TStatusIMC);
    { Public declarations }
  end;

implementation

uses
  IMC.Classes.ConsultarSeta, IMC.Classes.FabricaShapeCor,
  IMC.Interfaces.CoresShape;

{$R *.dfm}

{ TfrmResultadoIMC }

procedure TfrmResultadoIMC.Atualizar(pStatusIMC: TStatusIMC);
var
  lHabilitar: Boolean;
begin
  lHabilitar := pStatusIMC <> siNaoCalculado;

  HabilitarComponentesResultado(lHabilitar);
  MoverSetas(pStatusIMC);
end;

procedure TfrmResultadoIMC.ConfigurarPainelResultado(pConfigSeta: TConfig);
begin
  lblSetaBottom.Left := pConfigSeta.PosicaoSeta;
  lblSetaBottom.Font.Color := pConfigSeta.CorShape;
  lblSetaTop.Left := pConfigSeta.PosicaoSeta;
  lblSetaTop.Font.Color := pConfigSeta.CorShape;
end;

procedure TfrmResultadoIMC.HabilitarComponentesResultado(pHabilitar: Boolean);
begin
  lblAbaixoPeso.Enabled := pHabilitar;
  lblPesoIdeal.Enabled := pHabilitar;
  lblPoucoAcima.Enabled := pHabilitar;
  lblAcimaPeso.Enabled := pHabilitar;
  lblObesidade.Enabled := pHabilitar;
  lblSetaBottom.Visible := pHabilitar;
  lblSetaTop.Visible := pHabilitar;

  HabilitarShapes(pHabilitar);
end;

procedure TfrmResultadoIMC.HabilitarShapes(pHabilitar: Boolean);
var
  lFabricaCores: TFabricaConfiguracaoResultado;
  lCores: IConfiguracaoResultado;
begin
  lFabricaCores := TFabricaConfiguracaoResultado.Create;

  try
    lCores := lFabricaCores.ConsultarConfiguracaoResultado(pHabilitar);

    shpAbaixoPeso.Brush.Color := lCores.ConfigAbaixoPeso.CorShape;
    shpPesoIdeal.Brush.Color := lCores.ConfigPesoIdeal.CorShape;
    shpPoucoAcima.Brush.Color := lCores.ConfigPoucoAcimaPeso.CorShape;
    shpAcimaPeso.Brush.Color := lCores.ConfigAcimaPeso.CorShape;
    shpObesidade.Brush.Color := lCores.ConfigObeso.CorShape;
  finally
    FreeAndNil(lFabricaCores);
  end;
end;

procedure TfrmResultadoIMC.MoverSetas(pStatusIMC: TStatusIMC);
var
  lFabricaCores: TFabricaConfiguracaoResultado;
  lCores: IConfiguracaoResultado;
  lConfiguracao: TConfig;
begin
  lFabricaCores := TFabricaConfiguracaoResultado.Create;

  try
    lCores := lFabricaCores.ConsultarConfiguracaoResultado(pStatusIMC <> siNaoCalculado);

    case pStatusIMC of
      siAbaixo: lConfiguracao := lCores.ConfigAbaixoPeso;
      siIdeal: lConfiguracao := lCores.ConfigPesoIdeal;
      siPoucoAcima: lConfiguracao := lCores.ConfigPoucoAcimaPeso;
      siAcima: lConfiguracao := lCores.ConfigAcimaPeso;
      siObeso: lConfiguracao := lCores.ConfigObeso;
    end;

    ConfigurarPainelResultado(lConfiguracao);
  finally
    FreeAndNil(lFabricaCores);
  end;
end;

end.
