---
name: notification
description: Send a macOS system notification with a message and sound
---

Send a macOS notification using the message provided by the user (or a default message if none is given).

Use this command to send the notification:
```
osascript << 'EOF'
display notification "<message>" with title "Claude Code" sound name "default"
EOF
```

Replace `<message>` with the user's requested message. If no message is specified, use "Task complete!" as the default.

## Scheduled notifications

If the user asks to be notified **at a future time** or **after a delay**, use `CronCreate` with `recurring: false` instead of `sleep`. The cron prompt should invoke this skill with the message, e.g.:

> `Send me a macOS notification saying "You have a call!"`

Calculate the target wall-clock time from the current time and the requested delay, then pin minute/hour/day-of-month/month accordingly. Never use `sleep` for scheduling.
