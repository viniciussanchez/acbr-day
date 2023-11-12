unit Controllers.Auth;

interface

procedure Registry;

implementation

uses Horse, Services.Auth, System.JSON;

procedure DoLogin(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceAuth;
  LUsername, LPassword: string;
  LBody: TJSONObject;
begin
  // N�o precisa destruir. O Horse que destroi o que est� no body.
  LBody := Req.Body<TJSONObject>;

  // Valida se o usu�rio informou os dados. Caso contr�rio retorna Bad Request.
  if not Assigned(LBody) then
    raise EHorseException.New.Error('Informe o usu�rio e senha!').Status(THTTPStatus.BadRequest);
  if not LBody.TryGetValue<string>('username', LUsername) then
    raise EHorseException.New.Error('Informe o usu�rio!').Status(THTTPStatus.BadRequest);
  if not LBody.TryGetValue<string>('password', LPassword) then
    raise EHorseException.New.Error('Informe a senha!').Status(THTTPStatus.BadRequest);

  // Sempre o que criar tem que destruir, exceto o que vai no response
  LService := TServiceAuth.Create(nil);
  try
    // Se n�o tiver autorizado, retorna o status code 401
    if not LService.IsValidUser(LUsername, LPassword) then
      raise EHorseException.New.Error('Credenciais inv�lidas!').Status(THTTPStatus.Unauthorized);

    // Gera e devolve o token
    Res.Send<TJSONObject>(TJSONObject.Create.AddPair('token', LService.GetAccessToken));
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Post('/login', DoLogin);
end;

end.
