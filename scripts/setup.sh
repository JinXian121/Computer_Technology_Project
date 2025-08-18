#!/bin/bash
# One-Click Dev Setup for Unix-based systems (macOS, Linux)

echo "🔧 Setting up your development environment..."

# 1. Clone repository (User needs to replace the URL)
echo "👉 Cloning the team repository... (Please replace the URL in this script)"
# git clone https://github.com/YOUR-TEAM/YOUR-REPO.git
# cd YOUR-REPO

# 2. Install recommended VSCode extensions
echo "🧠 Installing recommended VSCode extensions..."
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint
code --install-extension github.vscode-pull-request-github

# 3. Install dependencies (Example for a NodeJS project)
if [ -f package.json ]; then
  echo "📦 Found package.json, installing Node packages..."
  npm install
fi

echo "✅ Setup complete. Open the project in VSCode and start coding!"
