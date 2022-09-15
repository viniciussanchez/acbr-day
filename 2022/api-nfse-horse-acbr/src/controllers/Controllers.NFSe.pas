unit Controllers.NFSe;

interface

implementation

uses Horse, Services.NFSe, System.JSON, REST.Json, ACBrNFSeXWebserviceBase;

procedure DoGetNFSeTomador(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceNFSe;
  LNumeroNFSe, LPagina: string;
begin
  LService := TServiceNFSe.Create;
  try
    LNumeroNFSe := Req.Query.Field('numero').AsString;
    LPagina := Req.Query.Field('pagina').AsString;
    Res.Send<TJSONObject>(TJson.ObjectToJsonObject(LService.ConsultarNFSeTomador(LNumeroNFSe, LPagina)));
  finally
    LService.Free;
  end;
end;

procedure DoGetNFSePrestador(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceNFSe;
  LNumeroNFSe, LPagina: string;
begin
  LService := TServiceNFSe.Create;
  try
    LNumeroNFSe := Req.Query.Field('numero').AsString;
    LPagina := Req.Query.Field('pagina').AsString;
    Res.Send<TJSONObject>(TJson.ObjectToJsonObject(LService.ConsultarNFSePrestador(LNumeroNFSe, LPagina)));
  finally
    LService.Free;
  end;
end;

procedure DoGetNFSe(Req: THorseRequest; Res: THorseResponse);
var
  LNumeroNFSe: string;
  LService: TServiceNFSe;
begin
  LService := TServiceNFSe.Create;
  try
    LNumeroNFSe := Req.Query.Field('numero').AsString;
    Res.Send<TJSONObject>(TJson.ObjectToJsonObject(LService.ConsultarNFSe(LNumeroNFSe)));
  finally
    LService.Free;
  end;
end;

procedure DoCancelarNFSe(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceNFSe;
  LInformacoesCancelamento: TInfCancelamento;
begin
  LService := TServiceNFSe.Create;
  try
    LInformacoesCancelamento := TJson.JsonToObject<TInfCancelamento>(Req.Body);
    Res.Send<TJSONObject>(TJson.ObjectToJsonObject(LService.CancelarNFSe(LInformacoesCancelamento)));
  finally
    LService.Free;
  end;
end;

procedure DoGetLinkNFSe(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceNFSe;
  LNumeroNFSe, LCodigoVerificacao: string;
begin
  LService := TServiceNFSe.Create;
  try
    LNumeroNFSe := Req.Query.Field('numero').AsString;
    LCodigoVerificacao := Req.Query.Field('codigoVerificacao').AsString;
    Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('link', LService.GerarLinkNFSe(LNumeroNFSe, LCodigoVerificacao))));
  finally
    LService.Free;
  end;
end;

procedure DoSubstituirNFSe(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceNFSe;
  LNumeroNovoRPS, LNumeroNFSe, LNumeroLote, LNumeroSerie, LCodigoCancelamento, LMotivoCancelamento, LCodigoVerificacao: string;
begin
  LService := TServiceNFSe.Create;
  try
    LNumeroNovoRPS := Req.Query.Field('rps').AsString;
    LNumeroNFSe := Req.Query.Field('nfse').AsString;
    LNumeroLote := Req.Query.Field('lote').AsString;
    LNumeroSerie := Req.Query.Field('serie').AsString;
    LCodigoCancelamento := Req.Query.Field('codigoCancelamento').AsString;
    LMotivoCancelamento := Req.Query.Field('motivo').AsString;
    LCodigoVerificacao := Req.Query.Field('codigoVerificacao').AsString;
    Res.Send<TJSONObject>(TJson.ObjectToJsonObject(LService.SubstituirNFSe(LNumeroNovoRPS, LNumeroNFSe, LNumeroLote, LNumeroSerie, LCodigoCancelamento, LMotivoCancelamento, LCodigoVerificacao)));
  finally
    LService.Free;
  end;
end;

procedure DoEmitirNFSe(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceNFSe;
  LQuantidade, LNumeroRPS, LNumeroLote: string;
begin
  LService := TServiceNFSe.Create;
  try
    LQuantidade := Req.Query.Field('quantidade').AsString;
    LNumeroRPS := Req.Query.Field('rps').AsString;
    LNumeroLote := Req.Query.Field('lote').AsString;
    Res.Send<TJSONObject>(TJson.ObjectToJsonObject(LService.EmitirNFSe(LQuantidade, LNumeroRPS, LNumeroLote)));
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/nfse', DoGetNFSe);
  THorse.Get('/nfse/link', DoGetLinkNFSe);
  THorse.Get('/nfse/tomador', DoGetNFSeTomador);
  THorse.Get('/nfse/prestador', DoGetNFSePrestador);
  THorse.Post('/nfse/cancelar', DoCancelarNFSe);
  THorse.Post('/nfse/substituir', DoSubstituirNFSe);
  THorse.Post('/nfse/emitir', DoEmitirNFSe);
end;

initialization
  Registry;

end.
