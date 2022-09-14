unit Controllers.Token;

interface

implementation

uses Horse, Services.Token, REST.Json, System.JSON;

procedure DoGetToken(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceToken;
begin
  LService := TServiceToken.Create;
  try
    Res.Send<TJSONObject>(TJson.ObjectToJsonObject(LService.Gerar));
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/token', DoGetToken);
end;

initialization
  Registry;

end.
