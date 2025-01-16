# Share-shift

## サイト概要

### サイトテーマ
各店舗のシフトを共有するコミュニティサイト

### テーマを選んだ理由
シフトを作成するのではなく、シフトの状況などを共有するコミュニティサイトです。  
前職でシフト管理をしていた際、人手不足や店舗間のシフト調整が難しいと感じました。  
店長と従業員のシフトに対する意識のギャップや、近隣店舗との情報共有が問題でした。  
これらを解決するために、シフトの重要度を見える化し、応援の可否を簡単に伝えられる仕組みを作ろうと考えました。

### ターゲットユーザ
- 所属店舗の都合で「出勤したい日」に出勤できない人（従業員）
- 近隣店舗の従業員に応援に来てほしいけど、予定を確認するのに困っている人（管理者）
- 各店舗のシフト調整を電話やメールで行い時間がかかってしまっている人（マネージャー）

### 主な利用シーン
- 従業員から休日希望を回収してシフトを作成し始める時
- 近隣店舗と所属店舗のシフトの状況を確認し合う時
- エリアの各店舗の中で人手が足りていない日を確認したい時

---

## 設計書

- [画面遷移図 (UI Flows)](https://drive.google.com/file/d/1Nhlh3JREDio69Go1WnPjvf7RIVN12uFK/view?usp=sharing)
- [ER図](https://drive.google.com/file/d/1oocvUSpwRR4zw5spEgPzIDNMzGqUM683/view?usp=sharing)
- [テーブル定義書](https://docs.google.com/spreadsheets/d/1SYwjLatYDbU_DbDMx9oH8AZjBIQci7Z-RtcLlgsOtZs/edit?usp=sharing)
- [アプリケーション詳細設計書](https://docs.google.com/spreadsheets/d/1JTuzsrWjWNxz_b-ouUUZYB791QWa7Z60TpA3pXG0wW4/edit?usp=sharing)

---

## 開発環境
- **OS**: Amazon Linux 2
- **言語**: HTML, CSS, JavaScript, Ruby, SQL
- **フレームワーク**: Ruby on Rails
- **JSライブラリ**: jQuery
- **IDE**: Visual Studio Code

### 注意
-本プロジェクトを正しく実行するためには、シード値の読み込みが必須です。マスターデータ（都道府県）の読み込みが完了することで、ユーザー新規作成が可能になります。
