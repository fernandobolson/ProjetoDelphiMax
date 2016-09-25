unit CPF_CNPJ;

interface
function IsCpf(Cpf: string): boolean;
function ImprimeCpf(Cpf: string): string;
function IsCnpj(Cnpj: string): boolean;
function ImprimeCnpj(Cnpj: string): string;

implementation
uses SysUtils;

function IsCpf(Cpf: string): boolean;
var Dig10, Dig11: string;
         S, i, R: integer;
begin
  if length(Cpf) <> 11 then
    begin
    IsCpf := False;
    Exit;
  end;

{ *-- Calculo do 1o. Digito Verificador --* }
  S := 0;
  for i := 1 to 9 do
    S := S + (StrToInt(Cpf[i]) * (11 - i));
  R := 11 - (S mod 11);
  if (R = 10) or (R = 11) then
    Dig10 := '0'
  else
    str(R:1, Dig10);

{ *-- Calculo do 2o. Digito Verificador --* }
  S := 0;
  for i := 1 to 10 do
    S := S + (StrToInt(Cpf[i]) * (12 - i));
  R := 11 - (S mod 11);
  if (R = 10) or (R = 11) then
    Dig11 := '0'
  else
    str(R:1, Dig11);

{ Verifica se os digitos calculados conferem. }
  IsCpf := (Dig10 = Cpf[10]) and (Dig11 = Cpf[11]);
end;

function ImprimeCpf(Cpf: string): string;
begin
  ImprimeCpf := copy(Cpf,1,3) + '.' + copy(Cpf,4,3) + '.' + copy(Cpf,7,3) + '-' + copy(Cpf,10,2);
end;

function IsCnpj(Cnpj: string): boolean;
var S, i, R, Mult: integer;
     Dig13, Dig14: string;
begin
  if length(Cnpj) <> 14 then
    begin
    IsCnpj := False;
    Exit;
  end;

{ *-- Calculo do 13o. Digito --* }
  S := 0; Mult := 2;
  for i := 12 downto 1 do
    begin
    S := S + (StrToInt(Cnpj[i]) * Mult);
    Mult := Mult + 1;
    if Mult = 10 then Mult := 2;
  end;

  R := S mod 11;
  if   (R = 0) or (R = 1) then
    Dig13 := '0'
  else
    str((11-R):1, Dig13);

{ *-- Calculo do 14o. Digito --* }
  S := 0; Mult := 2;
  for i := 13 downto 1 do
    begin
      S := S + (StrToInt(Cnpj[i]) * Mult);
      Mult := Mult + 1;
      if Mult = 10 then Mult := 2;
  end;
  R := S mod 11;
  if   (R = 0) or (R = 1) then
    Dig14 := '0'
  else
    str((11-R):1, Dig14);

{ Verificando se os digitos conferem. }
  IsCnpj := (Dig13 = Cnpj[13]) and (Dig14 = Cnpj[14]);
end;

function ImprimeCnpj(Cnpj: string): string;
begin
  ImprimeCnpj := copy(Cnpj,1,2) + '.' + copy(Cnpj,3,3) + '.' + copy(Cnpj,6,3) + '.' + copy(Cnpj,9,4) + '-' + copy(Cnpj,13,2);
end;

end.