unit Controllers.NotaFiscalServicoEletronica;

interface

procedure Registry;

implementation

uses Horse, Services.NotaFiscalServicoEletronica;

procedure DoGerarNFSe(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceNotaFiscalServicoEletronica;
begin
  LService := TServiceNotaFiscalServicoEletronica.Create(nil);
  try
    LService.GerarNotaFiscalServico;

    // na realidade aqui seria devolvido o documento provavelmente
    Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Post('/nfse', DoGerarNFSe);
end;

end.
