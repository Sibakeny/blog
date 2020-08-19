FROM nginx:1.15.8

# インクルード用のディレクトリ内を削除
RUN rm -f /etc/nginx/conf.d/*

# Nginxの設定ファイルをコンテナにコピー
ADD nginx.conf /etc/nginx/conf.d/app_name.conf
ADD www.example.com.crt /etc/nginx/conf.d/www.example.com.crt
ADD www.example.com.csr /etc/nginx/conf.d/www.example.com.csr
ADD www.example.com.csr /etc/nginx/conf.d/www.example.com.key

RUN mkdir app_name
RUN mkdir app_name/tmp
RUN mkdir app_name/tmp/sockets

# ビルド完了後にNginxを起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf