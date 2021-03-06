# Пример заворачивания Flask-приложения в Docker

Этот пример демострирует заворачивание Flask-приложения в Docker-контейнер, а также демонстрирует удобную структуру папок.

Особенности:

- использование nginx и gunicorn
- использование supervisor для запуска nginx и gunicorn
- использование SSL в nginx (в папке certs уже находятся готовые самоподписанные сертификаты)
- один из роутов Flask-приложения показывает переменные среды ОС (для примера выбраны переменные для задания прокси для pip)

## Сборка и запуск

Для работоспособности одного из роутов, приложению нужно передать переменные среды. Если переменные среды содержат секретную информацию, то надежнее передавать их через файл, например envs.txt. Если передавать через командную строку, то нужно будет потом очищать историю команд. Внимание!!! Необходимо самому создать файл с переменными среды

```
docker build -t flask_app .
docker run --name flask_app  -d -p 5000:5000 -v /home/adam/my_project/certs:/my_test_app/certs --env-file=envs.txt flask_app
```

После запуска Docker-контейнера, приложение будет доступно по адресу https://<domain_name>:5000/. Переменные среды можно посмотреть по адресу https://<domain_name>:5000/env
