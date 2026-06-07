#!/usr/bin/env bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST_DIR="$SCRIPT_DIR/.vitepress/dist"
RUN_DIR="$SCRIPT_DIR/.run"
PID_FILE="$RUN_DIR/cloud-hub.pid"
LOG_FILE="$RUN_DIR/cloud-hub.log"
HOST="${HOST:-0.0.0.0}"
PORT="${PORT:-8080}"

mkdir -p "$RUN_DIR"

read_pid() {
  if [[ -f "$PID_FILE" ]]; then
    cat "$PID_FILE"
  fi
}

is_running() {
  local pid
  pid="$(read_pid)"
  [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null
}

cleanup_stale_pid() {
  if [[ -f "$PID_FILE" ]] && ! is_running; then
    rm -f "$PID_FILE"
  fi
}

start() {
  cleanup_stale_pid

  if is_running; then
    echo "DAU Cloud Hub is already running (PID $(read_pid))."
    return 0
  fi

  if [[ ! -f "$DIST_DIR/index.html" ]]; then
    echo "Build output not found: $DIST_DIR/index.html"
    echo "Run './cloud-hub.sh deploy' or 'npm run build' first."
    exit 1
  fi

  if command -v ss >/dev/null 2>&1 && ss -ltn | grep -q ":$PORT "; then
    echo "Port $PORT is already in use."
    exit 1
  fi

  nohup python3 "$SCRIPT_DIR/serve.py" \
    --directory "$DIST_DIR" \
    --port "$PORT" \
    --bind "$HOST" \
    > "$LOG_FILE" 2>&1 &
  echo "$!" > "$PID_FILE"

  sleep 1
  if is_running; then
    echo "DAU Cloud Hub started."
    echo "URL: http://$HOST:$PORT"
    echo "PID: $(read_pid)"
    echo "Log: $LOG_FILE"
  else
    echo "Failed to start DAU Cloud Hub. Check: $LOG_FILE"
    rm -f "$PID_FILE"
    exit 1
  fi
}

stop() {
  cleanup_stale_pid

  if ! is_running; then
    echo "DAU Cloud Hub is not running."
    return 0
  fi

  local pid
  pid="$(read_pid)"
  kill "$pid"

  for _ in {1..10}; do
    if ! kill -0 "$pid" 2>/dev/null; then
      rm -f "$PID_FILE"
      echo "DAU Cloud Hub stopped."
      return 0
    fi
    sleep 1
  done

  echo "Process $pid did not stop in time."
  echo "Check the process before terminating it manually."
  exit 1
}

status() {
  cleanup_stale_pid

  if is_running; then
    echo "DAU Cloud Hub is running (PID $(read_pid), port $PORT)."
  else
    echo "DAU Cloud Hub is not running."
    exit 1
  fi
}

logs() {
  touch "$LOG_FILE"
  tail -n 50 -f "$LOG_FILE"
}

build() {
  cd "$SCRIPT_DIR"
  npm run build
}

deploy() {
  cd "$SCRIPT_DIR"
  npm ci
  npm run build
  stop
  start
}

usage() {
  cat <<'EOF'
Usage: ./cloud-hub.sh <command>

Commands:
  start    Start the built site in the background
  stop     Stop the background server
  restart  Restart the background server
  status   Show the server status
  logs     Follow the server log
  build    Build the static site
  deploy   Install dependencies, build, and restart
EOF
}

case "${1:-}" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    stop
    start
    ;;
  status)
    status
    ;;
  logs)
    logs
    ;;
  build)
    build
    ;;
  deploy)
    deploy
    ;;
  *)
    usage
    exit 1
    ;;
esac
