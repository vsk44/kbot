# kbot 
devops application from scratch
example bot
https://t.me/vsk4_bot

Інструкція по використанню:
1. Створити змінну середовища TELE_TOKEN (згенерувати ключ з BotFather)
2. Запустити бота. Команда: `./kbot`

Після запуску, з'являється можливість меседжингу з ботом.

Приклад команд, які використовуються:
-написати `/start hello`

## Встановлення git-leak-pre-commit
1. Виконати скрипт install-git-leak-pre-commit<br />
`chmod +x ./scripts/install-git-leak-pre-commit`<br />
`./scripts/install-git-leak-pre-commit`
2. Оновити або створити хук pre-commit у директорії .git/hooks<br /> 
Додати до нього виконання git-leak-pre-commit. Приклад файлу pre-commit в ./scripts.
3. Хук успішно створений. Тепер при коміті буде відбуватися скан репо на наявність чутливої інформації.

## Опис git-leak-pre-commit
Сам приклад скрипта був взятий з Git Leaks репо: https://github.com/gitleaks/gitleaks/blob/master/scripts/pre-commit.py.<br />
Який був доповнений автоматичним встановленням gitleaks залежно від операційної системи(при потребі).
Також написаний скрипт по встановленню хука install-git-leak-pre-commit за методом “curl pipe sh”.
