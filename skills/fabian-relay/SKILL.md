# Fabian Relay Skill

Relay messages to fabian-dev (the trading coach agent) when users need coaching assistance.

## When to Use

Relay to fabian-dev when:
- User asks for trading advice or coaching
- User wants to log a trade for review
- User mentions "fabian", "coach", or "relay"
- User asks questions about their trading performance
- User needs help with risk management or trade review

## How to Relay

Use `sessions_send` to message fabian-dev:

```
sessions_send(
  label: "fabian-dev",
  message: "<user's message or question>"
)
```

## Message Format

When relaying, include context:
```
[Relay from <username>]: <their message>
```

## Example

User says: "Can you ask the coach about my NQ setup today?"

You do:
```
sessions_send(
  label: "fabian-dev", 
  message: "[Relay from @username]: Asking about their NQ setup today"
)
```

Then wait for response and relay it back to the user.

## Notes

- fabian-dev has context on Fabian's trading journey, account sizes, risk rules
- Don't relay casual chat — only trading-related queries
- If fabian-dev doesn't respond within 30s, let user know and try again later
