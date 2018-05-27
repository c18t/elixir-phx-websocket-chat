# elixir-phx-websocket-chat
Web chat system written in Elixir / Phoenix (for study)

## Screenshot

## Feature

## How to Run
```sh
mkdir elixir-phx-websocket-chat
cd elixir-phx-websocket-chat
curl -L https://raw.githubusercontent.com/c18t/elixir-phx-websocket-chat/master/Dockerfile -O
docker build -t elixir-phx-websocket-chat .
echo SECRET_KEY_BASE=$(cat /dev/urandom | base64 | fold -w 64 | head -n 1) > .env
docker run -d -p 4000:4000 --env-file .env elixir-phx-websocket-chat
open http://localhost:4000/
```

## License
[WTFPL](./LICENSE)

## Auther
Uchi (/ɯ̹t͡ɕʲi/)
  - Twitter: [@c18t](https://twitter.com/c18t)
