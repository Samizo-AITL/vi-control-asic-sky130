# 付録A：図一覧（Figure List）

本付録では、本プロジェクトで使用するすべての図について、  
**図の役割・検証フェーズ・設計レイヤ**を一覧表として整理する。

---

## A.1 制御・検証フロー関連図

| No. | 図 | 説明 |
|---|---|---|
| A-01 | <img src="http://samizo-aitl.github.io/vi-control-asic-sky130/docs/assets/images/openlane/spm_layout_overview.png" width="30%"> | OpenLane 実行途中における標準セル配置配線の可視化。配置、電源レール、配線が成立していることを示す説明用レイアウト図。 |
| A-02 | <img src="http://samizo-aitl.github.io/vi-control-asic-sky130/docs/assets/images/openlane/tb_vi_control_fsm_01.png" width="30%"> | FSM を含む制御ロジックの外部挙動確認。ADC（V–I）入力に対して PWM が生成されることを波形で検証。 |
| A-03 | <img src="http://samizo-aitl.github.io/vi-control-asic-sky130/docs/assets/images/openlane/tb_vi_control_fsm_state_01.png" width="30%"> | FSM 内部状態（state、SPI フェーズ、レジスタ制御）の遷移確認。FSM 実装の正当性検証用。 |
| A-04 | <img src="http://samizo-aitl.github.io/vi-control-asic-sky130/docs/assets/images/openlane/tb_vi_control_github_rtl_01.png" width="30%"> | GitHub 公開 RTL を用いた FSM 動作確認。公開版 RTL が正しく動作することの再現性検証。 |

---

## A.2 PID 制御演算検証図

| No. | 図 | 説明 |
|---|---|---|
| A-05 | <img src="http://samizo-aitl.github.io/vi-control-asic-sky130/docs/assets/images/openlane/tb_vi_control_pid_p_step_01.png" width="30%"> | PID の P 成分のみを有効にしたステップ応答検証。比例制御の基本動作確認。 |
| A-06 | <img src="http://samizo-aitl.github.io/vi-control-asic-sky130/docs/assets/images/openlane/tb_vi_control_pid_pi_step_01.png" width="30%"> | PI 制御によるステップ応答。積分項により定常誤差が解消されることを確認。 |

---

## A.3 PWM–V/I 応答検証図

| No. | 図 | 説明 |
|---|---|---|
| A-07 | <img src="http://samizo-aitl.github.io/vi-control-asic-sky130/docs/assets/images/openlane/tb_vi_control_pwm_vi_wave_01.png" width="30%"> | PWM 出力と電圧・電流（V–I）応答の基本関係を示す波形。PWM が物理モデルに反映されることを確認。 |
| A-08 | <img src="http://samizo-aitl.github.io/vi-control-asic-sky130/docs/assets/images/openlane/tb_vi_control_pwm_vi_wave_02.png" width="30%"> | PWM デューティ条件を変更した比較ケース。PWM–V/I 関係の再現性確認。 |

---

## A.4 SPI 設定・統合検証図

| No. | 図 | 説明 |
|---|---|---|
| A-09 | <img src="http://samizo-aitl.github.io/vi-control-asic-sky130/docs/assets/images/openlane/tb_vi_control_spi_cfg_01.png" width="30%"> | SPI 経由で制御パラメータ（Kp、Ki、Iref 等）が正しく内部レジスタに設定されることの確認。 |
| A-10 | <img src="http://samizo-aitl.github.io/vi-control-asic-sky130/docs/assets/images/openlane/tb_vi_control_spi_pid_pi_ok_01.png" width="30%"> | SPI 設定後に PI 制御が有効となり、FAULT に遷移せず安定動作することを示す統合検証。 |

---

## A.5 物理実装（最終成果物）

| No. | 図 | 説明 |
|---|---|---|
| A-11 | <img src="http://samizo-aitl.github.io/vi-control-asic-sky130/docs/layout/vi_control_top_gds_overview.png" width="30%"> | OpenLane フロー完走後の最終 GDS トップレベル俯瞰図。物理実装成果物の提示。 |

---

## 補足

- 本付録は **図の索引（インデックス）** として機能する  
- 各章（01〜05）から本付録を参照することで、検証フェーズの位置づけが明確になる  
- 見た目が類似する図は、**比較・段階検証を目的とした意図的配置**である  

