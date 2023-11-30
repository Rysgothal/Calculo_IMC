unit IMC.Forms.Historico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IMC.Classes.Paciente;

type
  TfrmHistorico = class(TForm)
    lbxHistoricoAlteracoes: TListBox;
    lblHistoricoAlteracoes: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure lbxHistoricoAlteracoesClick(Sender: TObject);
  private
    FPacientes: TPacientes;
    { Private declarations }
  public
    constructor Create(var pPacientes: TPacientes); reintroduce; overload;
    { Public declarations }
  end;

var
  frmHistorico: TfrmHistorico;

implementation

uses
  System.StrUtils;

{$R *.dfm}

{ TfrmHistorico }

constructor TfrmHistorico.Create(var pPacientes: TPacientes);
begin
  inherited Create(Owner);
  FPacientes := pPacientes;
end;

procedure TfrmHistorico.FormCreate(Sender: TObject);
begin
  for var lPaciente in FPacientes.Historico.Lista do
  begin
    lbxHistoricoAlteracoes.Items.Add(lPaciente.Key + ' --> ' + lPaciente.Value.Nome + ', ' + lPaciente.Value.Nascimento);
  end;

  lbxHistoricoAlteracoes.ItemIndex := 0;
end;

procedure TfrmHistorico.lbxHistoricoAlteracoesClick(Sender: TObject);
var
  lDataHora: string;
begin
  lDataHora := lbxHistoricoAlteracoes.Items[lbxHistoricoAlteracoes.ItemIndex];
  lDataHora := Copy(lDataHora, 0, PosEx(' -->', lDataHora) - 1);
  FPacientes.Restaurar(FPacientes.Historico.Recuperar(lDataHora));

  Close;
end;

end.
