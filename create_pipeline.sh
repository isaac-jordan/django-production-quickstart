#!/usr/bin/env bash

shopt -s failglob
set -eu -o pipefail

# Define PIPELINE_QUICKSTART_NAME as lowercase and replace all spaces with underscores
PIPELINE_QUICKSTART_NAME=$(echo "$DJANGO_PROD_QUICKSTART_NAME" | awk '{print tolower($0)}')
export PIPELINE_QUICKSTART_NAME=${PIPELINE_QUICKSTART_NAME// /-}

# Replace any placeholders in pipeline.yml, primarily for first-time runs
sed "s/GITHUB_USER_PLACEHOLDER/$GITHUB_USER/g" pipeline.yml > pipeline-edited.yml
mv pipeline-edited.yml pipeline.yml
sed "s/GITHUB_REPO_PLACEHOLDER/$GITHUB_REPO/g" pipeline.yml > pipeline-edited.yml
mv pipeline-edited.yml pipeline.yml
sed "s/PIPELINE_NAME_PLACEHOLDER/$PIPELINE_QUICKSTART_NAME-test-and-deploy/g" pipeline.yml > pipeline-edited.yml
mv pipeline-edited.yml pipeline.yml
sed "s/APP_STACK_NAME_PLACEHOLDER/$PIPELINE_QUICKSTART_NAME-app-stack/g" pipeline.yml > pipeline-edited.yml
mv pipeline-edited.yml pipeline.yml

PIPELINE_STACK_NAME="$PIPELINE_QUICKSTART_NAME-codepipeline-stack"

# Mostly copied from https://gist.github.com/mdjnewman/b9d722188f4f9c6bb277a37619665e77
# and https://github.com/symphoniacloud/github-codepipeline

echo "Checking if stack exists ..."

if ! aws cloudformation describe-stacks --stack-name "$PIPELINE_STACK_NAME" ; then

  echo -e "\nStack does not exist, creating ..."
  aws cloudformation create-stack \
    --stack-name "$PIPELINE_STACK_NAME" \
    --capabilities CAPABILITY_IAM \
    --parameters ParameterKey=GitHubOAuthToken,ParameterValue=$GITHUB_OAUTH_TOKEN \
    --template-body file://pipeline.yml

  echo "Waiting for stack to be created ..."
  aws cloudformation wait stack-create-complete \
    --stack-name "$PIPELINE_STACK_NAME"

else

  echo -e "\nStack exists, attempting update ..."

  set +e
  update_output=$( aws cloudformation update-stack \
    --stack-name "$PIPELINE_STACK_NAME" \
    --capabilities CAPABILITY_IAM \
    --parameters ParameterKey=GitHubOAuthToken,ParameterValue=$GITHUB_OAUTH_TOKEN \
    --template-body file://pipeline.yml \
    2>&1)
  status=$?
  set -e

  echo "$update_output"

  if [ $status -ne 0 ] ; then

    # Don't fail for no-op update
    if [[ $update_output == *"ValidationError"* && $update_output == *"No updates"* ]] ; then
      echo -e "\nFinished create/update - no updates to be performed"
      exit 0
    else
      exit $status
    fi

  fi

  echo "Waiting for stack update to complete ..."
  aws cloudformation wait stack-update-complete \
    --stack-name "$PIPELINE_STACK_NAME"

fi

echo "Finished create/update successfully!"