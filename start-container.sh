#!/bin/bash
function getKeyValue(){
  keyname=$1
  cat ~/.aws/credentials | grep $keyname | sed -e "s/$keyname//" | sed -e 's/ = //g'
}

function setEnvs(){
  region="ap-northeast-1"
  echo "setting aws credentials from local"
  echo "AWS_ACCESS_KEY_ID"
  echo "AWS_SECRET_ACCESS_KEY"
  echo "AWS_DEFAULT_REGION"

  AWS_ACCESS_KEY_ID=$(getKeyValue aws_access_key_id)
  AWS_SECRET_ACCESS_KEY=$(getKeyValue aws_secret_access_key)
  AWS_DEFAULT_REGION=$(echo $region)
}

function envFile(){
  echo "AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}"
  echo "AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}"
  echo "AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}"
}

# PCのローカル環境にawsクレデンシャル情報を環境変数化
# 起動したコンテナで利用
setEnvs

envFile > .env

# .envをもとに環境変数を追加してコンテナを立ち上げる
docker compose up -d
# 起動時以外は不要なので削除
rm .env

echo "docker container exec -it terraform bin/bash"