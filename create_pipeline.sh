#!/usr/bin/env bash

set -eu

# Inspired by https://github.com/symphoniacloud/github-codepipeline

# Define PIPELINE_QUICKSTART_NAME as lowercase and replace all spaces with underscores
PIPELINE_QUICKSTART_NAME=$(echo "$DJANGO_PROD_QUICKSTART_NAME" | awk '{print tolower($0)}')
export PIPELINE_QUICKSTART_NAME=${PIPELINE_QUICKSTART_NAME// /-}

sed -i "s/GITHUB_USER_PLACEHOLDER/$GITHUB_USER/g" pipeline.yml
sed -i "s/GITHUB_REPO_PLACEHOLDER/$GITHUB_REPO/g" pipeline.yml
sed -i "s/PIPELINE_NAME_PLACEHOLDER/$PIPELINE_QUICKSTART_NAME-test-and-deploy/g" pipeline.yml
sed -i "s/APP_STACK_NAME_PLACEHOLDER/$PIPELINE_QUICKSTART_NAME-app-stack/g" pipeline.yml

aws cloudformation create-stack \
        --capabilities CAPABILITY_IAM \
        --stack-name "$PIPELINE_QUICKSTART_NAME-codepipeline-stack" \
        --parameters ParameterKey=GitHubOAuthToken,ParameterValue=$GITHUB_OAUTH_TOKEN \
        --template-body file://pipeline.yml
