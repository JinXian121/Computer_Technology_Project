@echo off
REM One-Click Dev Setup for Windows

echo 🔧 Setting up your development environment...

REM 1. Clone repository (User needs to replace the URL)
echo 👉 Cloning the team repository... (Please replace the URL in this script)
REM git clone https://github.com/AKNiS-TEST/Uni_Template_TEST.git
REM cd YOUR-REPO

REM 2. Install recommended VSCode extensions
echo 🧠 Installing recommended VSCode extensions...
call code --install-extension esbenp.prettier-vscode
call code --install-extension dbaeumer.vscode-eslint
call code --install-extension github.vscode-pull-request-github

REM 3. Install dependencies (Example for a NodeJS project)
IF EXIST package.json (
  echo 📦 Found package.json, installing Node dependencies...
  call npm install
)

echo ✅ Setup complete!
pause
