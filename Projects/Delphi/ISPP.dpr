{
  Inno Setup Preprocessor
  Copyright (C) 2001-2002 Alex Yackimoff
  $Id: ISPP.dpr,v 1.7 2010/12/30 14:58:38 mlaan Exp $
}

library ISPP;

{$IMAGEBASE $01800000}
{$I Version.inc}
{$R *.RES}

uses
  SysUtils,
  //IsppDebug in 'IsppDebug.pas',
  Windows,
  Classes,
  CompPreprocInt in '..\..\Source\CompPreprocInt.pas',
  IsppPreprocess in '..\..\Source\Ispp\IsppPreprocess.pas',
  IsppTranslate in '..\..\Source\Ispp\IsppTranslate.pas',
  IsppFuncs in '..\..\Source\Ispp\IsppFuncs.pas',
  IsppVarUtils in '..\..\Source\Ispp\IsppVarUtils.pas',
  IsppConsts in '..\..\Source\Ispp\IsppConsts.pas',
  IsppStacks in '..\..\Source\Ispp\IsppStacks.pas',
  IsppIntf in '..\..\Source\Ispp\IsppIntf.pas',
  IsppParser in '..\..\Source\Ispp\IsppParser.pas',
  IsppIdentMan in '..\..\Source\Ispp\IsppIdentMan.pas',
  IsppSessions in '..\..\Source\Ispp\IsppSessions.pas',
  CParser in '..\..\Source\Ispp\CParser.pas',
  IsppBase in '..\..\Source\Ispp\IsppBase.pas',
  PathFunc in '..\..\Components\PathFunc.pas',
  CmnFunc2 in '..\..\Source\CmnFunc2.pas',
  FileClass in '..\..\Source\FileClass.pas',
  Int64Em in '..\..\Source\Int64Em.pas',
  MD5 in '..\..\Source\MD5.pas',
  SHA1 in '..\..\Source\SHA1.pas',
  Struct in '..\..\Source\Struct.pas';
  //IsppExceptWindow in 'IsppExceptWindow.pas' {IsppExceptWnd};

const
  FuncNameSuffix = {$IFDEF UNICODE} 'W' {$ELSE} 'A' {$ENDIF};
exports
  ISPreprocessScript name 'ISPreprocessScript' + FuncNameSuffix;

end.
