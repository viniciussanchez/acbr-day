unit Controllers.Ping;

interface

implementation

uses Horse;

procedure DoPing(Req: THorseRequest; Res: THorseResponse);
begin
  Res.Send('pong');
end;

procedure Registry;
begin
  THorse.Get('/ping', DoPing);
end;

initialization
  Registry;

end.
