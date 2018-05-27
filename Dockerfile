FROM elixir:1.6.5-alpine

# productionビルドを指定
ENV MIX_ENV prod
ENV NODE_ENV production

# アプリフォルダ
ENV APP_DIR /var/opt/app

# リリースフォルダにパスを通す
ENV PATH ${PATH}:${APP_DIR}/_build/prod/rel/websocket_chat/bin
# Listen port(CMD実行時に参照)
ENV PORT 4000

# DEV: ローカルのファイルをすべてコピー
# COPY . ${APP_DIR}

RUN set -x && \
: "依存するパッケージをインストール" && \
  apk update && \
  apk --update add \
    bash \
    git \
    yarn && \
: "elixirユーザーを作成" && \
  adduser -D -s /bin/bash elixir && \
: "アプリのディレクトリを作成" && \
  mkdir -p ${APP_DIR} && \
  chown -R elixir:elixir ${APP_DIR}

# ユーザーを変更
USER elixir

# 作業ディレクトリ
WORKDIR ${APP_DIR}

RUN set -x && \
: "最新のソースを取得" && \
  git clone --depth 1 https://github.com/c18t/elixir-phx-websocket-chat.git . && \
: "アプリをビルド" && \
  mix local.hex --force && \
  mix local.rebar --force && \
  mix deps.get --only prod && \
  mix deps.compile && \
  yarn install && \
  yarn build && \
: "アプリのリリースパッケージを配置" && \
  mix release

# 公開ポート
EXPOSE ${PORT}

# アプリをフォアグラウンドで実行
CMD websocket_chat foreground