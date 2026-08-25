@echo off
rem ==============================
rem
rem Build Godot Engine with SCons.
rem
rem ==============================

rem Move to the engine source directory.
set "PROJECT_ROOT=%~dp0"
cd /d "%PROJECT_ROOT%Engine"

rem Generate the Visual Studio project files.
scons platform=windows vsproj=yes
if errorlevel 1 goto :end

rem Put the solution in the repository root and point it to the project in Engine.
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command ^
    "$ErrorActionPreference = 'Stop';" ^
    "$source = [IO.Path]::GetFullPath('godot.sln');" ^
    "$target = [IO.Path]::Combine($env:PROJECT_ROOT, 'godot.sln');" ^
    "$quote = [char]34;" ^
    "$content = [IO.File]::ReadAllText($source);" ^
    "$content = $content.Replace($quote + 'godot.vcxproj' + $quote, $quote + 'Engine\godot.vcxproj' + $quote);" ^
    "[IO.File]::WriteAllText($target, $content, [Text.UTF8Encoding]::new($false));" ^
    "[IO.File]::Delete($source);"

:end
pause
