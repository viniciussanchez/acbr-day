program projeto;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.HandleException,
  System.SysUtils,
  Controllers.Ping in 'src\controllers\Controllers.Ping.pas',
  Controllers.NFe in 'src\controllers\Controllers.NFe.pas',
  Services.NFe in 'src\services\Services.NFe.pas' {ServiceNFe: TDataModule};

begin
  THorse
    .Use(Jhonson)
    .Use(HandleException);

  THorse.Listen(9000,
    procedure
    begin
      Writeln('Server is running on port ' + THorse.Port.ToString);
    end);
end.
