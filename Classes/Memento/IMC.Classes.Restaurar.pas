unit IMC.Classes.Restaurar;

interface

uses
  IMC.Helpers.Enumerados;

type
  { Memento }
  TRestaurar = class
  private
    FNome: string;
    FNascimento: string;
    FPeso: string;
    FAltura: string;
    FStatusIMC: TStatusIMC;
    FMediaIMC: Single;
    FIdade: string;
    FSexo: TSexoPaciente;
    FID: Integer;
  public
    property Nome: string read FNome write FNome;
    property Nascimento: string read FNascimento write FNascimento;
    property Idade: string read FIdade write FIdade;
    property Peso: string read FPeso write FPeso;
    property Altura: string read FAltura write FAltura;
    property StatusIMC: TStatusIMC read FStatusIMC write FStatusIMC;
    property MediaIMC: Single read FMediaIMC write FMediaIMC;
    property Sexo: TSexoPaciente read FSexo write FSexo;
    property ID: Integer read FID write FID;
  end;


implementation

end.
