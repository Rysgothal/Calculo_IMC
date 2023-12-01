unit IMC.Frames.ResultadoIMC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  IMC.Helpers.Enumerados, IMC.Interfaces.Observer;

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
    procedure ConfigurarPainelResultado(pPosSetas: Integer; pCorSeta: TColor);
    { Private declarations }
  public
    procedure Atualizar(pStatusIMC: TStatusIMC);
    { Public declarations }
  end;

implementation

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
begin
  shpAbaixoPeso.Brush.Color := $00E6E6E6;
  shpPesoIdeal.Brush.Color := $00D7D7D7;
  shpPoucoAcima.Brush.Color := $00C9C9C9;
  shpAcimaPeso.Brush.Color := $00BCBCBC;            // abstract factory
  shpObesidade.Brush.Color := $00A8A8A8;

  if pHabilitar then
  begin
    shpAbaixoPeso.Brush.Color := $00D1B499;
    shpPesoIdeal.Brush.Color := $00C0DCC0;
    shpPoucoAcima.Brush.Color := $00BBFFFF;
    shpAcimaPeso.Brush.Color := $008CC6FF;
    shpObesidade.Brush.Color := $007D7DFF;
  end;
end;

procedure TfrmResultadoIMC.MoverSetas(pStatusIMC: TStatusIMC);
begin
  case pStatusIMC of
    siAbaixo: ConfigurarPainelResultado(80, $00D1B499);
    siIdeal: ConfigurarPainelResultado(229, $00C0DCC0);
    siPoucoAcima: ConfigurarPainelResultado(375, $00BBFFFF);
    siAcima: ConfigurarPainelResultado(526, $008CC6FF);
    siObeso: ConfigurarPainelResultado(673, $007D7DFF);
  end;
end;

procedure TfrmResultadoIMC.ConfigurarPainelResultado(pPosSetas: Integer; pCorSeta: TColor);
begin
  lblSetaBottom.Left := pPosSetas;
  lblSetaBottom.Font.Color := pCorSeta;
  lblSetaTop.Left := pPosSetas;
  lblSetaTop.Font.Color := pCorSeta;
end;

end.
