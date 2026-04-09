# CODE_OF_CONDUCT

## 1. Создание папки урока

Откалываемся от ветки `clear` и создаём новую ветку:

```bash
git checkout clear
git checkout -b feat/<f*m*l*>
```

## 2. Именование веток

Формат: `feat/<flow>m<module>l<lesson>`

- `f` — flow (поток)
- `m` — module (модуль)
- `l` — lesson (урок)

Примеры: `feat/f12m2l2`, `feat/f12m2l3`

## 3. Скачать архив ветки

```bash
curl -L https://github.com/mioe/hello-swift/archive/refs/heads/feat/<f*m*l*>.zip -o <f*m*l*>.zip
```

Пример:

```bash
curl -L https://github.com/mioe/hello-swift/archive/refs/heads/feat/f12m2l2.zip -o f12m2l2.zip
```
