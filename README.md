# ECS DEPLOY

ecs-cli configure --cluster sbkn-blog --default-launch-type EC2 --config-name sbkn-blog --region ap-northeast-1
ecs-cli configure profile --access-key access_key --secret-key secret_key --profile-name sbkn-blog-profile
ecs-cli compose --project-name sbkn-blog -f docker-compose-production.yml create --region ap-northeast-1 --cluster-config sbkn-blog --ecs-profile sbkn-blog-profile --cluster sbkn-blog
