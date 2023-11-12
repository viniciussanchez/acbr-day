unit Services.Auth;

interface

uses System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client;

type
  TServiceAuth = class(TDataModule)
    FDConnection: TFDConnection;
  public
    function IsValidUser(const AUsername, APassword: string): Boolean;
    function GetAccessToken: string;
  end;

implementation

{$R *.dfm}

uses JOSE.Core.JWT, JOSE.Core.Builder, System.DateUtils;

function TServiceAuth.GetAccessToken: string;
var
  LToken: TJWT;
begin
  LToken := TJWT.Create;
  try
    // Token claims
    LToken.Claims.Issuer := 'Fiorilli S/C Software';
    LToken.Claims.Subject := '15846';
    LToken.Claims.Expiration := IncDay(Now, 1);
    LToken.Claims.IssuedAt := Now;
    LToken.Claims.NotBefore := Now;

    // Outros claims
    LToken.Claims.SetClaimOfType<string>('username', 'vinicius.sanchez');
    LToken.Claims.SetClaimOfType<string>('firstName', 'Vinicius');
    LToken.Claims.SetClaimOfType<string>('lastName', 'Sanchez');
    LToken.Claims.SetClaimOfType<Boolean>('mvp', True);
    LToken.Claims.SetClaimOfType<Integer>('age', 28);

    // Signing and Compact format creation
    Result := TJOSE.SHA256CompactToken('my_very_long_and_safe_secret_key', LToken);
  finally
    LToken.Free;
  end;
end;

function TServiceAuth.IsValidUser(const AUsername, APassword: string): Boolean;
begin
  // Acessar o banco de dados para validar o usuário e senha
  Result := AUsername.Trim.ToLower.Equals('vinicius') and APassword.Trim.Equals('123');
end;

end.
