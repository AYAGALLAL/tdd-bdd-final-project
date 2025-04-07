#!/bin/bash
echo "**************************************************"
echo " Setting up TDD/BDD Final Project Environment"
echo "**************************************************"

# Check if running in Git Bash on Windows
if [[ "$OSTYPE" == "msys" ]]; then
  echo "*** Windows (Git Bash) detected - using Windows-specific setup"
  
  # Python installation (assuming Python 3.9+ is already installed and in PATH)
  echo "*** Checking Python version..."
  python --version || (
    echo "ERROR: Python not found. Please install Python 3.9+ from python.org and check 'Add to PATH' during installation."
    exit 1
  )

  # Virtual environment
  echo "*** Creating Python virtual environment..."
  python -m venv venv || (
    echo "ERROR: Failed to create virtual environment"
    exit 1
  )

  # Activate venv (Windows path)
  echo "*** Activating virtual environment..."
  source venv/Scripts/activate || (
    echo "ERROR: Failed to activate virtual environment"
    exit 1
  )

  # Install Python dependencies
  echo "*** Installing Python dependencies..."
  pip install --upgrade pip wheel || exit 1
  pip install -r requirements.txt || exit 1

  # Docker setup
  echo "*** Checking Docker..."
  docker --version || (
    echo "ERROR: Docker not found. Please install Docker Desktop from docker.com and ensure it's running."
    exit 1
  )

  # Start PostgreSQL container
  echo "*** Starting PostgreSQL container..."
  docker run --name postgres \
    -e POSTGRES_PASSWORD=postgres \
    -v postgres:/var/lib/postgresql/data \
    -p 5432:5432 \
    -d postgres:alpine || (
    echo "ERROR: Failed to start PostgreSQL container"
    exit 1
  )

  # Verify container
  echo "*** Checking running containers..."
  docker ps

else
  echo "ERROR: This script is only configured for Windows Git Bash"
  exit 1
fi

echo "**************************************************"
echo " TDD/BDD Final Project Environment Setup Complete"
echo "**************************************************"
echo ""
echo "Use 'exit' to close this terminal and open a new one to initialize the environment"
