BLOG

# 概要

  ブログ管理
  思いついたものを、好きな様にやりたい様に適当に開発

# Requirement

"hoge"を動かすのに必要なライブラリなどを列挙する

* huga 3.5.2
* hogehuga 1.0.2

# Installation

```bash
docker-compose up
docker-compose exec web rails db:migrate
```

# Usage

.envに

```bash
QIITA_ACCESS_TOKEN=********
```

をセットすればキータから記事を自動的に取ってこれる

# Note

まだまだ開発途中
デザインに関してはとにかく迷走



 
# Author
 
作成情報を列挙する
 
* 作成者 [sibakeny](https://github.com/Sibakeny)
* E-mail sbkn0919@gmail.com
 
# License

[MIT license](https://en.wikipedia.org/wiki/MIT_License).

# ECS DEPLOY

```bash
ecs-cli configure --cluster sbkn-blog --default-launch-type EC2 --config-name sbkn-blog --region ap-northeast-1
ecs-cli configure profile --access-key access_key --secret-key secret_key --profile-name sbkn-blog-profile
ecs-cli compose --project-name sbkn-blog -f docker-compose-production.yml create --region ap-northeast-1 --cluster-config sbkn-blog --ecs-profile sbkn-blog-profile --cluster sbkn-blog
```
