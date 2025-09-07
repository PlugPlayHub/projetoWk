unit UntINIfileManager;

interface

uses
    IniFiles, SysUtils;

type

  TTipoParametro = (tpBoolean, tpInteger, tpString, tpDate, tpTime, tpDateTime, tbDouble);

  function  sARQUIVO_INI: String;


  function ReadParametro(ATipo: TTipoParametro; ASection, AIdent: String; ADefault: Variant): Variant;

  procedure WriteParametro(ASection, AIdent: String; AValue: Boolean);   overload;
  procedure WriteParametro(ASection, AIdent: String; AValue: Integer);   overload;
  procedure WriteParametro(ASection, AIdent: String; AValue: String);    overload;
  procedure WriteParametro(ASection, AIdent: String; AValue: TDate);     overload;
  procedure WriteParametro(ASection, AIdent: String; AValue: TTime);     overload;
  procedure WriteParametro(ASection, AIdent: String; AValue: TDateTime); overload;
  procedure WriteParametro(ASection, AIdent: String; AValue: Double);    overload;


Const
    sEXTENSAO_INI = '.ini';

implementation


function sARQUIVO_INI: String;
begin
  Result := ChangeFileExt(ParamStr(0), sEXTENSAO_INI);
  // comando ChangeFileExt(ParamStr(0), sEXTENSAO_INI)
  // paramstr(0) retorna o nome da aplicação
  // Sextenção é o  valor da constante declarada
end;



function ReadParametro(ATipo: TTipoParametro; ASection, AIdent: String;   ADefault: Variant): Variant;
begin
  Result := EmptyStr;
  with TIniFile.Create(sARQUIVO_INI) do
  begin
    try
      case ATipo of
        tpBoolean:    Result := ReadBool       (ASection, AIdent, ADefault);
        tpString:     Result := ReadString     (ASection, AIdent, ADefault);
        tpInteger:    Result := ReadInteger    (ASection, AIdent, ADefault);
        tpDate:       Result := ReadDate       (ASection, AIdent, ADefault);
        tpTime:       Result := ReadTime       (ASection, AIdent, ADefault);
        tpDateTime:   Result := ReadDateTime   (ASection, AIdent, ADefault);
        tbDouble:     Result := ReadFloat      (ASection, AIdent, ADefault);
      end;
    finally
      Free;
    end;
  end;
end;

procedure WriteParametro(ASection, AIdent: String; AValue: Boolean);
begin
  with TIniFile.Create(sARQUIVO_INI) do
  begin
    try
      WriteBool(ASection, AIdent, AValue);
    finally
      Free;
    end;
  end;
end;

procedure WriteParametro(ASection, AIdent: String; AValue: Integer);
begin
  with TIniFile.Create(sARQUIVO_INI) do
  begin
    try
      WriteInteger(ASection, AIdent, AValue);
    finally
      Free;
    end;
  end;
end;

procedure WriteParametro(ASection, AIdent: String; AValue: String); overload;
begin
  with TIniFile.Create(sARQUIVO_INI) do
  begin
    try
      WriteString(ASection, AIdent, AValue);
    finally
      Free;
    end;
  end;
end;

procedure WriteParametro(ASection, AIdent: String; AValue: TDate); overload;
begin
  with TIniFile.Create(sARQUIVO_INI) do
  begin
    try
      WriteDate(ASection, AIdent, AValue);
    finally
      Free;
    end;
  end;
end;

procedure WriteParametro(ASection, AIdent: String; AValue: TTime); overload;
begin
  with TIniFile.Create(sARQUIVO_INI) do
  begin
    try
      WriteTime(ASection, AIdent, AValue);
    finally
      Free;
    end;
  end;
end;

procedure WriteParametro(ASection, AIdent: String; AValue: TDateTime); overload;
begin
  with TIniFile.Create(sARQUIVO_INI) do
  begin
    try
      WriteDateTime(ASection, AIdent, AValue);
    finally
      Free;
    end;
  end;
end;

procedure WriteParametro(ASection, AIdent: String; AValue: Double); overload;
begin
  with TIniFile.Create(sARQUIVO_INI) do
  begin
    try
      WriteFloat(ASection, AIdent, AValue);
    finally
      Free;
    end;
  end;
end;





end.
