unit Services.NFSe;

interface

uses System.SysUtils, System.Classes, Providers.NFSe, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  FireDAC.Phys.PGDef, ACBrDFeReport, ACBrNFSeXDANFSeClass, ACBrNFSeXDANFSeRLClass, ACBrMail, ACBrBase, ACBrDFe, ACBrNFSeX,
  FireDAC.Phys.PG, Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Wait;

type
  TServiceNFSe = class(TProviderNFSe)
  public
    function GerarLinkNFSe(const ANumeroNFSe, ACodigoVerificacao: string): string;
  end;

implementation

{$R *.dfm}

function TServiceNFSe.GerarLinkNFSe(const ANumeroNFSe, ACodigoVerificacao: string): string;
begin
  if ANumeroNFSe.Trim.IsEmpty then
    raise Exception.Create('Informe o número da NFSe');
  if ACodigoVerificacao.Trim.IsEmpty then
    raise Exception.Create('Informe o código de verificação');
  Result := ACBrNFSeX.LinkNFSe(ANumeroNFSe, ACodigoVerificacao);
end;

end.
