#!/usr/bin/env bash
set -euo pipefail

RAW_TEXT="${1:-}"
CHAT_ID="${2:-}"

if [[ -z "$RAW_TEXT" ]]; then
  echo "Usage: sauce_command.sh \"<command-or-request>\" [chat_id]" >&2
  exit 2
fi

lower="$(printf '%s' "$RAW_TEXT" | tr '[:upper:]' '[:lower:]')"
text="$(printf '%s' "$RAW_TEXT" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"

if [[ "$text" != /* ]]; then
  if [[ "$lower" == *"backtest"* ]]; then
    text="/backtest"
  elif [[ "$lower" == *"sweep"* ]]; then
    text="/sweep"
  elif [[ "$lower" == *"news"* ]]; then
    text="/news"
  elif [[ "$lower" == *"pic"* || "$lower" == *"screenshot"* || "$lower" == *"chart"* ]]; then
    text="/pic day"
  fi
fi

WORKER_BASE="${WORKER_URL:-https://vwap-webhook.gorka-molero.workers.dev}"
WORKER_BASE="${WORKER_BASE%/}"

SECRET="${WEBHOOK_SECRET:-}"
if [[ -z "$SECRET" && -f "/Users/gorkolas/www/mercurius/.env" ]]; then
  SECRET="$(grep -E '^WEBHOOK_SECRET=' /Users/gorkolas/www/mercurius/.env | tail -n1 | cut -d= -f2-)"
fi
if [[ -z "$SECRET" && -f "$HOME/.openclaw/.env" ]]; then
  SECRET="$(grep -E '^WEBHOOK_SECRET=' "$HOME/.openclaw/.env" | tail -n1 | cut -d= -f2-)"
fi

if [[ -z "$SECRET" ]]; then
  echo "Missing WEBHOOK_SECRET; cannot call Worker /command." >&2
  exit 3
fi

if command -v jq >/dev/null 2>&1; then
  if [[ -n "$CHAT_ID" ]]; then
    payload="$(jq -nc --arg text "$text" --argjson chatId "$CHAT_ID" '{text:$text,chatId:$chatId}')"
  else
    payload="$(jq -nc --arg text "$text" '{text:$text}')"
  fi
else
  python3 - "$text" "$CHAT_ID" > /tmp/sauce_payload.json <<'PY'
import json,sys
text=sys.argv[1]
chat=sys.argv[2]
obj={"text":text}
if chat:
    try:
        obj["chatId"]=int(chat)
    except Exception:
        pass
print(json.dumps(obj))
PY
  payload="$(cat /tmp/sauce_payload.json)"
fi

resp="$(curl -sS -X POST "${WORKER_BASE}/command?secret=${SECRET}" -H 'Content-Type: application/json' -d "$payload")"

if command -v jq >/dev/null 2>&1; then
  ok="$(printf '%s' "$resp" | jq -r '.ok // false')"
  if [[ "$ok" == "true" ]]; then
    printf '%s\n' "$(printf '%s' "$resp" | jq -r '.reply // "ok"')"
  else
    err="$(printf '%s' "$resp" | jq -r '.error // .message // "Command failed"')"
    printf 'Command failed: %s\n' "$err" >&2
    exit 1
  fi
else
  printf '%s\n' "$resp"
fi

