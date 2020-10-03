  # set lets
  $worker  = 2
  $timeout = 30
  $app_dir = "/home/ec2-user/sbknblog" #自分のアプリケーション名
  $listen  = "#{$app_dir}/shared/tmp/sockets/unicorn.sock"
  $pid     = "#{$app_dir}/shared/tmp/pids/unicorn.pid"
  $std_log = "#{$app_dir}/shared/log/unicorn.stdout.log"
  # set config
  worker_processes  $worker
  working_directory "#{$app_dir}/current"
  stderr_path $std_log
  stdout_path $std_log
  timeout $timeout
  listen  $listen
  pid $pid
  # loading booster
  preload_app true
  # before starting processes
  before_fork do |server, worker|
    defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
    old_pid = "#{server.config[:pid]}.oldbin"
    if old_pid != server.pid
      begin
        Process.kill "QUIT", File.read(old_pid).to_i
      rescue Errno::ENOENT, Errno::ESRCH
      end
    end
  end
  # after finishing processes
  after_fork do |server, worker|
    defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
  end
