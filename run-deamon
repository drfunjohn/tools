pid=""
pidlist=()
function pstree {
    local pid=$1
    local pids=()
    local regexp=""

    while [[ -n $pid ]]
    do
        pids+=( $pid )
        # Get PID by PPID
        # regexp="^.* $pid$"
        regexp="^.* $pid$"
        pid=$( ps -o pid,ppid= | grep -E "$regexp" | awk '{print $1;}' )
    done
    echo "${pids[@]}"
}

$1 &
pid=$!
fswatch -r --event=Updated -l 3 -o -e ".*" -i "\\.go$" . | (while read line
do
    pidlist=( $( pstree $pid ) )
    clear
    echo "== Run Deamon: Restart service ============================================="
    echo "$line files was changed"
    echo "Kill ${#pidlist[@]} processes with  next PIDs:  ${pidlist[@]}"
    if [[ "${#pidlist[@]}" -gt "0" ]]; then 
        for p in ${pidlist[@]} 
        do
            kill -TERM -- $p 
        done
    fi
    pid=""
    pidlsit=()
    $1 &
    pid=$!
    echo "== Run Deamon: Service started ============================================="
done)

