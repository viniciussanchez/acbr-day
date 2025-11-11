unit Services.NFe;

interface

uses System.SysUtils, System.Classes, ACBrBase, ACBrDFe, ACBrNFe, System.JSON, pcnConversao;

type
  TServiceNFe = class(TDataModule)
    ACBrNFe1: TACBrNFe;
  public
    function InutilizarNumeracao(const ACNPJ, AJustificativa, AAno, AModelo, ASerie, ANumeroInicial, ANumeroFinal: string): TJSONObject;
    function ConsultarStatusServico: TJSONObject;
    function ConsultarChaveNFe(const AChaveNFe: string): string;
  end;

implementation

{$R *.dfm}

function TServiceNFe.ConsultarChaveNFe(const AChaveNFe: string): string;
begin
  ACBrNFe1.NotasFiscais.Clear;
  ACBrNFe1.WebServices.Consulta.NFeChave := AChaveNFe;
  ACBrNFe1.WebServices.Consulta.Executar;
  Result := ACBrNFe1.WebServices.Consulta.RetornoWS;
end;

function TServiceNFe.ConsultarStatusServico: TJSONObject;
begin
  ACBrNFe1.WebServices.StatusServico.Executar;

  Result := TJSONObject.Create
    .AddPair('tpAmb', TpAmbToStr(ACBrNFe1.WebServices.StatusServico.tpAmb))
    .AddPair('verAplic', ACBrNFe1.WebServices.StatusServico.verAplic)
    .AddPair('cStat', IntToStr(ACBrNFe1.WebServices.StatusServico.cStat))
    .AddPair('xMotivo', ACBrNFe1.WebServices.StatusServico.xMotivo)
    .AddPair('cUF', IntToStr(ACBrNFe1.WebServices.StatusServico.cUF))
    .AddPair('dhRecbto', DateTimeToStr(ACBrNFe1.WebServices.StatusServico.dhRecbto))
    .AddPair('tMed', IntToStr(ACBrNFe1.WebServices.StatusServico.TMed))
    .AddPair('dhRetorno', DateTimeToStr(ACBrNFe1.WebServices.StatusServico.dhRetorno))
    .AddPair('xObs', ACBrNFe1.WebServices.StatusServico.xObs);
end;

function TServiceNFe.InutilizarNumeracao(const ACNPJ, AJustificativa, AAno, AModelo, ASerie, ANumeroInicial, ANumeroFinal: string): TJSONObject;
begin
  ACBrNFe1.WebServices.Inutiliza(ACNPJ, AJustificativa, StrToInt(AAno), StrToInt(AModelo), StrToInt(ASerie), StrToInt(ANumeroInicial), StrToInt(ANumeroFinal));

  Result := TJSONObject.Create
    .AddPair('tpAmb', TpAmbToStr(ACBrNFe1.WebServices.Inutilizacao.tpAmb))
    .AddPair('verAplic', ACBrNFe1.WebServices.Inutilizacao.verAplic)
    .AddPair('cStat', IntToStr(ACBrNFe1.WebServices.Inutilizacao.cStat))
    .AddPair('xMotivo', ACBrNFe1.WebServices.Inutilizacao.xMotivo)
    .AddPair('cUF', IntToStr(ACBrNFe1.WebServices.Inutilizacao.cUF))
    .AddPair('Ano', IntToStr(ACBrNFe1.WebServices.Inutilizacao.Ano))
    .AddPair('CNPJ', ACBrNFe1.WebServices.Inutilizacao.CNPJ)
    .AddPair('Modelo', IntToStr(ACBrNFe1.WebServices.Inutilizacao.Modelo))
    .AddPair('vSerie', IntToStr(ACBrNFe1.WebServices.Inutilizacao.Serie))
    .AddPair('NumeroInicial', IntToStr(ACBrNFe1.WebServices.Inutilizacao.NumeroInicial))
    .AddPair('vNumeroInicial', IntToStr(ACBrNFe1.WebServices.Inutilizacao.NumeroFinal))
    .AddPair('dhRecbto', DateTimeToStr(ACBrNFe1.WebServices.Inutilizacao.dhRecbto))
    .AddPair('Protocolo', ACBrNFe1.WebServices.Inutilizacao.Protocolo);
end;

end.
