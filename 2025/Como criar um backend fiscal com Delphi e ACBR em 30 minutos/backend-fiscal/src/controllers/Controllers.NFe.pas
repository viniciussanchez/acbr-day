unit Controllers.NFe;

interface

implementation

uses Horse, Services.NFe, System.JSON;

procedure DoConsultarChave(Req: THorseRequest; Res: THorseResponse);
begin
  var LService := TServiceNFe.Create(nil);
  try
    Res.Send(LService.ConsultarChaveNFe(Req.Params['chave']));
  finally
    LService.Free;
  end;
end;

procedure DoStatusServico(Req: THorseRequest; Res: THorseResponse);
begin
  var LService := TServiceNFe.Create(nil);
  try
    Res.Send<TJSONObject>(LService.ConsultarStatusServico);
  finally
    LService.Free;
  end;
end;

procedure DoInutilizarNumeracao(Req: THorseRequest; Res: THorseResponse);
begin
  var LService := TServiceNFe.Create(nil);
  try
    Res.Send<TJSONObject>(LService.InutilizarNumeracao(
      Req.Body<TJSONObject>.GetValue<string>('cnpj'),
      Req.Body<TJSONObject>.GetValue<string>('justificativa'),
      Req.Body<TJSONObject>.GetValue<string>('ano'),
      Req.Body<TJSONObject>.GetValue<string>('modelo'),
      Req.Body<TJSONObject>.GetValue<string>('serie'),
      Req.Body<TJSONObject>.GetValue<string>('numeroInicial'),
      Req.Body<TJSONObject>.GetValue<string>('numeroFinal')));
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/nfe/consultar-chave/:chave', DoConsultarChave);
  THorse.Get('/nfe/status-servico', DoStatusServico);
  THorse.Post('/nfe/inutilizar-numeracao', DoInutilizarNumeracao);
end;

initialization
  Registry;

end.
