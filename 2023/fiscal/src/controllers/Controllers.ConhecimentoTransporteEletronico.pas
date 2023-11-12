unit Controllers.ConhecimentoTransporteEletronico;

interface

procedure Registry;

implementation

uses Horse, Services.ConhecimentoTransporteEletronico;

procedure DoGerarNFe(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceConhecimentoTransporteEletronico;
begin
  LService := TServiceConhecimentoTransporteEletronico.Create(nil);
  try
    LService.GerarConhecimentoTransporte;

    // na realidade aqui seria devolvido o documento provavelmente
    Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Post('/cte', DoGerarNFe);
end;

end.
