program security;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  Horse.Jhonson, // It's necessary to use the unit
  Horse.HandleException, // It's necessary to use the unit
  System.SysUtils,
  Services.Auth in 'src\services\Services.Auth.pas' {ServiceAuth: TDataModule},
  Controllers.Auth in 'src\controllers\Controllers.Auth.pas';

begin
  THorse.Routes.Prefix('v1');

  THorse
    .Use(Jhonson) // It has to be before the exceptions middleware
    .Use(HandleException);

  Controllers.Auth.Registry;

  THorse.Listen(9000,
    procedure
    begin
      Writeln('Security is running on port ' + THorse.Port.ToString);
    end);
end.
