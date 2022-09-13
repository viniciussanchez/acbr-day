unit Providers.Auth;

interface

uses Horse;

function BasicAuthorization: THorseCallback;

implementation

uses System.SysUtils, Horse.BasicAuthentication;

function DoBasicAuthentication(const AUsername, APassword: string): Boolean;
begin
  Result := AUsername.Equals('vinicius') and APassword.Equals('123');
end;

function BasicAuthorization: THorseCallback;
begin
  Result := HorseBasicAuthentication(DoBasicAuthentication, THorseBasicAuthenticationConfig.New.SkipRoutes('ping'));
end;

end.
