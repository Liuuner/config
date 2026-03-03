#!/usr/bin/env bash

start_time=$(date +%s)

# Run command
"$@"
status=$?

end_time=$(date +%s)
duration=$((end_time - start_time))

SUCCESS_SOUND="/usr/share/sounds/freedesktop/stereo/complete.oga"
FAIL_SOUND="/usr/share/sounds/freedesktop/stereo/dialog-error.oga"

if command -v notify-send >/dev/null 2>&1; then
    if [ $status -eq 0 ]; then
        notify-send "✅ Command finished in ${duration}s" "$*"
    else
        notify-send "❌ Command failed (exit $status) after ${duration}s" "$*"
    fi
fi

if command -v paplay >/dev/null 2>&1; then
    if [ $status -eq 0 ] && [ -f "$SUCCESS_SOUND" ]; then
        paplay "$SUCCESS_SOUND"
    elif [ -f "$FAIL_SOUND" ]; then
        paplay "$FAIL_SOUND"
    fi
else
    echo -e "\a"
fi


exit $status
