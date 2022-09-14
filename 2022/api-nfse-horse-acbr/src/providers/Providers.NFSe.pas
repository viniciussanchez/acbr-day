unit Providers.NFSe;

interface

uses System.SysUtils, System.Classes, Providers.Connection, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.ConsoleUI.Wait, FireDAC.Phys.PGDef, FireDAC.Phys.PG, Data.DB, FireDAC.Comp.Client, FireDAC.VCLUI.Wait, ACBrDFeReport,
  ACBrNFSeXDANFSeClass, ACBrNFSeXDANFSeRLClass, ACBrMail, ACBrBase, ACBrDFe, ACBrNFSeX;

type
  TProviderNFSe = class(TProviderConnection)
    ACBrNFSeX: TACBrNFSeX;
    ACBrMail: TACBrMail;
    ACBrNFSeXDANFSeRL: TACBrNFSeXDANFSeRL;
  end;

var
  ProviderNFSe: TProviderNFSe;

implementation

{$R *.dfm}

end.
