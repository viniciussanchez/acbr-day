unit Services.Token;

interface

uses System.SysUtils, System.Classes, Providers.NFSe, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  FireDAC.Phys.PGDef, ACBrDFeReport, ACBrNFSeXDANFSeClass, ACBrNFSeXDANFSeRLClass, ACBrMail, ACBrBase, ACBrDFe, ACBrNFSeX,
  FireDAC.Phys.PG, Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Wait, ACBrNFSeXWebservicesResponse;

type
  TServiceToken = class(TProviderNFSe)
  public
    function Gerar: TNFSeGerarTokenResponse;
  end;

implementation

{$R *.dfm}

function TServiceToken.Gerar: TNFSeGerarTokenResponse;
begin
  ACBrNFSeX.GerarToken;
  Result := ACBrNFSeX.WebService.GerarToken;
end;

end.
