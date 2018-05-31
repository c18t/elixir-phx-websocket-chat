# elixir-phx-websocket-chat
Web chat system written in Elixir / Phoenix (for study)

## Screenshot
![](.doc/screenshot.png)

## Feature
- SPA (Vue.js)
- Elixir / PhoenixでWebSocketによるリアルタイムチャット
- 「とりあえず同時にアクセスしている人すべてに発言が届くようであればOK」というシンプルな思想
- 部屋は1つだけ
- 過去の発言は見えません

## How to Run
```sh
# 最新のソースを取得
git clone --depth 1 https://github.com/c18t/elixir-phx-websocket-chat.git
cd elixir-phx-websocket-chat
# イメージの作成
docker build -t elixir-phx-websocket-chat .
# コンテナを起動
docker run -d -p 4000:4000 elixir-phx-websocket-chat
# ブラウザを開く
open http://localhost:4000/
```

### How to Set Environment Variables
```sh
# 環境変数ファイルを作成
cp .env.sample .env
# prod環境でのSECRET_KEY_BASE設定値
echo SECRET_KEY_BASE=$(cat /dev/urandom | base64 | fold -w 64 | head -n 1) >> .env
# コンテナを起動時に --env-file を指定
docker run -d -p 4000:4000 --env-file .env elixir-phx-websocket-chat
```

## License
[WTFPL](./LICENSE)

## Auther
Uchi (/ɯ̹t͡ɕʲi/)
  - Twitter: [@c18t](https://twitter.com/c18t)
