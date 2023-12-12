#!/bin/bash
cd /terraform/src;
# 環境変数が正常にセットされているか確認
# echo -e '\n\nenvironment';
# echo '$AWS_SECRET_ACCESS_KEY=' $AWS_SECRET_ACCESS_KEY;
# echo '$AWS_ACCESS_KEY_ID=' $AWS_ACCESS_KEY_ID;

# コンテナを稼働し続ける
tail -f /dev/null