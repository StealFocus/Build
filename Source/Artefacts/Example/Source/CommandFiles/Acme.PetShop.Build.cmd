@ECHO OFF
ECHO Please select a build type to run.
ECHO.
ECHO - Full build (Debug and Release configurations)
ECHO - Quick build (Debug configuration only)
ECHO.
:question
SET /p buildChoice=Please enter F (for Full build) or Q (for Quick build): 
IF /i %buildChoice% == f (
ECHO.
%windir%\Microsoft.NET\Framework64\v4.0.30319\msbuild.exe ..\Scripts\Acme.PetShop.Build.proj  /consoleloggerparameters:Verbosity=minimal /fileLogger /fileLoggerParameters:LogFile=SolutionBuild.msbuild.log;verbosity=diagnostic
) ELSE (
	IF /i %buildChoice% == q (
	ECHO.
	%windir%\Microsoft.NET\Framework64\v4.0.30319\msbuild.exe ..\Scripts\Acme.PetShop.Build.proj /p:BuildReleaseConfiguration=false /consoleloggerparameters:Verbosity=minimal /fileLogger /fileLoggerParameters:LogFile=SolutionBuild.msbuild.log;verbosity=diagnostic
	) ELSE (
		ECHO.
		ECHO Invalid selection
		ECHO.
		goto :question
	)
)
ECHO.
pause
