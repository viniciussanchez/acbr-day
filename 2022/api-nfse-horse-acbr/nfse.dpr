program nfse;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.HandleException,
  Horse.Logger,
  Horse.Logger.Provider.Console,
  System.JSON,
  System.SysUtils,
  Providers.Auth in 'src\providers\Providers.Auth.pas',
  Providers.Connection in 'src\providers\Providers.Connection.pas' {ProviderConnection: TDataModule},
  Controllers.Ping in 'src\controllers\Controllers.Ping.pas',
  Controllers.NFSe in 'src\controllers\Controllers.NFSe.pas',
  Controllers.RPS in 'src\controllers\Controllers.RPS.pas',
  Controllers.Token in 'src\controllers\Controllers.Token.pas',
  Providers.NFSe in 'src\providers\Providers.NFSe.pas' {ProviderNFSe: TDataModule},
  Services.NFSe in 'src\services\Services.NFSe.pas' {ServiceNFSe: TDataModule},
  Services.RPS in 'src\services\Services.RPS.pas' {ServiceRPS: TDataModule},
  Services.Token in 'src\services\Services.Token.pas' {ServiceToken: TDataModule};

begin
  THorseLoggerManager
    .RegisterProvider(THorseLoggerProviderConsole.New());

  THorse
    .Use(Jhonson)
    .Use(HandleException)
    .Use(THorseLoggerManager.HorseCallback)
    .Use(BasicAuthorization);

  THorse.Listen(9000,
    procedure(Horse: THorse)
    begin
      Writeln('API para emisssão de NFSe com Horse e ACBr');
      Writeln('Rodando na porta ' + Horse.Port.ToString);
    end);
end.
