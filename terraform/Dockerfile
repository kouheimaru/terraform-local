FROM python:3.11

# 前提となるパッケージのインストール
RUN apt-get update && apt-get install -y vim wget unzip sudo

# Terraformインストール (執筆時点での最新版を導入してます。バージョン一覧 => https://releases.hashicorp.com/terraform/)
RUN wget https://releases.hashicorp.com/terraform/1.1.7/terraform_1.1.7_linux_amd64.zip \
  && unzip ./terraform_1.1.7_linux_amd64.zip -d /usr/local/bin/ \
  && rm ./terraform_1.1.7_linux_amd64.zip
# aws cli ostall
RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
  && unzip ./awscli-exe-linux-x86_64.zip -d /usr/local/bin/ \
  && rm ./awscli-exe-linux-x86_64.zip

RUN apt-get install zip unzip -y

RUN sudo /usr/local/bin/aws/install

# コンテナ内でコマンドエイリアスをつくるため(任意)
COPY --chmod=777 ../home/.bashrc /root/.bashrc
# ENTRYPOINTに指定するシェルファイル
COPY --chmod=777 ../home/entrypoint.sh /home/entrypoint.sh
# aws cli出力用の設定
RUN apt-get install less

ENTRYPOINT ["/home/entrypoint.sh"]
