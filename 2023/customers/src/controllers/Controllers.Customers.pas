unit Controllers.Customers;

interface

uses MVCFramework, MVCFramework.Commons, MVCFramework.Serializer.Commons;

type
  [MVCPath('/v1')]
  TControllerCustomers = class(TMVCController)
  public
    [MVCPath('/customers')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomers;
  end;

implementation

procedure TControllerCustomers.GetCustomers;
begin
  Context.Response.ContentType := 'application/json';
  Render('[]');
end;

end.
