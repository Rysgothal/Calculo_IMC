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
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHistorico: TfrmHistorico;

implementation

uses
  System.StrUtils;

{$R *.dfm}

{ TfrmHistorico }

procedure TfrmHistorico.FormCreate(Sender: TObject);
var
  lPacientes: TPacientesSingleton;
begin
  lPacientes := TPacientesSingleton.ObterInstancia;

  for var lPaciente in lPacientes.Historico.Lista do
  begin
    lbxHistoricoAlteracoes.Items.Add(
      lPaciente.Key.ToString + ' --> ' + lPaciente.Value.Nome + ', ' + lPaciente.Value.Nascimento
    );
  end;

  lbxHistoricoAlteracoes.ItemIndex := 0;
end;

procedure TfrmHistorico.lbxHistoricoAlteracoesClick(Sender: TObject);
var
  lPacientes: TPacientesSingleton;
  lIDPaciente: string;
begin
  lPacientes := TPacientesSingleton.ObterInstancia;
  lIDPaciente := lbxHistoricoAlteracoes.Items[lbxHistoricoAlteracoes.ItemIndex];
  lIDPaciente := Copy(lIDPaciente, 0, PosEx(' -->', lIDPaciente) - 1);

  lPacientes.Restaurar(lPacientes.Historico.Recuperar(lIDPaciente.ToInteger));

  ModalResult := mrOk;
end;

end.
