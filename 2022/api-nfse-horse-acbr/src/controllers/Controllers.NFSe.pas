unit Controllers.NFSe;

interface

implementation

uses Horse, Services.NFSe, System.JSON, REST.Json;

procedure DoCancelarNFSe(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceNFSe;
begin
  LService := TServiceNFSe.Create;
  try

  finally
    LService.Free;
  end;
end;

procedure DoGetNFSeTomador(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceNFSe;
begin
  LService := TServiceNFSe.Create;
  try

  finally
    LService.Free;
  end;
end;

procedure DoGetNFSePrestador(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceNFSe;
begin
  LService := TServiceNFSe.Create;
  try

  finally
    LService.Free;
  end;
end;

procedure DoGetNFSe(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceNFSe;
begin
  LService := TServiceNFSe.Create;
  try

  finally
    LService.Free;
  end;
end;

procedure DoGetLinkNFSe(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceNFSe;
begin
  LService := TServiceNFSe.Create;
  try

  finally
    LService.Free;
  end;
end;

procedure DoSubstituirNFSe(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceNFSe;
begin
  LService := TServiceNFSe.Create;
  try

  finally
    LService.Free;
  end;
end;

procedure DoEmitirNFSe(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceNFSe;
begin
  LService := TServiceNFSe.Create;
  try

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
