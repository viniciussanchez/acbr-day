unit Providers.Authorization;

interface

uses Horse, Horse.JWT;

function Authorization: THorseCallback;

implementation

function Authorization: THorseCallback; overload;
const
  SECRET_KEY = 'my_very_long_and_safe_secret_key'; // Pegar de uma variável de ambiente ou arquivo
  SKIP_ROUTES = '/v1/ping';
begin
  Result := HorseJWT(SECRET_KEY, THorseJWTConfig.New.SkipRoutes(SKIP_ROUTES));
end;

end.
