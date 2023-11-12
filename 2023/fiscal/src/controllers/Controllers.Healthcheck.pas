unit Controllers.Healthcheck;

interface

procedure Registry;

implementation

uses Horse;

procedure DoHealthcheck(Res: THorseResponse);
begin
  Res.Send('pong');
end;

procedure Registry;
begin
  THorse.Get('/ping', DoHealthcheck);
end;

end.
