---
name: sauce-command-bridge
description: Run Mercurius Worker commands from chat. Use when users ask for backtests, sweeps, news checks, chart screenshots, or alert acknowledgements. Triggers on requests like "backtest", "run a backtest", "/backtest", "/sweep", "/news", "/pic", "/ack", or similar natural-language asks.
---

# Sauce Command Bridge

Execute Sauce tooling through the live Worker command endpoint instead of claiming sandbox limitations.

## Mandatory Rule

If the user asks to run a backtest/sweep/news/pic/ack command, do not answer with "I can't run it."
Use the bridge script.

## Command Mapping

- Natural language "run backtest" -> `/backtest`
- Natural language "run sweep" -> `/sweep`
- Natural language "news" -> `/news`
- Natural language "pic/chart screenshot" -> `/pic day`
- Natural language "ack <id>" -> `/ack <id>`

If the user provides exact slash command text, pass it through unchanged.

## Execute

```bash
bash skills/sauce-command-bridge/scripts/sauce_command.sh "/backtest 20 80"
```

Optional `chatId` (needed for some `/pic`/`/ack` flows):

```bash
bash skills/sauce-command-bridge/scripts/sauce_command.sh "/pic day" "-1001234567890"
```

## Output Handling

- On success: return the worker reply directly to the user.
- On error: return concise actionable error + one valid command example.

## Interpretation Guardrails

Do not invent implementation caveats that were not returned by the Worker.

For `/backtest`, do not claim "this is raw mechanical without Fabian filters" unless the command explicitly disabled/overrode them.
Default `/backtest` in this stack uses the canonical Worker backtest path and V1 preset defaults.

If results diverge from a manual sheet, explain with concrete factors only:
- different date range / sample window
- different data source / candle history coverage
- different explicit parameter overrides
