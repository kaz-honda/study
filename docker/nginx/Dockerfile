FROM nginx:1.11.4-alpine

#
# apk packege
#
RUN apk update \
    && apk add --no-cache --virtual .nginx-deps \
        bash \
        openssl \
        expect

# entryKitのインストール
ENV ENTRYKIT_VERSION 0.4.0
RUN wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
    && mv entrykit /bin/entrykit \
    && chmod +x /bin/entrykit \
    && entrykit --symlink

# タイムゾーン
RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
    && apk del tzdata

#
# nginxのパラメータ
#
ENV NGX_SERVERNAME=study.stylagy.co.jp \
    NGX_SERVERPORT=4430 \
    NGX_DOCUMENTROOT=/docker

#
# SSL証明書の作成
#
ARG CRT_SERVER_NAME
COPY script/certificate.sh /usr/local/bin/certificate.sh
RUN /usr/local/bin/certificate.sh $CRT_SERVER_NAME

#
# 設定ファイルの配置
#
COPY config/nginx.conf.tmpl /etc/nginx/nginx.conf.tmpl
COPY config/study_nginx.conf.tmpl /etc/nginx/conf.d/study_nginx.conf.tmpl

#
# ゴミ掃除
#
RUN rm -f /etc/nginx/conf.d/default.conf

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["render", "/etc/nginx/nginx.conf", "/etc/nginx/conf.d/study_nginx.conf", "--", "nginx", "-g", "daemon off;"]
