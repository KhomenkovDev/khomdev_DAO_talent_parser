#!/bin/bash

# Configuration
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$PROJECT_DIR/.venv"

echo "🚀 Starting environment repair for AIResumeanalyzer..."

# 1. Remove broken venv
if [ -d "$VENV_DIR" ]; then
    echo "🗑️  Removing corrupted .venv directory..."
    rm -rf "$VENV_DIR"
fi

# 2. Recreate venv
echo "🛠️  Creating new virtual environment using Python 3..."
python3 -m venv "$VENV_DIR"

if [ $? -ne 0 ]; then
    echo "❌ Error: Failed to create virtual environment. Please ensure python3 is installed."
    exit 1
fi

# 3. Upgrade pip and install requirements
echo "📦 Installing dependencies from requirements.txt..."
"$VENV_DIR/bin/pip" install --upgrade pip
"$VENV_DIR/bin/pip" install -r "$PROJECT_DIR/requirements.txt"

if [ $? -ne 0 ]; then
    echo "❌ Error: Failed to install dependencies."
    exit 1
fi

echo "✅ Environment repair complete!"
echo ""
echo "👉 FINAL STEPS IN PYCHARM:"
echo "1. Open PyCharm Settings -> Project: AIResumeanalyzer -> Python Interpreter."
echo "2. Click 'Add Interpreter' -> 'Add Local Interpreter...'."
echo "3. Select 'Existing' and browse to: $VENV_DIR/bin/python"
echo "4. Click OK and wait for indexing."
echo ""
echo "🚀 To run the app: streamlit run ResumeAnalyzer.py"
