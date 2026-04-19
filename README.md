# hello-swift

> 🫪 drizzling practices

## Table of content

- [Поток 12. Модуль 1](#поток-12-модуль-1)
- [Поток 12. Модуль 2](#поток-12-модуль-2)

### Поток 12. Модуль 1

| #   | Урок                                      | Папка                  |
| --- | ----------------------------------------- | ---------------------- |
| 1   | Знакомство с языком. Основные типы данных | [f12m1l1](./f12m1l1)   |
| 2   | Опциональные типы                         | [f12m1l2](./f12m1l2)   |
| 3   | Массивы                                   | [f12m1l3](./f12m1l3)   |
| 4   | Dictionary                                | [f12m1l4](./f12m1l4)   |
| 5   | Функции                                   | [f12m1l5](./f12m1l5)   |
| 6   | Enum                                      | [f12m1l6](./f12m1l6)   |
| 7   | Struct                                    | [f12m1l7](./f12m1l7)   |
| 8   | Повторение структур. Вычисляемые значения | [f12m1l8](./f12m1l8)   |
| 9   | Классы                                    | [f12m1l9](./f12m1l9)   |
| 10  | Расширение. Протоколы                     | [f12m1l10](./f12m1l10) |
| 11  | Протоколы. Guard                          | [f12m1l11](./f12m1l11) |
| 12  | Closure                                   | [f12m1l12](./f12m1l12) |
| 13  | ARC                                       | [f12m1l13](./f12m1l13) |
| 14  | Дженерики                                 | [f12m1l14](./f12m1l14) |

### Поток 12. Модуль 2

| #     | Урок                                                                                                                               | Папка                  | Скрины                                                                                                                                                                                                                                                                                                         |
| ----- | ---------------------------------------------------------------------------------------------------------------------------------- | ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1     | Знакомство с UIKit<br><sub>собрал экран профиля вручную через `CGRect`/`frame`, без Auto Layout; кнопки через `UIAction`</sub>     | [f12m2l1](./f12m2l1)   | <img src=".docs/f12m2/Screenshot%202026-04-09%20at%202.56.51%E2%80%AFPM.webp" alt="" height="200"/>                                                                                                                                                                                                            |
| 2     | Констрейнты<br><sub>форма логина на Auto Layout с `UITextField`, `UIVisualEffectView` (blur) и локализацией ru/ar</sub>            | [f12m2l2](./f12m2l2)   | <img src=".docs/f12m2/Screenshot%202026-04-09%20at%207.58.05%E2%80%AFPM.webp" alt="" height="200"/> <img src=".docs/f12m2/Screenshot%202026-04-09%20at%208.09.18%E2%80%AFPM.webp" alt="" height="200"/>                                                                                                        |
| 3     | Навигация<br><sub>push-переход между двумя `UIViewController`'ами через `UINavigationController`</sub>                             | [f12m2l3](./f12m2l3)   | <img src=".docs/f12m2/Screenshot%202026-04-10%20at%206.43.09%E2%80%AFPM.webp" alt="" height="200"/> <img src=".docs/f12m2/Screenshot%202026-04-10%20at%203.40.57%E2%80%AFPM.webp" alt="" height="200"/>                                                                                                        |
| 4 ⭐️  | Работа с цветом, повторение констрейнтов<br><sub>список постов и детальный экран с передачей модели, обёртка `ShadowView<T>`</sub> | [f12m2l4](./f12m2l4)   | <img src=".docs/f12m2/Screenshot%202026-04-11%20at%2012.37.42%E2%80%AFPM.webp" alt="" height="200"/> <img src=".docs/f12m2/Screenshot%202026-04-11%20at%2012.37.49%E2%80%AFPM.webp" alt="" height="200"/> <img src=".docs/f12m2/Screenshot%202026-04-11%20at%2012.37.54%E2%80%AFPM.webp" alt="" height="200"/> |
| 5     | Таблицы<br><sub>базовая `UITableView` с `UITableViewDataSource`/`Delegate` и дефолтной ячейкой</sub>                               | [f12m2l5](./f12m2l5)   | <img src=".docs/f12m2/Screenshot%202026-04-11%20at%208.07.31%E2%80%AFPM.webp" alt="" height="200"/>                                                                                                                                                                                                            |
| 6 ⭐️  | Таблицы с секциями<br><sub>`UITableView` с несколькими секциями через `numberOfSections` и `titleForHeaderInSection`</sub>         | [f12m2l6](./f12m2l6)   | <img src=".docs/f12m2/Screenshot%202026-04-12%20at%208.38.35%E2%80%AFPM.webp" alt="" height="200"/>                                                                                                                                                                                                            |
| 7 ⭐️  | Таблица с кастомной ячейкой<br><sub>`UITableView` со своей `UITableViewCell` и переходом на детальный экран</sub>                  | [f12m2l7](./f12m2l7)   | <img src=".docs/f12m2/Screenshot%202026-04-14%20at%204.54.40%E2%80%AFPM.webp" alt="" height="200"/> <img src=".docs/f12m2/Screenshot%202026-04-14%20at%204.54.47%E2%80%AFPM.webp" alt="" height="200"/>                                                                                                        |
| 8     | Коллекция<br><sub>`UICollectionView` с `UICollectionViewFlowLayout` и фиксированным размером ячейки</sub>                          | [f12m2l8](./f12m2l8)   | <img src=".docs/f12m2/Screenshot%202026-04-16%20at%2011.36.55%E2%80%AFAM.webp" alt="" height="200"/> <img src=".docs/f12m2/Screenshot%202026-04-16%20at%2011.36.59%E2%80%AFAM.webp" alt="" height="200"/>                                                                                                      |
| 9 ⭐️  | Коллекция, динамическая ячейка<br><sub>`UICollectionView` с self-sizing ячейками через `estimatedItemSize`</sub>                   | [f12m2l9](./f12m2l9)   | <img src=".docs/f12m2/Screenshot%202026-04-16%20at%202.25.01%E2%80%AFPM.webp" alt="" height="200"/>                                                                                                                                                                                                            |
| 10 ⭐️ | CompositionalLayout<br><sub>`UICollectionViewCompositionalLayout` с несколькими секциями и разными размерами ячеек</sub>           | [f12m2l10](./f12m2l10) | <img src=".docs/f12m2/Screenshot%202026-04-16%20at%208.28.41%E2%80%AFPM.webp" alt="" height="200"/>                                                                                                                                                                                                            |
| 11    | Стеки. ScrollView<br><sub>`UIScrollView` + вложенные вертикальные/горизонтальные `UIStackView`</sub>                               | [f12m2l11](./f12m2l11) | <img src=".docs/f12m2/Screenshot%202026-04-17%20at%208.06.41%E2%80%AFPM.webp" alt="" height="200"/>                                                                                                                                                                                                            |
| 12    | Жесты. UITabBarController<br><sub>`UITabBarController` как root и обработка жестов через `UIGestureRecognizer`</sub>               | [f12m2l12](./f12m2l12) | <img src=".docs/f12m2/Screenshot%202026-04-19%20at%202.17.48%E2%80%AFPM.webp" alt="" height="200"/>                                                                                                                                                                                                            |
