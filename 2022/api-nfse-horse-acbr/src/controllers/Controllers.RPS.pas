unit Controllers.RPS;

interface

implementation

uses Horse, Services.RPS, System.JSON, REST.Json;

procedure DoGetLote(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceRPS;
  LProtocolo, LLote: string;
begin
  LService := TServiceRPS.Create;
  try
    LLote := Req.Query.Field('lote').AsString;
    LProtocolo := Req.Query.Field('protocolo').AsString;
    Res.Send<TJSONObject>(TJson.ObjectToJsonObject(LService.ConsultarLote(LProtocolo, LLote)));
  finally
    LService.Free;
  end;
end;

procedure DoGetSituacaoLote(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceRPS;
  LProtocolo, LLote: string;
begin
  LService := TServiceRPS.Create;
  try
    LLote := Req.Query.Field('lote').AsString;
    LProtocolo := Req.Query.Field('protocolo').AsString;
    Res.Send<TJSONObject>(TJson.ObjectToJsonObject(LService.ConsultarSituacaoLote(LProtocolo, LLote)));
  finally
    LService.Free;
  end;
end;

procedure DoEnviarLoteRPS(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceRPS;
  LNumeroRPS, LLote: string;
begin
  LService := TServiceRPS.Create;
  try
    LLote := Req.Query.Field('lote').AsString;
    LNumeroRPS := Req.Query.Field('numero').AsString;
    Res.Send<TJSONObject>(TJson.ObjectToJsonObject(LService.EnviarLoteRPS(LNumeroRPS, LLote)));
  finally
    LService.Free;
  end;
end;

procedure DoGerarLoteRPS(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceRPS;
  LNumeroRPS, LLote: string;
begin
  LService := TServiceRPS.Create;
  try
    LLote := Req.Query.Field('lote').AsString;
    LNumeroRPS := Req.Query.Field('numero').AsString;
    Res.Send<TJSONObject>(TJson.ObjectToJsonObject(LService.GerarLoteRPS(LNumeroRPS, LLote)));
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/rps/lote', DoGetLote);
  THorse.Get('/rps/lote/situacao', DoGetSituacaoLote);
  THorse.Post('/rps/lote/enviar', DoEnviarLoteRPS);
  THorse.Post('/rps/lote/gerar', DoGerarLoteRPS);
end;

initialization
  Registry;

end.
