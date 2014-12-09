working_directory "/srv/deploy-logger/current"

pid "/srv/deploy-logger/shared/pids/unicorn.pid"

stderr_path "/srv/deploy-logger/shared/logs/unicorn.log"
stdout_path "/srv/deploy-logger/shared/logs/unicorn.log"

listen "/tmp/unicorn.myapp.sock"

worker_processes 2

timeout 30