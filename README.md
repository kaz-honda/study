# study
js,cssフロントエンド勉強要

# ローカル環境構築手順

### コンテナ一覧

| コンテナ名            | 用途                     | 備考 |
|-----------------------|--------------------------|------|
| front_nginx_container | WEBサーバ |      |
| front_php_container   | Appサーバ |      |
| mysql_container       | DB(MySQL)サーバ          |      |
| mysql_test_container  | DB(MySQL)テストサーバ          |      |
| memcached_container    | KVS(memcached)サーバ     |      |

### Git Clone
* ベースのディレクトリは各自任意の名前で良いです。

```
mkdir ~/work
cd ~/work

# リポジトリをクローン
$ git clone git@github.com:kaz-honda/study.git study
```

### コミットテンプレート更新（初回のみ）
```
$ cd ~/work/study
$ git config commit.template $(pwd)/.gitmessage
```

### Docker for Macをインストール
* 以下のURLからstable版をダウンロードしてインストール
 * https://docs.docker.com/docker-for-mac/

* バージョン確認（2016/12/24 時点）

 ```
 $ docker --version
 Docker version 1.12.5, build 7392c3b
 $ docker-compose --version
 docker-compose version 1.9.0, build 2585387
 $ docker-machine --version
 docker-machine version 0.8.2, build e18a919
 ```

### 起動 ※初回は10分位かかる
```shell
$ cd ~/work/study
$ docker-compose up -d
```

### 動作確認
* 以下のURLにアクセスして画面(phpinfo)が出ればOK
```shell
$ open https://localhost/phpinfo.php
```

* phpmyadmin ※DBを使用したいなどあれば使う。studyというスキーマのみ作成済。
```shell
$ open http://localhost:8181/
```

## コンテナ操作方法

### 停止
```
$ cd ~/work/study
$ docker-compose stop
```

### 起動確認
```
$ cd ~/work/study
$ docker-compose ps

        Name                       Command               State                     Ports
----------------------------------------------------------------------------------------------------------
front_nginx_container   render /etc/nginx/nginx.co ...   Up       0.0.0.0:443->443/tcp, 0.0.0.0:80->80/tcp
front_php_container     php-fpm                          Up       0.0.0.0:9010->9000/tcp
memcached_contaier      docker-entrypoint.sh memcached   Up       0.0.0.0:11212->11211/tcp
mysql_container         docker-entrypoint.sh mysqld      Up       0.0.0.0:3307->3306/tcp
mysql_test_container    docker-entrypoint.sh mysqld      Up       0.0.0.0:3310->3306/tcp
phpmyadmin-container    /run.sh phpmyadmin               Up       0.0.0.0:8181->80/tcp
```

### 起動(特定のコンテナのみ)
```
$ cd ~/work/study
$ docker-compose up front_php
```

### コンテナにログイン
```shell
$ cd ~/work/study
$ docker-compose exec front_php ash
```
