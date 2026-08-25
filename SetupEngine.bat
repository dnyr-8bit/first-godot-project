@echo off
rem ==============================
rem
rem GodotEngineをSconsでビルドするために必要な依存ライブラリをインストールするbat
rem
rem ==============================

rem フォルダ移動
cd /d "%~dp0"
cd Engine

rem 必要な依存ライブラリのダウンロード
python misc/scripts/install_accesskit.py
python misc/scripts/install_d3d12_sdk_windows.py
python misc/scripts/install_angle.py

pause