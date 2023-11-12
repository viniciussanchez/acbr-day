unit Controllers.NotaFiscalEletronica;

interface

procedure Registry;

implementation

uses Horse, Services.NotaFiscalEletronica;

procedure DoGerarNFe(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceNotaFiscalEletronica;
begin
  LService := TServiceNotaFiscalEletronica.Create(nil);
  try
    LService.GerarNotaFiscal;

    // na realidade aqui seria devolvido o documento provavelmente
    Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Post('/nfe', DoGerarNFe);
end;

end.
