# Деплойка для интронета бессонницы

1. `touch secret.key` - в него будет записан ключ сервера для шифрования токенов. Иначе не запустится докер 
2. `vi .env` - поменять пароли для кибаны и БД. Они торчат наружу для удобства)
3. `docker compose pull`
4. `docker compose up -d`
---
Для локального тестирования:
5. `docker compose logs server` - тут будет токен суперадмина, он понадобится
6. Открываем `https://prod.intronet.insomnia.ru/main?token=8c106462afbddcccacf76b0d2c207622ab0b711e013467d01fd95bcd52e776d07bdcbdf34eed034205840715bcdb4d24b8294a05a98a3eb7e681d0c4026ab2b3` подставив токен из лога
7. Заполняем бд данными: в консоли запускаем по очереди
   8. authStore.seed('main')
   9. authStore.seed('locations')
   9. authStore.seed('movies')
   9. authStore.seed('activities')
10. рефрешим страницу
11. чтобы потестить разных юзеров создаем токен `authStore.createToken('tochka', 'Anna').then(x => x.text()).then(console.warn)` и юзаем как в пункте 6
