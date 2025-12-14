---
title: Gate-level Simulation (Functional)
---

## 概要
本設計（VI Control ASIC）は、OpenLane（SKY130A）により
PnR 完走（DRC/LVS/STA clean）を確認済みである。

本章では **Gate-level FUNCTIONAL simulation** により、
RTL と論理等価であることを確認する。

- Simulator: iverilog
- PDK: SKY130A
- Mode: FUNCTIONAL（タイミング無視）

---

## シミュレーション条件

| 項目 | 内容 |
|---|---|
| Netlist | OpenLane final gate netlist |
| Timing | 無効（UNIT_DELAY） |
| UDP | 使用せず |
| 目的 | RTL との論理一致確認 |

---

## 結果サマリ

- リセットシーケンス：正常
- FSM 遷移：RTL と一致
- 出力（V–I）：全サイクル一致
- 不一致・X：なし

---

## 波形

### Reset / Init
![reset](assets/images/gate_sim/reset_seq.png)

### Normal Operation
![waveform](assets/images/gate_sim/waveform_ok.png)

---

## 考察
Gate-level FUNCTIONAL simulation により、
配置配線後も論理が保存されていることを確認した。

タイミング検証は STA により代替されており、
Gate-level timing simulation は実施していない。

