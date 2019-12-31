#!/usr/bin/env bash
set -eu

ORIGINAL_PROJECT_NAME="Django Prod QuickStart"

# Define PYTHON_MODULE_ORIGINAL_NAME as lowercase and replace all spaces with underscores
PYTHON_MODULE_ORIGINAL_NAME=$(echo "ORIGINAL_PROJECT_NAME" | awk '{print tolower($0)}')
PYTHON_MODULE_ORIGINAL_NAME=${ORIGINAL_PROJECT_NAME// /_}

# Check that DJANGO_PROD_QUICKSTART_NAME has been provided as an environment variable
: "${DJANGO_PROD_QUICKSTART_NAME:?DJANGO_PROD_QUICKSTART_NAME must be set and non-empty. See README.}"

# Define PYTHON_MODULE_QUICKSTART_NAME as lowercase and replace all spaces with underscores
PYTHON_MODULE_QUICKSTART_NAME=$(echo "$DJANGO_PROD_QUICKSTART_NAME" | awk '{print tolower($0)}')
export PYTHON_MODULE_QUICKSTART_NAME=${PYTHON_MODULE_QUICKSTART_NAME// /_}

echo "Using $PYTHON_MODULE_QUICKSTART_NAME as Python module name for your project."

# Rename the Python module
mv "$PYTHON_MODULE_ORIGINAL_NAME" "$PYTHON_MODULE_QUICKSTART_NAME"
find . -name '*.{py,yml}' -exec sed -e "s/$PYTHON_MODULE_ORIGINAL_NAME/$PYTHON_MODULE_QUICKSTART_NAME/g" {} \;

# Rename project name in templates
find . -name '*.html' -exec sed -e "s/$ORIGINAL_PROJECT_NAME/$DJANGO_PROD_QUICKSTART_NAME/g" {} \;

echo "Finished code changes for $ORIGINAL_PROJECT_NAME ($PYTHON_MODULE_QUICKSTART_NAME). Follow README for next instructions."
