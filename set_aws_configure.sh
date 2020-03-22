#!/usr/bin/env bash
configure_aws_cli(){
  if [[ -z $AWS_ACCESS_KEY_ID || -z $AWS_SECRET_ACCESS_KEY || -z $AWS_DEFAULT_REGION ]]; then
    echo 'Should be defined : AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION'
    exit 1
  fi

  aws configure set profile.cs1u.aws_access_key_id $AWS_ACCESS_KEY_ID
  aws configure set profile.cs1u.aws_secret_access_key $AWS_SECRET_ACCESS_KEY
  aws configure set profile.cs1u.region $AWS_DEFAULT_REGION
  aws configure set profile.cs1u.output json
}

configure_aws_cli
