unit Services.NFSe;

interface

uses System.SysUtils, System.Classes, Providers.NFSe, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  FireDAC.Phys.PGDef, ACBrDFeReport, ACBrNFSeXDANFSeClass, ACBrNFSeXDANFSeRLClass, ACBrMail, ACBrBase, ACBrDFe, ACBrNFSeX,
  FireDAC.Phys.PG, Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Wait, ACBrNFSeXConversao, ACBrNFSeXWebservicesResponse,
  ACBrNFSeXWebserviceBase;

type
  TServiceNFSe = class(TProviderNFSe)
  public
    function GerarLinkNFSe(const ANumeroNFSe, ACodigoVerificacao: string): string;
    function CancelarNFSe(const AInformacoesCancelamento: TInfCancelamento): TNFSeCancelaNFSeResponse;
    function EmitirNFSe(const AQuantidade, ANumeroRPS, ANumeroLote: string): TNFSeEmiteResponse;
    procedure ConsultarNFSeTomador;
    procedure ConsultarNFSePrestador;
    procedure ConsultarNFSe;
    function SubstituirNFSe(const ANumeroNovoRPS, ANumeroNFSe, ANumeroLote, ASerieNFSe, ACodigoCancelamento, ACodigoVerificacao, AMotivoCancelamento: string): TNFSeSubstituiNFSeResponse;
  end;

implementation

{$R *.dfm}

function TServiceNFSe.CancelarNFSe(const AInformacoesCancelamento: TInfCancelamento): TNFSeCancelaNFSeResponse;
begin
  try
    { TODO : Validar informações }
    ACBrNFSeX.CancelarNFSe(AInformacoesCancelamento);
    Result := ACBrNFSeX.WebService.CancelaNFSe;
  finally
    AInformacoesCancelamento.Free;
  end;
end;

procedure TServiceNFSe.ConsultarNFSe;
begin

end;

procedure TServiceNFSe.ConsultarNFSePrestador;
begin

end;

procedure TServiceNFSe.ConsultarNFSeTomador;
begin

end;

function TServiceNFSe.EmitirNFSe(const AQuantidade, ANumeroRPS, ANumeroLote: string): TNFSeEmiteResponse;
var
  I, LQuantidade: Integer;
begin
  if AQuantidade.Trim.IsEmpty then
    raise Exception.Create('Informe a quantidade de RPS');
  if ANumeroRPS.Trim.IsEmpty then
    raise Exception.Create('Informe o númeero do RPS');
  if ANumeroLote.Trim.IsEmpty then
    raise Exception.Create('Informe o número do lote');

  LQuantidade := StrToIntDef(AQuantidade, 1);

  for I := 1 to LQuantidade do
  begin
    { TODO : alimentar nfse }
  end;

  ACBrNFSeX.Emitir(ANumeroLote);
  Result := ACBrNFSeX.WebService.Emite;
end;

function TServiceNFSe.GerarLinkNFSe(const ANumeroNFSe, ACodigoVerificacao: string): string;
begin
  if ANumeroNFSe.Trim.IsEmpty then
    raise Exception.Create('Informe o número da NFSe');
  if ACodigoVerificacao.Trim.IsEmpty then
    raise Exception.Create('Informe o código de verificação');
  Result := ACBrNFSeX.LinkNFSe(ANumeroNFSe, ACodigoVerificacao);
end;

function TServiceNFSe.SubstituirNFSe(const ANumeroNovoRPS, ANumeroNFSe, ANumeroLote, ASerieNFSe, ACodigoCancelamento, ACodigoVerificacao, AMotivoCancelamento: string): TNFSeSubstituiNFSeResponse;
var
  LCodigoCancelamento: string;
begin
  if ANumeroNovoRPS.Trim.IsEmpty then
    raise Exception.Create('Informe o número do novo RPS');
  if ACodigoCancelamento.Trim.IsEmpty then
    raise Exception.Create('Informe o código de cancelamento');
  if ANumeroNFSe.Trim.IsEmpty then
    raise Exception.Create('Informe o número da NFSe');

  { TODO : alimentar nfse }

  LCodigoCancelamento := ACodigoCancelamento;
  if ACBrNFSeX.Configuracoes.Geral.Provedor = proSigep then
  begin
    case StrToIntDef(ACodigoCancelamento, 1) of
      1:
        LCodigoCancelamento := 'EE';
      2:
        LCodigoCancelamento := 'ED';
      3:
        LCodigoCancelamento := 'OU';
      4:
        LCodigoCancelamento := 'SB';
    end;
  end;

  if ACBrNFSeX.Configuracoes.Geral.Provedor in [proAgili, proConam, proEquiplano, proGoverna, proIPM, proISSDSF, proISSLencois,
    proModernizacaoPublica, proPublica, proSiat, proSigISS, proSmarAPD, proWebFisco, proSudoeste] then
  begin
    if AMotivoCancelamento.Trim.IsEmpty then
      raise Exception.Create('Informe o motivo do cancelamento');
  end;

  if ACBrNFSeX.Configuracoes.Geral.Provedor = proiiBrasil then
  begin
    if ASerieNFSe.Trim.IsEmpty then
      raise Exception.Create('Informe a série da NFSe');
  end;

  if ACBrNFSeX.Configuracoes.Geral.Provedor = proAssessorPublico then
  begin
    if ANumeroLote.Trim.IsEmpty then
      raise Exception.Create('Informe o número do lote');
  end;

  if ACBrNFSeX.Configuracoes.Geral.Provedor in [proISSLencois, proGoverna, proSiat, proSigep, proElotech] then
  begin
    if ACodigoVerificacao.Trim.IsEmpty then
      raise Exception.Create('Informe o código de verificação');
  end;

  ACBrNFSeX.SubstituirNFSe(ANumeroNFSe, ASerieNFSe, LCodigoCancelamento, AMotivoCancelamento, ANumeroLote, ACodigoVerificacao);
  Result := ACBrNFSeX.WebService.SubstituiNFSe;
end;

end.
