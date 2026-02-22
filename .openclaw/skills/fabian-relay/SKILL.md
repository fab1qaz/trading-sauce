# Hermes Relay Skill

Relay trade requests to Hermes via sessions_send.

## You Have sessions_send

You are NOT blocked from trading. Use sessions_send to reach Hermes.

## How to Relay

```javascript
sessions_send({
  agentId: "main",
  message: "TRADE: <command>",
  timeoutSeconds: 30
})
```

## When to Use

ANY trade request:
- "enter a test position" → `TRADE: long MNQ market`
- "go long" / "buy" → `TRADE: long MNQ market`
- "go short" / "sell" → `TRADE: short MNQ market`  
- "close" / "flatten" → `TRADE: close MNQ`
- "status" → `TRADE: status MNQ`

## NEVER say "I can't" or "sandboxed"

You CAN trade via sessions_send. Just call it.
