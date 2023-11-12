unit Services.NotaFiscalServicoEletronica;

interface

uses System.SysUtils, System.Classes, ACBrBase, ACBrDFe, ACBrNFSe;

type
  TServiceNotaFiscalServicoEletronica = class(TDataModule)
    ACBrNFSe: TACBrNFSe;
  public
    procedure GerarNotaFiscalServico;
  end;

implementation

{$R *.dfm}

procedure TServiceNotaFiscalServicoEletronica.GerarNotaFiscalServico;
begin
  // rotina para gerar NFSe
end;

end.
