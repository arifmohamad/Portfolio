#!/bin/bash

# build_env.sh

# Step 1: Create a virtual environment
ENV_NAME="venv"

# Check if the environment already exists, if not, create it
if [ ! -d "$ENV_NAME" ]; then
  python3 -m venv $ENV_NAME
  echo "Virtual environment '$ENV_NAME' created."
else
  echo "Virtual environment '$ENV_NAME' already exists."
fi

# Step 2: Activate the virtual environment
source $ENV_NAME/bin/activate

# Step 3: Install the required packages from requirements.txt
if [ -f "requirements.txt" ]; then
  echo "Installing packages from requirements.txt..."
  pip install -r requirements.txt
  echo "Packages installed successfully."
else
  echo "requirements.txt not found!"
fi

# Step 4: Confirm installation
pip freeze

# Step 5: creating jupyter kernel

python3 -m ipykernel install --user --name=venv-kernel