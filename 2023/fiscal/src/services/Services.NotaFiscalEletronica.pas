unit Services.NotaFiscalEletronica;

interface

uses System.SysUtils, System.Classes, ACBrBase, ACBrDFe, ACBrNFe;

type
  TServiceNotaFiscalEletronica = class(TDataModule)
    ACBrNFe: TACBrNFe;
  public
    procedure GerarNotaFiscal;
  end;

implementation

{$R *.dfm}

procedure TServiceNotaFiscalEletronica.GerarNotaFiscal;
begin
  // rotina para gerar NFe
end;

end.
