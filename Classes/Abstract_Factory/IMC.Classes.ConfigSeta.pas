unit IMC.Classes.ConfigSeta;

interface

uses
  IMC.Interfaces.AbstractFactory, System.UITypes;

type
  { Abstract Factory }
  TSetaNaoCalculado = class(TInterfacedObject, ISetaConfiguracao)
  private
    function PosicaoSeta: Word;
    function CorSeta: TColor;
  end;

  { Abstract Factory }
  TSetaAbaixoPeso = class(TInterfacedObject, ISetaConfiguracao)
  private
    function PosicaoSeta: Word;
    function CorSeta: TColor;
  end;

  { Abstract Factory }
  TSetaPesoIdeal = class(TInterfacedObject, ISetaConfiguracao)
  private
    function PosicaoSeta: Word;
    function CorSeta: TColor;
  end;

  { Abstract Factory }
  TSetaPoucoAcimaPeso = class(TInterfacedObject, ISetaConfiguracao)
  private
    function PosicaoSeta: Word;
    function CorSeta: TColor;
  end;

  { Abstract Factory }
  TSetaAcimaPeso = class(TInterfacedObject, ISetaConfiguracao)
  private
    function PosicaoSeta: Word;
    function CorSeta: TColor;
  end;

  { Abstract Factory }
  TSetaObeso = class(TInterfacedObject, ISetaConfiguracao)
  private
    function PosicaoSeta: Word;
    function CorSeta: TColor;
  end;

implementation

uses
  Vcl.Graphics;

{ TSetaNaoCalculado }

function TSetaNaoCalculado.CorSeta: TColor;
begin
  Result := clWindowText;
end;

function TSetaNaoCalculado.PosicaoSeta: Word;
begin
  Result := 375;
end;

{ TSetaAbaixoPeso }

function TSetaAbaixoPeso.CorSeta: TColor;
begin
  Result := $00D1B499;
end;

function TSetaAbaixoPeso.PosicaoSeta: Word;
begin
  Result := 80;
end;

{ TSetaPesoIdeal }

function TSetaPesoIdeal.CorSeta: TColor;
begin
  Result := $00C0DCC0;
end;

function TSetaPesoIdeal.PosicaoSeta: Word;
begin
  Result := 229;
end;

{ TSetaPoucoAcimaPeso }

function TSetaPoucoAcimaPeso.CorSeta: TColor;
begin
  Result := $00BBFFFF;
end;

function TSetaPoucoAcimaPeso.PosicaoSeta: Word;
begin
  Result := 375;
end;

{ TSetaAcimaPeso }

function TSetaAcimaPeso.CorSeta: TColor;
begin
  Result := $008CC6FF;
end;

function TSetaAcimaPeso.PosicaoSeta: Word;
begin
  Result := 526;
end;

{ TSetaObeso }

function TSetaObeso.CorSeta: TColor;
begin
  Result := $007D7DFF;
end;

function TSetaObeso.PosicaoSeta: Word;
begin
  Result := 673;
end;

end.
