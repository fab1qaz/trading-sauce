# V1 Spec - Todos for Codex Agent

## Date: 2026-02-15

### V1 Final Logic (Fabian's 7-Week Backtest)

**Results:** 987.75 pts | 24 traded days | 41.16 pts/day expectancy | 58.33% WR | 6.33 RR

**Bullish setup flow:**
1. Wait for 9:30 open! 1 Trade a day!
2. 5m close OUTSIDE 1.5 ES + 2 MNQ (same time) - "BREAKOUT CONFIRMED!"
3. Double bear candle (same time and no dirty wick)
4. Double bull candle (same time)
5. Enter with bracket (if price just closed over 1.93 SD on MNQ, enter in opp direction)
6. Flatten at 4:15 EST if trade still running (or first bullish MNQ candle after 12pm on a day where market closes at 1pm.)

**Dirty Wick Invalidation (Bullish setup):**
- On pullback candle only (5m timeframe)
- Double bear candle closes >1.1σ AND wicks <0.3σ = INVALIDATED
- MNQ only (not ES)
- All candles on 5m timeframe

**Bracket:**
- 15 SL / 95 TP (55pt trail at 80)
- Logic: need 53+ trail in one case so 55 covers. Need 12+ MAE so 15 SL covers.

---

### Todos

- [ ] Log should show when dirty wick kills a confirmed breakout — label as "no trade day - dirty wick"
- [ ] Dirty wick check on MNQ only
- [ ] Fabian wants time of dirty wick shown in log
- [ ] **EVERY pullback candle** must run dirty wick check on MNQ — clarification: after bullish breakout confirmed (ES close >1.5σ AND MNQ close >2.0σ), while watching for dual bearish pullback candles, run dirty wick invalidation on ALL MNQ bearish candles (not just the first two). If ANY MNQ bearish candle has close >1.1σ AND wick <0.3σ = dirty wick = no trade day.

---

### Optimization Target (Fabian, Feb 15)
- **Objective: Max Profit Factor** — PF is the only metric that matters for a bot
- Baseline to beat: 10/80 at PF 1.20
- Win rate doesn't matter for bot execution — only PF
- Fabian wants bracket optimization sweep when Gorka re-enables custom params
- Dynamic TP/SL also worth exploring (Gorka's idea)

*Updated by Sauce Bot — will keep adding as Fabian/Gorka provide more*
