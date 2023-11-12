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
  // Não precisa destruir. O Horse que destroi o que está no body.
  LBody := Req.Body<TJSONObject>;

  // Valida se o usuário informou os dados. Caso contrário retorna Bad Request.
  if not Assigned(LBody) then
    raise EHorseException.New.Error('Informe o usuário e senha!').Status(THTTPStatus.BadRequest);
  if not LBody.TryGetValue<string>('username', LUsername) then
    raise EHorseException.New.Error('Informe o usuário!').Status(THTTPStatus.BadRequest);
  if not LBody.TryGetValue<string>('password', LPassword) then
    raise EHorseException.New.Error('Informe a senha!').Status(THTTPStatus.BadRequest);

  // Sempre o que criar tem que destruir, exceto o que vai no response
  LService := TServiceAuth.Create(nil);
  try
    // Se não tiver autorizado, retorna o status code 401
    if not LService.IsValidUser(LUsername, LPassword) then
      raise EHorseException.New.Error('Credenciais inválidas!').Status(THTTPStatus.Unauthorized);

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
