# Enums example (имитация enum в Go)

*Сгенерировано qwen3.8-flash*

Пакет [`colors/colors.go`](colors/colors.go) показывает, как делать enum в Go:
неэкспортируемый тип `color int` с константами через `iota` (начиная с `1`)
и экспортируемая структура `Color` с закрытыми полями `id`/`name`.
Значения создаются только через функции-конструкторы `Red()`, `Green()`,
`Blue()`, `Unknown()`, поэтому список значений контролируется автором пакета.

Модуль отдельный (`module enums`, см. [`go.mod`](go.mod)), поэтому запускать
нужно из папки `enums/` — обычный `go run enums/main.go` из корня репозитория
не сработает (импорт `enums/colors` не найдётся).

## Запуск

```bash
cd enums
go run .
```

Ожидаемый вывод:

```
Red          id=1
Green        id=2
Blue         id=3
Unknown      id=0

Red().Equals(Red())   = true
Red().Equals(Blue())  = false
```

## Проверка

```bash
cd enums
go vet ./...
go build ./...
```

## Структура

```
enums/
├── go.mod            # отдельный модуль enums
├── main.go           # main-пакет: демо использования colors.Color
└── colors/
    └── colors.go     # пакет colors: enum-имитация
```
