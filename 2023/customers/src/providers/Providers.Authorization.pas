unit Providers.Authorization;

interface

uses MVCFramework.Commons, MVCFramework, System.Generics.Collections;

type
  TCustomAuth = class(TInterfacedObject, IMVCAuthenticationHandler)
  public
    // called at each request to know if the request requires an authentication
    procedure OnRequest(const AContext: TWebContext; const ControllerQualifiedClassName: string; const ActionName: string;
      var AuthenticationRequired: Boolean);

    // if authentication is required, this method must execute the user authentication
    procedure OnAuthentication(const AContext: TWebContext; const UserName: string; const Password: string;
      UserRoles: TList<System.string>; var IsValid: Boolean;
      const SessionData: System.Generics.Collections.TDictionary<System.string, System.string>);

    // if authenticated, this method defines the user roles
    procedure OnAuthorization(const AContext: TWebContext; UserRoles: System.Generics.Collections.TList<System.string>;
      const ControllerQualifiedClassName: string; const ActionName: string; var IsAuthorized: Boolean);
  end;

implementation

uses System.SysUtils;

{ TCustomAuth }

procedure TCustomAuth.OnAuthentication(const AContext: TWebContext; const UserName: string; const Password: string;
  UserRoles: TList<System.string>; var IsValid: Boolean;
  const SessionData: System.Generics.Collections.TDictionary<System.string, System.string>);
begin
  IsValid := True;
end;

procedure TCustomAuth.OnAuthorization(const AContext: TWebContext; UserRoles: System.Generics.Collections.TList<System.string>;
  const ControllerQualifiedClassName: string; const ActionName: string; var IsAuthorized: Boolean);
begin
  IsAuthorized := True;
end;

procedure TCustomAuth.OnRequest(const AContext: TWebContext; const ControllerQualifiedClassName: string; const ActionName: string;
  var AuthenticationRequired: Boolean);
begin
  AuthenticationRequired := not ((ControllerQualifiedClassName = 'Controllers.Healthcheck.TControllerHealthcheck') and (ActionName = 'GetPing'));
end;

end.
