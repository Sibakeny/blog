FROM nginx


# Nginxの設定ファイルをコンテナにコピー
ADD nginx.conf /etc/nginx/conf.d/nginx.conf
ADD server.crt /etc/nginx/server.crt
ADD server.csr /etc/nginx/server.csr
ADD server.csr /etc/nginx/server.key
RUN chmod 400 /etc/nginx/server.key

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]