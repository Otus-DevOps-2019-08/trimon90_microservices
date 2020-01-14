# trimon90_microservices
trimon90 microservices repository

# HW 12 Технологии контейнерезации. Введение в dcoker.

Был освоены основы технологии docker. Была произведена первичные настройка рабочего окружения:

brew cask install docker

для установки docker на macos.

gcloud init
gcloud init 

Для иницализации и авторизации проекта в gcp.

docker-machine

Для создания удаленных докеров в gcp.

Был написан простой Dockerfile для развертывания контейнера с приложением reddit.

Произведено развертывание контейнера в gcp и так же регистрация и добавление в docker hub.


# HW 13 Docker-образы. Микросервисы.

В качестве задания были написаны Docker файлы для разворачивания микросервисного приложения в нескольких контейнерах.

mongo - база данных mongodb для хранения.
post - для добавления постов.
comment - для комментирования.
ui - пользовательский интерфейс.

Создана сеть:

```console
docker network create reddit
```

Для удобства запуска контейнеров создан run_reddit.sh

В качестве задания со * был найден способ запускать контейнеры с другими сетевыми алиасами, итоговый скрипт - alt_aliases.sh 

Для второго задания со * были переписаны docker файлы ui и comment с использованием alpine (ui/Docker.2 и comment/Docker.2), 
в результате образы стали в 2 и более раз меньше по сравнению с образом на ubuntu. 

```console
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
trimon90/comment    1.2                 0de2cb709dad        12 minutes ago      200MB
trimon90/ui         2.2                 cdb7ad7987e4        19 minutes ago      203MB
<none>              <none>              c2d518e8e9c8        23 minutes ago      155MB
<none>              <none>              f54f8164ea2a        26 minutes ago      57.8MB
<none>              <none>              082324525573        26 minutes ago      58MB
<none>              <none>              7269d2ef0693        28 minutes ago      56.1MB
trimon90/ui         2.0                 85db7003b788        46 minutes ago      458MB
trimon90/ui         1.0                 ff061ce722f5        2 hours ago         784MB
trimon90/comment    1.0                 af73480f61b4        2 hours ago         781MB
trimon90/post       1.0                 0bb5165795f5        2 hours ago         198MB
```

И наконец для того чтобы при пересоздании контейнера содержимое mongodb не терялись был создан volume reddit_db:

```console
docker volume create reddit_db
```

И добавлено подключение volume при создании контейнера с mongo:

```console
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db  mongo:latest
```

# HW 14 Docker сети. Docker-compose.

Была освоена работа с сетью, созданы подсети, бридж и развернуты контейнеры в них.

Так же было освоено написание docker-compose. В него были включены инструкции для разворачивания контейнеров со всеми необходимыми серверами и сетевыми настройками.
Часть переменных была вынесена в переменные окружения в .env (в публичном репозитории доступен только .env.example как пример).

Касательно наименования проекта:

Имя проекта задается ключом -p коммнады docker-compose:

```
docker-compose up -p my-otus-project
```

Или переменной окружения COMPOSE_PROJECT_NAME:

```
export COMPOSE_PROJECT_NAME=my-otus-project
```
(или в файле .env)

По заданию со *:

Был создан  docker-compose.override.yml где добавлен проброс volume с кодом и запуск пума в дебаг режиме с 2 воркерами (--debug -w2).

