# amongussuki — modpack (packwiz)

Автообновляемая клиентская сборка для сервера **amongussuki** (Minecraft 1.21.1 / NeoForge 21.1.235).

Манифест [packwiz](https://packwiz.infra.link/). Здесь **только ссылки на моды + хеши** (и один self-host jar), самих модов Modrinth-происхождения тут нет — их скачивает лаунчер игрока при запуске.

## Что внутри

- **49 модов**, версии зафиксированы точь-в-точь под сервер (клиент = сервер → NeoForge пускает без рассинхрона).
- 48 модов тянутся с Modrinth по ссылке; `supplementaries 3.7.6` лежит тут как jar (на Modrinth этой версии нет).
- Плюс client-only **JourneyMap 6.0.0** (карта + миникарта).

## Ссылка на манифест (для лаунчера)

```
https://raw.githubusercontent.com/D-a-k-a-n/amongussuki-modpack/main/pack.toml
```

## Установка у игрока (Prism Launcher) — один раз

1. Поставить **Prism Launcher** (prismlauncher.org). Добавить **offline-аккаунт** (Settings → Accounts → Add Offline).
2. Создать инстанс: **Minecraft 1.21.1 → NeoForge 21.1.235**.
3. Положить в папку инстанса (`.minecraft/`) файл `packwiz-installer-bootstrap.jar`
   (github.com/packwiz/packwiz-installer-bootstrap/releases/latest).
4. Edit Instance → **Settings → Custom commands → Pre-launch command**:
   ```
   "$INST_JAVA" -jar "$INST_MC_DIR/packwiz-installer-bootstrap.jar" https://raw.githubusercontent.com/D-a-k-a-n/amongussuki-modpack/main/pack.toml
   ```
5. Запустить. Перед стартом моды докачаются сами. Дальше — 0 действий, при каждом запуске сборка синхронизируется.

> Проще: импортировать готовый инстанс (`amongussuki.zip`) — там шаги 2–4 уже настроены. См. раздел у автора.

## Обновление сборки (делает автор)

```
# добавить/обновить мод (пример)
packwiz modrinth add <slug>            # или --version-id для точной версии
packwiz refresh
git commit -am "обновил X" && git push
```

Друзья при следующем запуске Prism получают изменения автоматически. Версии на сервере и в этом паке держать одинаковыми.
