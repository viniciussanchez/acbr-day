unit Controllers.Healthcheck;

interface

uses MVCFramework, MVCFramework.Commons, MVCFramework.Serializer.Commons;

type
  [MVCPath('/v1')]
  TControllerHealthcheck = class(TMVCController)
  public
    [MVCPath('/ping')]
    [MVCHTTPMethod([httpGET])]
    procedure GetPing;
  end;

implementation

procedure TControllerHealthcheck.GetPing;
begin
  Render('pong');
end;

end.
