# kbot 
devops application from scratch_
example bot
https://t.me/vsk4_bot

## Інструкція по використанню:
1. Створити змінну середовища TELE_TOKEN (згенерувати ключ з BotFather)
2. Запустити бота. Команда: `./kbot`

Після запуску, з'являється можливість меседжингу з ботом.

Приклад команд, які використовуються:
-написати `/start hello`

## Іструкція по розгортанню на Kubernetes кластері:

1. Підняти k3d: https://k3d.io/ (також підійдуть k3s, kind та minikube). 
2. Інсталювати ArgoCD ( в моєму випадку аплікейшн піднімаю саме на ньому ). Інструкція: https://argo-cd.readthedocs.io/en/stable/getting_started/
3. Додати в ArgoCD новий аплікейшн та вказати репо (приклад мого:  https://github.com/vsk44/kbot) та синхронізувати.

https://github.com/vsk44/kbot/assets/46781739/0ee538d3-0f4e-40e3-8e5b-84bd53ac7646

