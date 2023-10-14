


script_dir=$(cd "$(dirname "$0")" && pwd)

pid_file=".gitt/gitt.pid"
# source "$script_dir/rungitt.sh"


gitt_run() {
    # 检查后台任务是否已经在运行中
    if [ -f "$pid_file" ]; then
        echo "Background task is already running."
        exit 1
    fi

    # 启动后台任务并将其进程 ID 写入 PID 文件
    # echo $(gitt_run_ &) > "$pid_file"
    # script_dir=$(cd "$(dirname "$0")" && pwd)

    

    # echo $$
    # echo $$ > "$pid_file"
    # gitt_run_ &
    # echo $$
    bash $script_dir/rungitt.sh &
    echo $! > "$pid_file"
    # echo $!
    # echo "$pid_file"
}

gitt_stop() {
    # 检查后台任务是否正在运行
    if [ ! -f "$pid_file" ]; then
        echo "Background task is not running."
        exit 1
    fi

    # 从 PID 文件中读取后台任务的进程 ID 并杀死该进程
    pid=$(cat "$pid_file")
    kill "$pid"
    
    # 删除 PID 文件
    rm "$pid_file"
    
    echo "Background task stopped."
}

gitt_status() {
    if [ ! -f "$pid_file" ]; then
        echo "Background task is NOT running."
        exit 0
    fi
    echo "Background task is RUNNING."
}

gitt_setignore() {
    git config --global core.excludesFile "$script_dir/.gittignore"
}