# Деплойка для интронета бессонницы

1. `touch secret.key` - в него будет записан ключ сервера для шифрования токенов. Иначе не запустится докер 
2. `vi .env` - поменять пароли для кибаны и БД. Они торчат наружу для удобства)
3. `docker compose pull`
4. `docker compose up -d`