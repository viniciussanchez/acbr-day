unit Services.RPS;

interface

uses System.SysUtils, System.Classes, Providers.NFSe, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  FireDAC.Phys.PGDef, ACBrDFeReport, ACBrNFSeXDANFSeClass, ACBrNFSeXDANFSeRLClass, ACBrMail, ACBrBase, ACBrDFe, ACBrNFSeX,
  FireDAC.Phys.PG, Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Wait, ACBrNFSeXWebservicesResponse, ACBrNFSeXConversao;

type
  TServiceRPS = class(TProviderNFSe)
  public
    function ConsultarSituacaoLote(const AProtocolo, ALote: string): TNFSeConsultaSituacaoResponse;
    function ConsultarLote(const AProtocolo, ALote: string): TNFSeConsultaLoteRpsResponse;
    function EnviarLoteRPS(const ANumero, ALote: string): TNFSeEmiteResponse;
    function GerarLoteRPS(const ANumero, ALote: string): TNFSeEmiteResponse;
  end;

implementation

{$R *.dfm}

function TServiceRPS.ConsultarLote(const AProtocolo, ALote: string): TNFSeConsultaLoteRpsResponse;
begin
  if AProtocolo.Trim.IsEmpty then
    raise Exception.Create('Informe o número do protocolo');
  if ACBrNFSeX.Configuracoes.Geral.Provedor in [proAssessorPublico, proElotech, proInfisc, proIPM, proISSDSF, proEquiplano,
    proeGoverneISS, proGeisWeb, proSiat, proISSSaoPaulo] then
    if ALote.Trim.IsEmpty then
      raise Exception.Create('Informe o número do lote');
  ACBrNFSeX.ConsultarLoteRps(AProtocolo, ALote);
  Result := ACBrNFSeX.WebService.ConsultaLoteRps;
end;

function TServiceRPS.ConsultarSituacaoLote(const AProtocolo, ALote: string): TNFSeConsultaSituacaoResponse;
begin
  if AProtocolo.Trim.IsEmpty then
    raise Exception.Create('Informe o número do protocolo');
  if ACBrNFSeX.Configuracoes.Geral.Provedor in [proAssessorPublico, proEquiplano, proISSSaoPaulo] then
    if ALote.Trim.IsEmpty then
      raise Exception.Create('Informe o número do lote');
  ACBrNFSeX.ConsultarSituacao(AProtocolo, ALote);
  Result := ACBrNFSeX.WebService.ConsultaSituacao;
end;

function TServiceRPS.EnviarLoteRPS(const ANumero, ALote: string): TNFSeEmiteResponse;
begin
  if ANumero.Trim.IsEmpty then
    raise Exception.Create('Informe o número do RPS');
  if ALote.Trim.IsEmpty then
    raise Exception.Create('Informe o número do lote');
  { TODO : alimentar nfse }
  ACBrNFSeX.Emitir(ALote, meUnitario);
  Result := ACBrNFSeX.WebService.Emite;
end;

function TServiceRPS.GerarLoteRPS(const ANumero, ALote: string): TNFSeEmiteResponse;
begin
  if ANumero.Trim.IsEmpty then
    raise Exception.Create('Informe o número do RPS');
  if ALote.Trim.IsEmpty then
    raise Exception.Create('Informe o número do lote');
  ACBrNFSeX.NotasFiscais.Clear;
  { TODO : alimentar nfse }
  ACBrNFSeX.GerarLote(ALote);
  Result := ACBrNFSeX.WebService.Gerar;
end;

end.
