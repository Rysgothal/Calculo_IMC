unit IMC.Helpers.TiposAuxiliares;

interface

uses
  Vcl.Graphics;

type
  { Enumerados }
  TSexoPaciente = (spNaoInformado = -1, spFeminino, spMasculino);
  TStatusIMC = (siNaoCalculado = -1, siAbaixo, siIdeal, siPoucoAcima, siAcima, siObeso);

  { Records }
  TConfig = record
    PosicaoSeta: Integer;
    CorShape: TColor;
  end;

implementation

end.
