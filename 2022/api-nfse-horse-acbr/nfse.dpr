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
  Controllers.Ping in 'src\controllers\Controllers.Ping.pas';

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
