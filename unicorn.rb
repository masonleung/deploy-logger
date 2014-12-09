working_directory "/srv/deploy-logger"

pid "/srv/deploy-logger/pids/unicorn.pid"

stderr_path "/srv/deploy-logger/logs/unicorn.log"
stdout_path "/srv/deploy-logger/logs/unicorn.log"

listen "/tmp/unicorn.myapp.sock"

worker_processes 1

timeout 30