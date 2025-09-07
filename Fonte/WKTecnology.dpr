program WKTecnology;

uses
  Vcl.Forms,
  UFormPrincipal in 'UFormPrincipal.pas' {FormPrincipal},
  Vcl.Themes,
  Vcl.Styles,
  DataModule.Global in 'DataBase\DataModule.Global.pas' {Dmbase: TDataModule},
  DataSet.Serialize.Config in 'Funcoes\DataSet.Serialize.Config.pas',
  DataSet.Serialize.Consts in 'Funcoes\DataSet.Serialize.Consts.pas',
  DataSet.Serialize.Export in 'Funcoes\DataSet.Serialize.Export.pas',
  DataSet.Serialize.Import in 'Funcoes\DataSet.Serialize.Import.pas',
  DataSet.Serialize.Language in 'Funcoes\DataSet.Serialize.Language.pas',
  DataSet.Serialize in 'Funcoes\DataSet.Serialize.pas',
  DataSet.Serialize.UpdatedStatus in 'Funcoes\DataSet.Serialize.UpdatedStatus.pas',
  DataSet.Serialize.Utils in 'Funcoes\DataSet.Serialize.Utils.pas',
  MyUntFunctions in 'Funcoes\MyUntFunctions.pas',
  UntINIfileManager in 'Funcoes\UntINIfileManager.pas',
  UFormCadPadrao in 'Foms\Modelo\UFormCadPadrao.pas' {FormCadPadrao},
  uFrmModelo in 'Foms\Modelo\uFrmModelo.pas' {FrmModelo},
  UFormCadPadraoCliente in 'Foms\Cadastros\UFormCadPadraoCliente.pas' {FormCadPadraoCliente},
  UFormCadPadraoPedido in 'Foms\Cadastros\UFormCadPadraoPedido.pas' {FormCadPadraoPedido},
  UFormCadPadraoProduto in 'Foms\Cadastros\UFormCadPadraoProduto.pas' {FormCadPadraoProduto},
  UFrmListarClientes in 'Foms\Consulta\UFrmListarClientes.pas' {FrmListarClientes},
  UFrmListarPedidos in 'Foms\Consulta\UFrmListarPedidos.pas' {FrmListarPedidos},
  UFrmListarProdutos in 'Foms\Consulta\UFrmListarProdutos.pas' {FrmListarProdutos},
  UFormConfig in 'Foms\Auxiliar\UFormConfig.pas' {FormConfig},
  UFormAddProdutoPed in 'Foms\Auxiliar\UFormAddProdutoPed.pas' {FormAddProdutoPed},
  UFormEditarItemPedido in 'Foms\Auxiliar\UFormEditarItemPedido.pas' {FormEditarItemPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TDmbase, Dmbase);
  Application.Run;
end.
