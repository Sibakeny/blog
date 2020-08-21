FROM nginx:1.15.8

# インクルード用のディレクトリ内を削除
RUN rm -f /etc/nginx/conf.d/*

# Nginxの設定ファイルをコンテナにコピー
ADD nginx.conf /etc/nginx/conf.d/app_name.conf
ADD server.crt /etc/nginx/conf.d/server.crt
ADD server.csr /etc/nginx/conf.d/server.csr
ADD server.csr /etc/nginx/conf.d/server.key
RUN chmod 400 /etc/nginx/conf.d/server.key

RUN mkdir app_name
RUN mkdir app_name/tmp
RUN mkdir app_name/tmp/sockets

# ビルド完了後にNginxを起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf