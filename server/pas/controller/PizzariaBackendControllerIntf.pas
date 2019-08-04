{ Invokable interface IPizzariaBackend }

unit PizzariaBackendControllerIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, UPizzaTamanhoEnum,
  UPizzaSaborEnum, UPedidoRetornoDTOImpl;

type

  TEnumTest = (etNone, etAFew, etSome, etAlot);

  TDoubleArray = array of Double;

  TMyEmployee = class(TRemotable)
  private
    FLastName: UnicodeString;
    FFirstName: UnicodeString;
    FSalary: Double;
  published
    property LastName: UnicodeString read FLastName write FLastName;
    property FirstName: UnicodeString read FFirstName write FFirstName;
    property Salary: Double read FSalary write FSalary;
  end;

  { Invokable interfaces must derive from IInvokable }
  IPizzariaBackendController = interface(IInvokable)
    ['{D376B504-187F-4B02-B95E-50ABFB0AAC85}']
    function efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const ADocumentoCliente: String): TPedidoRetornoDTO; stdcall;
  end;

implementation

initialization

{ Invokable interfaces must be registered }
InvRegistry.RegisterInterface(TypeInfo(IPizzariaBackendController));

end.
