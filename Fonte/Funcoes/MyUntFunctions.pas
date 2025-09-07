{ Unit:    MyUntFunctions                                            }
{ Author:  Gilvan Costa                                              }
{ License: none                                                      }
{ Date:    2010-11                                                   }
{ E-mail   : gilvancosta2010@gmail.com                               }
{ Website  : http://www.cstsystem.com.br/                            }

unit MyUntFunctions;

interface

uses
  SysUtils, forms, windows, IdIPWatch, classes, dialogs, DateUtils;

  function ProcessoAtivo(AValue: String = ''): Boolean;

  Function EventLogFilexml() : String;

  Function getiplocalhost(): String;
  Function getPCname() : String;
  Function getWinUser() : String;


{$REGION 'funcoes datas e horas'}
  function MyFunctions_DiferencaEntreDateTime(data1, data2: TDateTime): string;
  function MyFunctions_DiferencaEntreDatas(data1, data2: TDateTime)   : Real;
{$ENDREGION}


{$REGION 'Tratamento de Arquivos'}

function MyFunction_NomeDoArquivoSemExtensao(const Filename: String): String;
Function MyFunction_TamanhoArquivoBytes(arquivo: string): Integer;
Function MyFunction_MontarPastaDoArquivo(CodigodoRegistro, CodigoDoConjunto : Integer; PathDoModulo : String; DataDocadastro : TDateTime) : String;

Function MuFunction_MontarLocalizacaoDoArquivo(CodigoDoRegistro : Integer; pathDoModulo, NomeDoArquivo1 : String ; DataDoCadastro : TDateTime) : String;

{$ENDREGION}
Procedure RunFormulario(Formulario: TFormClass);

implementation


{$REGION 'Tratamento de Arquivos - implementation'}
Function MuFunction_MontarLocalizacaoDoArquivo(CodigoDoRegistro : Integer; pathDoModulo, NomeDoArquivo1 : String ; DataDoCadastro  : TDateTime) : String;
var
  Ano, mes, dia    : Word;
  PastaDoArquivo   : String;
  pastaDaAplicacao : String;



Begin

    Result := '';

    try
              DecodeDate(DataDoCadastro ,Ano,Mes,Dia);
              pastaDaAplicacao :=  ExtractFilePath(paramStr(0));




        //create the folder  with code the service of order
          PastaDoArquivo := pastaDaAplicacao + PathDoModulo  + IntToStr(Ano)+ '\'+ IntToStr(mes)+'\'+Inttostr(CodigodoRegistro)+ '\' + NomeDoArquivo1;

          if FileExists(PastaDoArquivo) then
          begin
            Result :=  PastaDoArquivo;
          end
          else
          begin
             Result := '';
          end;





    except
      Result := '';
    end;


End;

function MyFunction_NomeDoArquivoSemExtensao(const Filename: String): String;
{Retorna o nome do Arquivo sem extensão}
var
    aExt : String;
    aPos : Integer;
begin

    aExt := ExtractFileExt(Filename);
    Result := ExtractFileName(Filename);
    if aExt <> '' then
    begin
        aPos := Pos(aExt,Result);
        if aPos > 0 then
        begin
          Delete(Result,aPos,Length(aExt));
        end;
   end;


End;

function MyFunction_TamanhoArquivoBytes(arquivo: string): Integer;
begin
    With TFileStream.Create(Arquivo, fmopenRead or fmshareExclusive)do
    Begin
        try
            Result := Size;
        finally
            free;
        end;
    End;
end;


Function MyFunction_MontarPastaDoArquivo(CodigodoRegistro, CodigoDoConjunto : Integer; PathDoModulo : String; DataDocadastro : TDateTime) : String;
var
  Ano, mes, dia    : Word;
  PastaDoArquivo   : String;
  pastaDaAplicacao : String;



Begin

  Result := '';

try
         DecodeDate(DataDocadastro , Ano,Mes,Dia);
         pastaDaAplicacao :=  ExtractFilePath(paramStr(0));

         //CodigoDoConjunto
         // 1 : Imagesfile
         // 2 : AttachFile
         // 3 : documentfiles
         // 4 : videosfile

          case CodigoDoConjunto of
          1: if not DirectoryExists(pastaDaAplicacao +'Imagesfile') then
                begin
                  CreateDir(pastaDaAplicacao +'Imagesfile');
                End;


          2: if not DirectoryExists(pastaDaAplicacao +'AttachFile') then
                begin
                  CreateDir(pastaDaAplicacao +'AttachFile');
                End;

          3: if not DirectoryExists(pastaDaAplicacao +'documentfiles') then
                begin
                  CreateDir(pastaDaAplicacao +'documentfiles');
                End;
          4: if not DirectoryExists(pastaDaAplicacao +'videosfile') then
                begin;
                  CreateDir(pastaDaAplicacao +'videosfile');
                End;
          end;

        //Cria a pasta raiz do arquivo
          if not DirectoryExists(pastaDaAplicacao + PathDoModulo) then
          begin
            CreateDir(pastaDaAplicacao + PathDoModulo);
          end;

        //create the folder year in folder services
              PastaDoArquivo  := pastaDaAplicacao + PathDoModulo +IntToStr(Ano)+'\';

          if not DirectoryExists(PastaDoArquivo) then
          begin
            CreateDir(PastaDoArquivo);
          end;


        //create the folder  Month
          PastaDoArquivo := pastaDaAplicacao + PathDoModulo  + IntToStr(Ano)+ '\'+ IntToStr(mes)+'\';
          if not DirectoryExists(PastaDoArquivo) then
          begin
            CreateDir(PastaDoArquivo);
          end;
        //create the folder  with code the service of order
          PastaDoArquivo := pastaDaAplicacao + PathDoModulo  + IntToStr(Ano)+ '\'+ IntToStr(mes)+'\'+Inttostr(CodigodoRegistro)+ '\';

          if not DirectoryExists(PastaDoArquivo) then
          begin
            CreateDir(PastaDoArquivo);
          end;
except on E: Exception do
  Showmessage('Erro na criação das pastas' + E.Message);
end;



  Result := pastaDoArquivo;

End;


{$ENDREGION}


Procedure RunFormulario(Formulario: TFormClass);
Begin
    Try
        TForm (Formulario) := Formulario.Create(nil);
        TForm (Formulario).ShowModal;
    Finally
        //FreeAndNil(Formulario);
    End;
end;

Function getiplocalhost(): String;
Var

  IP         : TIdIPWatch;
  NumeroDoIP : String;

begin

  Result := '';

    try
        IP := TIdIPWatch.Create(nil);
        NumeroDoIP       :=  IP.LocalIP;
        Ip.Free;

        Result :=  NumeroDoIP;
    except on E: Exception do
    end;
end;

Function GetPCname() : String;
Var
  buffer        : array[0..255] of char;
  size          : dword;
  ComputerName  : String;


begin

  result := '';

    try
        Size          := 256;
        GetUserName(Buffer, Size);

        Size          := MAX_COMPUTERNAME_LENGTH + 1;
        GetComputerName(buffer, size);
        ComputerName  := buffer;

        Result :=  ComputerName;
    except on E: Exception do
    end;



end;
Function getWinUser() : String;
Var
  buffer        : array[0..255] of char;
  size          : dword;
  UserName      : String;


begin
    Result := '';

    try
        Size          := 256;
        GetUserName(Buffer, Size);
        UserName      := Buffer;

        Result  :=  UserName;
    except on E: Exception do
    end;



End;

{$REGION 'Funcoes datas e horas  - implementação'}

Function MyFunctions_DiferencaEntreDatas(data1, data2: TDateTime)   : Real;
Begin

    Result := DaySpan(data1, data2)

end;



function MyFunctions_DiferencaEntreDateTime(data1, data2: TDateTime): string;
var
    hora, minuto, segundo: integer;
    ret: string;
begin

    Result  := '';

    if data1 < data2 then
    Begin
        segundo := Round(86400 * (data2 - data1));
    End
    else
    Begin
        segundo := Round(86400 * (data1 - data2));
    End;


    hora      :=  segundo div 3600;
    segundo   :=  segundo - (hora * 3600);
    minuto    :=  segundo div 60;
    segundo   :=  segundo - (minuto * 60);


    if hora > 0 then
    begin
        if Length(IntToStr(hora)) > 2 then
        Begin
            ret:=IntToStr(hora)
        End
        else
        Begin
          ret:=FormatFloat('00',hora);
        End;
    end
    else
    begin
        ret:=FormatFloat('00',0);
    end;


    ret :=  ret + ':' + FormatFloat('00',minuto) + ':' + FormatFloat('00',segundo);


    Result  :=  ret;



end;




{$ENDREGION}






Function EventLogFilexml() : String;
var
  Ano, mes, dia   : Word;
  PastaLog        : String;
  pastaAnoAtual   : String;
  PastaMesAtual   : String;
  PathFile        : String;
begin

 Result := '';

  DecodeDate(Date,ano,mes,dia);

  PastaLog       := ExtractFilepath(ParamStr(0)) + 'Log';
  pastaAnoAtual  := ExtractFilepath(ParamStr(0)) + 'Log\' + IntToStr(Ano);
  PastaMesAtual  := ExtractFilepath(ParamStr(0)) + 'Log\' + IntToStr(Ano) + '\' + IntToStr(Mes) ;

//Verifica se existe a pasta do log
  if not DirectoryExists(PastaLog) then
  begin
   CreateDir(PastaLog);
  end;
//verifica se existe a pasta do ano atual
  if not DirectoryExists(pastaAnoAtual) then
  begin
   CreateDir(pastaAnoAtual);
  end;
//verifica se existe a pasta do mes atual

  if not DirectoryExists(PastaMesAtual) then
  begin
   CreateDir(PastaMesAtual);
  end;

  pathFile:=  PastaMesAtual + '\' + 'EventLog.xml';


  Result :=   PathFile;

end;

function ProcessoAtivo(AValue: String): Boolean;
begin
  if AnsiSameStr(AValue, EmptyStr) then
  begin
    AValue := ExtractFileName(Application.ExeName);
  end;

  CreateSemaphore(nil, 1, 1, PChar(AValue));

  Result := (GetLastError = ERROR_ALREADY_EXISTS);
end;

end.
