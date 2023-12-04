unit IMC.Frames.ResultadoIMC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  IMC.Helpers.Enumerados, IMC.Interfaces.Observer,
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
    procedure ConfigurarPainelResultado(pConfigSeta: ISetaConfiguracao);
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
begin
  case pStatusIMC of
    siNaoCalculado: HabilitarComponentesResultado(False);
    else HabilitarComponentesResultado(True);
  end;

  MoverSetas(pStatusIMC);
end;

procedure TfrmResultadoIMC.ConfigurarPainelResultado(pConfigSeta: ISetaConfiguracao);
begin
  lblSetaBottom.Left := pConfigSeta.PosicaoSeta;
  lblSetaBottom.Font.Color := pConfigSeta.CorSeta;
  lblSetaTop.Left := pConfigSeta.PosicaoSeta;
  lblSetaTop.Font.Color := pConfigSeta.CorSeta;
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
  lFabricaCores: TFabricaShapeCor;
  lCores: IShapeCor;
begin
  lFabricaCores := TFabricaShapeCor.Create;

  try
    lCores := lFabricaCores.ConsultarCorShape(pHabilitar);

    shpAbaixoPeso.Brush.Color := lCores.CorAbaixoPeso;
    shpPesoIdeal.Brush.Color := lCores.CorPesoIdeal;
    shpPoucoAcima.Brush.Color := lCores.CorPoucoAcimaPeso;
    shpAcimaPeso.Brush.Color := lCores.CorAcimaPeso;
    shpObesidade.Brush.Color := lCores.CorObeso;
  finally
    FreeAndNil(lFabricaCores);
  end;
end;

procedure TfrmResultadoIMC.MoverSetas(pStatusIMC: TStatusIMC);
var
  lStatus: IFabricaStatusIMC;
begin
  case pStatusIMC of
    siAbaixo: lStatus := TAbaixoPeso.Create;
    siIdeal: lStatus := TPesoIdeal.Create;
    siPoucoAcima: lStatus := TPoucoAcimaPeso.Create;
    siAcima: lStatus := TAcimaPeso.Create;
    siObeso: lStatus := TObeso.Create;
    else lStatus := TNaoCalculado.Create;
  end;

  ConfigurarPainelResultado(lStatus.ConsultarConfSeta);
end;

end.
