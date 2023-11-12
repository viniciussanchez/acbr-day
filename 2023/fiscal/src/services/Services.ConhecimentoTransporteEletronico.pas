unit Services.ConhecimentoTransporteEletronico;

interface

uses System.SysUtils, System.Classes, ACBrBase, ACBrDFe, ACBrCTe;

type
  TServiceConhecimentoTransporteEletronico = class(TDataModule)
    ACBrCTe: TACBrCTe;
  public
    procedure GerarConhecimentoTransporte;
  end;

implementation

{$R *.dfm}

procedure TServiceConhecimentoTransporteEletronico.GerarConhecimentoTransporte;
begin
  // rotina para gerar CTe
end;

end.
