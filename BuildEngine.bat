@echo off
rem ==============================
rem
rem GodotEngineをSconsでビルドするbat
rem
rem ==============================

rem フォルダ移動
cd /d "%~dp0"
cd Engine

rem ビルド
scons platform=windows vsproj=yes

pause