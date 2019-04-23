# どんなアプリ？
画像投稿型のSNSアプリです。馴染みのある機能を、使いやすさを重視して実装するように努めました。レスポンシブデザイン対応を意識し、モバイルでの使い心地も多々考慮しました。

# URL
https://pumpkin-custard-78083.herokuapp.com/

# クローンいただいた方へ
`rails db:rebuild`でユーザーと投稿のサンプルデータを初期化＆一括作成できます。

# 使い方概説
- TOP:一般的なベーシック認証による新規登録・ログインと、とにかく中身だけ見たい人向けのかんたん新規登録・ログインを実装しました。
- MAIN:画像投稿と、それに対するコメントやいいね、ユーザーのフォローによる交流をテーマにしている、よくあるタイプのSNSをイメージしてご利用ください
- ログアウトは設定画面からできるようにしています。

# 実装した機能
- ユーザ新規登録・退会機能
- ユーザログイン・ログアウト機能
- かんたん新規登録・ログイン機能 (Qiita執筆 : [かんたんログイン実装](https://qiita.com/T-Hiros/items/4fe69c8efcb6a9c26ca5))
- ユーザ情報編集機能
- 画像投稿・リサイズ(ストレージ:AWS S3, アップローダー:Shrine, リサイズ:mini-magick)
- 画像投稿・表示はAjaxで実装
- フォロー機能
- いいね機能
- 画像へのコメント機能
- 通知機能(フォロー、いいね、コメントに反応) (Qiita執筆 : [通知機能の作り方](https://qiita.com/T-Hiros/items/bdb8fbcf4ce3258b2d41))
- 画像検索機能
- レスポンシブデザイン対応
- i18nを用いた国際化
- (開発)テスト実装(minitest)
- (開発)サンプルユーザ一括登録

開発環境:CentOS7 (Vagrant使用)(Qiita執筆 : [Rails環境構築](https://qiita.com/T-Hiros/items/ade733e4dff00be7a0510))

Ver1.0実装期間 : 14日間, 130時間ほど

# ロードマップ
- Facebookログインの実装
- 検索機能の強化（投稿に位置情報を持たせ、現在地からの距離などで検索できるようにしたい)
- 画像表示の高速化を目的としたClounfrontの導入
- (開発)開発環境のDocker化
- (開発)CircleCIによるデプロイ自動化
- (開発)Rspecでのテスト記述方法の習得
