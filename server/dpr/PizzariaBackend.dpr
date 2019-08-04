program PizzariaBackend;
{$APPTYPE GUI}
{$R *.dres}

uses
  Vcl.Forms,
  Web.WebReq,
  System.SysUtils,
  Winapi.Windows,
  System.Classes,
  FireDAC.Stan.Def,
  FireDAC.Phys.SQLite,
  FireDAC.DApt,
  FireDAC.Stan.Async,
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf,
  FireDAC.Comp.UI,
  IdHTTPWebBrokerBridge,
  UFrmPrincipalImpl in '..\pas\ui\UFrmPrincipalImpl.pas' {Form1},
  WMPizzariaBackend in '..\pas\wm\WMPizzariaBackend.pas' {WebModule1: TWebModule},
  PizzariaBackendControllerImpl in '..\pas\controller\PizzariaBackendControllerImpl.pas',
  PizzariaBackendControllerIntf in '..\pas\controller\PizzariaBackendControllerIntf.pas',
  UPedidoServiceIntf in '..\pas\service\UPedidoServiceIntf.pas',
  UPedidoServiceImpl in '..\pas\service\UPedidoServiceImpl.pas',
  UPedidoRepositoryIntf in '..\pas\repository\UPedidoRepositoryIntf.pas',
  UPedidoRepositoryImpl in '..\pas\repository\UPedidoRepositoryImpl.pas',
  UDBConnectionIntf in '..\pas\db-connection\UDBConnectionIntf.pas',
  UDBConnectionImpl in '..\pas\db-connection\UDBConnectionImpl.pas',
  UClienteRepositoryIntf in '..\pas\repository\UClienteRepositoryIntf.pas',
  UClienteRepositoryImpl in '..\pas\repository\UClienteRepositoryImpl.pas',
  UClienteServiceIntf in '..\pas\service\UClienteServiceIntf.pas',
  UClienteServiceImpl in '..\pas\service\UClienteServiceImpl.pas',
  UPedidoRetornoDTOImpl in '..\..\shared\pas\dto\UPedidoRetornoDTOImpl.pas',
  UPizzaSaborEnum in '..\..\shared\pas\enum\UPizzaSaborEnum.pas',
  UPizzaTamanhoEnum in '..\..\shared\pas\enum\UPizzaTamanhoEnum.pas';

{$R *.res}

procedure initDB();
var
  oSQL: TStringList;
  oSQLResource: TResourceStream;
begin
  if (not DirectoryExists(GetCurrentDir + PathDelim + 'db')) then
    CreateDir(GetCurrentDir + PathDelim + 'db');

  if (not FileExists(GetCurrentDir + PathDelim + 'db' + PathDelim + 'pizzaria.s3db')) then
    FileCreate(GetCurrentDir + PathDelim + 'db' + PathDelim + 'pizzaria.s3db');

  oSQLResource := TResourceStream.Create(HInstance, 'DB_INIT', RT_RCDATA);
  try
    with TDBConnection.Create do
      try
        oSQL := TStringList.Create;
        try
          oSQL.LoadFromStream(oSQLResource);
          getDefaultConnection.ExecSQL(oSQL.Text);
        finally
          oSQL.Free;
        end;
      finally
        Free;
      end;
  finally
    oSQLResource.Free;
  end;
end;

begin
  initDB();
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
