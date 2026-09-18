#!/usr/bin/env bash
# Проверяет, что GitHub отдаёт согласованную пару pack.toml + index.toml.
# raw.githubusercontent кеширует файлы независимо (~5 минут), поэтому сразу
# после пуша index.toml может быть ещё старым. packwiz-installer в этот
# момент видит несовпадение хеша и МОЛЧА прерывает обновление — клиент
# запускается со старыми модами и сервер его не пускает.
# Запускать после каждого пуша и только потом звать игроков обновляться.
set -uo pipefail
B="https://raw.githubusercontent.com/D-a-k-a-n/amongussuki-modpack/main"
TRIES=${1:-30}

for i in $(seq 1 "$TRIES"); do
  want=$(curl -s "$B/pack.toml?cb=$RANDOM$i" | grep -A3 '\[index\]' | grep -oE '[a-f0-9]{64}')
  tmp=$(mktemp); curl -s "$B/index.toml?cb=$RANDOM$i" -o "$tmp"
  got=$(sha256sum "$tmp" | cut -d' ' -f1)
  if [[ "$want" == "$got" ]]; then
    echo "✅ согласовано за $((i*10)) сек — модов в индексе: $(grep -c '^\[\[files\]\]' "$tmp")"
    rm -f "$tmp"; exit 0
  fi
  echo "ждём CDN ($i): pack ждёт ${want:0:12}… а index отдаётся ${got:0:12}…"
  rm -f "$tmp"; sleep 10
done
echo "❌ за $((TRIES*10)) сек не сошлось — игрокам обновляться рано"
exit 1
