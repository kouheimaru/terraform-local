## 前提環境
aws cli
git bash
docker

## ローカルでのコンテナの起動までの手順

### (1)コンテナのイメージを作成

初回のみ（イメージがない場合）

```
sh build-image.sh
```

### (2)コンテナの起動する

```
sh start-container.sh
```

## terraformのコマンド実行まで

コンテナに入る
```
docker container exec -it terraform bin/bash
```

作業ディレクトリに移動
```
cd terraform/src
```

terraformを初期化
```
terraform init
```

tfファイルを作成したら、terraformの検証実行
```
terraform plan
```

問題なければ、awsリソースに適用
```
terraform apply
```

## 後片付け

### terraformで作成したawsリソースを削除
使用したsrc配下のtfファイルをコメントアウトした後に

```
terraform plan
terraform apply
```

### コンテナの片付け

コンテナを停止する
```
sh kill-container.sh
```

イメージを削除（容量もったいないなら・・）
```
sh delete-image.sh
```


