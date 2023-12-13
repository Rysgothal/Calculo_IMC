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
    procedure lbxHistoricoAlteracoesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lbxHistoricoAlteracoesDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure SelecionarItem;
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
      lPaciente.Key + ' --> ' + lPaciente.Value.Nome + ', ' + lPaciente.Value.Nascimento
    );
  end;

  lbxHistoricoAlteracoes.ItemIndex := 0;
end;

procedure TfrmHistorico.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
  end;
end;

procedure TfrmHistorico.lbxHistoricoAlteracoesDblClick(Sender: TObject);
begin
  SelecionarItem;
end;

procedure TfrmHistorico.lbxHistoricoAlteracoesKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  lItem: Integer;
begin
  lItem := lbxHistoricoAlteracoes.ItemIndex;

  if lItem = -1 then
  begin
    Exit;
  end;

  if Key = VK_RETURN then
  begin
    SelecionarItem;
  end;
end;

procedure TfrmHistorico.SelecionarItem;
var
  lPacientes: TPacientesSingleton;
  lDataHora: string;
begin
  lPacientes := TPacientesSingleton.ObterInstancia;
  lDataHora := lbxHistoricoAlteracoes.Items[lbxHistoricoAlteracoes.ItemIndex];
  lDataHora := Copy(lDataHora, 0, PosEx(' -->', lDataHora) - 1);

  lPacientes.Restaurar(lPacientes.Historico.Recuperar(lDataHora));
  ModalResult := mrOk;
end;

end.
