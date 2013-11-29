@echo off

if "%COMPUTERNAME%"=="COTTONTAIL" (
  echo Setting for COTTONTAIL
  SET ITK_PATH=%HOME%\build\itk-3.8.0-vse2005\bin\Release
  SET PLASTIMATCH_BASE=%HOME%\build\plastimatch-vse2005
) else if "%COMPUTERNAME%"=="ROFOVIA" (
  echo Setting for ROFOVIA
  SET ITK_PATH=c:\plastimatch\build\itk-3.8.0\bin\Release
  SET PLASTIMATCH_BASE=c:\plastimatch\build\plastimatch
) else if "%COMPUTERNAME%"=="SLUMBER-SHARP" (
  echo Setting for SLUMBER
  SET ITK_PATH=%HOME%\build\vs2008\itk-3.20.0\bin\Release
  SET PLASTIMATCH_BASE=%HOME%\build\vs2008\plastimatch-3.20.0
) else if "%COMPUTERNAME%"=="SNOWBALL" (
  echo Setting for SNOWBALL
  SET ITK_PATH=%HOME%\build\itk-3.20.0\bin\Release
  SET PLASTIMATCH_BASE=%HOME%\build\plastimatch-3.20.0
  SET FFTW_PATH=%HOME%\build\fftw-3.2.2
) else if "%COMPUTERNAME%"=="TORTOISE" (
  echo Setting for TORTOISE
  SET ITK_PATH=%HOME%\build\vs2008\itk-3.16.0\bin\Release
  SET PLASTIMATCH_BASE=%HOME%\build\vs2008\plastimatch-3.16.0
) else if "%COMPUTERNAME%"=="W0109966" (
  echo Setting for W0109966
  SET ITK_PATH=%HOME%\build\vs2008\itk-3.20.1\bin\Release
@rem  SET PLASTIMATCH_BASE=%HOME%\build\vs2008\plastimatch-3.20.1
  SET PLASTIMATCH_BASE=%HOME%\build\vs2008\plastimatch-3.20.1-dcmtk
  SET FFTW_PATH=%HOME%\build\fftw-3.2.2
) else if "%COMPUTERNAME%"=="RO_GSHARPDIPS" (
  echo Setting for RO_GSHARPDIPS
  SET ITK_PATH=%HOME%\build\itk-3.20.0\bin\Release
  SET PLASTIMATCH_BASE=%HOME%\build\plastimatch-3.20.0
  SET FFTW_PATH=%HOME%\build\fftw-3.2.2
  SET QT_PATH=C:\QT\4.6.3\bin
) else if "%COMPUTERNAME%"=="GALL" (
  echo Setting for GALL

  SET ITK_PATH=%HOME%\build\vs2008\itk-3.20.1\bin\Release
  SET PLASTIMATCH_BASE=%HOME%\build\vs2008\plastimatch-3.20.1-dcmtk
  SET FFTW_PATH=%HOME%\build\fftw-3.2.2
  SET QT_PATH=C:\QT\4.7.4\bin

@rem  SET ITK_PATH=%HOME%\build\vs2008\itk-3.20.1\bin\Release
@rem  SET PLASTIMATCH_BASE=%HOME%\build\vs2008\plastimatch-3.20.1
@rem  SET FFTW_PATH=%HOME%\build\fftw-3.2.2
@rem  SET QT_PATH=C:\QT\4.7.4\bin

@rem  SET ITK_PATH=%HOME%\build\vs2010-64\itk-3.20.1\bin\Release
@rem  SET PLASTIMATCH_BASE=%HOME%\build\vs2010-64\plastimatch-3.20.1
@rem  SET FFTW_PATH=%HOME%\build\fftw-64
@rem  SET QT_PATH=C:\QT\4.7.4\bin

) else (
  echo "Sorry, couldn't recognize host"
  exit /b
)

SET PLASTIMATCH_PATH=%PLASTIMATCH_BASE%\Release

PATH=%PATH%;%FFTW_PATH%
PATH=%PATH%;%ITK_PATH%
PATH=%PATH%;%PLASTIMATCH_PATH%
PATH=%PATH%;%QT_PATH%

echo PATH set to:
PATH
