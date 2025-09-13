#!/usr/bin/env bash
# Mullvad status for Waybar (icon + tooltip with IP + country, robust parsing)

ICON_CONNECTED=""
ICON_DISCONNECTED=""
ICON_CONNECTING=""
ICON_BLOCKED=""

escape_json() {
  local s="${1:-}"
  s="${s//\\/\\\\}"
  s="${s//\"/\\\"}"
  s="${s//$'\n'/\\n}"
  s="${s//$'\r'/}"
  s="${s//$'\t'/\\t}"
  printf "%s" "$s"
}

emit() {
  local text="$1" tip="$2" cls="$3"
  printf '{"text":"%s","tooltip":"%s","class":"%s"}\n' \
    "$(escape_json "$text")" \
    "$(escape_json "$tip")" \
    "$(escape_json "$cls")"
}

STATUS="$(mullvad status 2>/dev/null)"
STATE="$(printf "%s" "$STATUS" | grep -oE 'Connected|Disconnected|Connecting|Blocked' | head -1)"

case "$STATE" in
Connected)
  ICON="$ICON_CONNECTED"
  CLASS="connected"
  TIP="Connected"
  ;;
Connecting)
  ICON="$ICON_CONNECTING"
  CLASS="connecting"
  TIP="Connecting"
  ;;
Blocked)
  ICON="$ICON_BLOCKED"
  CLASS="blocked"
  TIP="Blocked"
  ;;
Disconnected | *)
  ICON="$ICON_DISCONNECTED"
  CLASS="disconnected"
  TIP="Disconnected"
  ;;
esac

if [ "$STATE" = "Connected" ]; then

  IP="$(printf "%s" "$STATUS" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | head -1)"
  # IPV6="$(printf "%s" "$STATUS" | grep -Eo '([0-9a-fA-F]{0,4}:){2,7}[0-9a-fA-F]{0,4}' | head -1)"

  COUNTRY="$(printf "%s" "$STATUS" | sed -n 's/.*(\(.*\)).*/\1/p' | head -1)"

  if [ -z "$COUNTRY" ]; then
    RELAY="$(mullvad relay get 2>/dev/null | tr -s ' ' | head -n 5)"
    COUNTRY="$(printf "%s" "$RELAY" | sed -n 's/.*[Cc]ountry[: ]\+\(.*\)/\1/p' | head -1)"
    if [ -z "$COUNTRY" ]; then
      CODE="$(printf "%s" "$RELAY" | grep -Eo '\b[a-z]{2}-[a-z0-9-]+' | head -1 | cut -d- -f1 | tr '[:lower:]' '[:upper:]')"
      [ -n "$CODE" ] && COUNTRY="$CODE"
    fi
  fi

  if [ -n "$IP" ] && [ -n "$COUNTRY" ]; then
    TIP="Connected - $IP ($COUNTRY)"
  elif [ -n "$IP" ]; then
    TIP="Connected - $IP"
  elif [ -n "$COUNTRY" ]; then
    TIP="Connected - ($COUNTRY)"
  else
    TIP="Connected"
  fi
fi

emit "$ICON" "$TIP" "$CLASS"
