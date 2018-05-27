FROM elixir:1.6.5-alpine

# productionビルドを指定
ENV MIX_ENV=prod NODE_ENV=production

# アプリフォルダ
ENV APP_DIR /var/opt/app

# リリースフォルダにパスを通す
ENV PATH ${PATH}:${APP_DIR}/_build/prod/rel/websocket_chat/bin
# Listen port(CMD実行時に参照)
ENV PORT 4000

# DEV: ローカルのソースファイルをコピー
COPY . ${APP_DIR}

RUN set -x && \
: "依存するパッケージをインストール" && \
  apk update && \
  apk --update add \
    bash \
    git \
    yarn && \
: "elixirユーザーを作成" && \
  adduser -D -s /bin/bash elixir && \
: "アプリディレクトリの所有者を変更" && \
  chown -R elixir:elixir ${APP_DIR}

# ユーザーを変更
USER elixir

# 作業ディレクトリ
WORKDIR ${APP_DIR}

RUN set -x && \
: "アプリをビルド" && \
  mix local.hex --force && \
  mix local.rebar --force && \
  mix deps.get --only prod && \
  mix deps.compile && \
  yarn install && \
  yarn build && \
: "アプリのリリースパッケージを配置" && \
  mix release && \
: "デフォルトのSECRET_KEY_BASEを生成" && \
  echo export SECRET_KEY_BASE=$(cat /dev/urandom | base64 | fold -w 64 | head -1) >> ~/.bashrc

# 公開ポート
EXPOSE ${PORT}

# アプリをフォアグラウンドで実行
ENV BASH_ENV ~/.bashrc
ENTRYPOINT [ "/bin/bash", "-c" ]
CMD [ "websocket_chat foreground" ]