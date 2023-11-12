program fiscal;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  Horse.Jhonson, // It's necessary to use the unit
  Horse.HandleException, // It's necessary to use the unit
  System.SysUtils,
  Controllers.NotaFiscalEletronica in 'src\controllers\Controllers.NotaFiscalEletronica.pas',
  Services.NotaFiscalEletronica in 'src\services\Services.NotaFiscalEletronica.pas' {ServiceNotaFiscalEletronica: TDataModule},
  Controllers.Healthcheck in 'src\controllers\Controllers.Healthcheck.pas',
  Controllers.NotaFiscalServicoEletronica in 'src\controllers\Controllers.NotaFiscalServicoEletronica.pas',
  Controllers.ConhecimentoTransporteEletronico in 'src\controllers\Controllers.ConhecimentoTransporteEletronico.pas',
  Services.ConhecimentoTransporteEletronico in 'src\services\Services.ConhecimentoTransporteEletronico.pas' {ServiceConhecimentoTransporteEletronico: TDataModule},
  Services.NotaFiscalServicoEletronica in 'src\services\Services.NotaFiscalServicoEletronica.pas' {ServiceNotaFiscalServicoEletronica: TDataModule},
  Providers.Authorization in 'src\providers\Providers.Authorization.pas';

begin
  THorse.Routes.Prefix('v1');

  THorse
    .Use(Jhonson) // It has to be before the exceptions middleware
    .Use(HandleException)
    .Use(Authorization);

  Controllers.ConhecimentoTransporteEletronico.Registry;
  Controllers.NotaFiscalServicoEletronica.Registry;
  Controllers.Healthcheck.Registry;
  Controllers.NotaFiscalEletronica.Registry;

  THorse.Listen(9001,
    procedure
    begin
      Writeln('Fiscal is running on port ' + THorse.Port.ToString);
    end);
end.
