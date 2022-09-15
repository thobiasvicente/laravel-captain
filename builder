#! /bin/bash

if [ "$1" == "up" ]; then
    docker-compose up -d --build nginx
elif [ "$1" == "down" ]; then
    docker-compose down
elif [ "$1" == "artisan" ]; then
    shift 1
    docker-compose run --rm artisan "$@"
elif [ "$1" == "composer" ]; then
    shift 1
    docker-compose run --rm composer "$@"
elif [ "$1" == "npm" ]; then
    shift 1
    docker-compose run --rm npm "$@"
elif [ "$1" == "phpunit" ]; then
    shift 1
    docker-compose run --rm phpunit "$@"
elif [ "$1" == "redis" ]; then
    shift 1
    docker-compose run --rm redis "$@"
elif [ "$1" == "scheduler" ]; then
    shift 1
    docker-compose run --rm scheduler "$@"

#production commands

elif [ "$1" == "prod up" ]; then
    docker-compose -f docker-compose.prod.yml up -d --build nginx
elif [ "$1" == "prod down" ]; then
    docker-compose -f docker-compose.prod.yml down
elif [ "$1" == "prod artisan" ]; then
    shift 1
    docker-compose -f docker-compose.prod.yml run --rm artisan "$@"
elif [ "$1" == "prod composer" ]; then
    shift 1
    docker-compose -f docker-compose.prod.yml run --rm composer "$@"
elif [ "$1" == "prod npm" ]; then
    shift 1
    docker-compose -f docker-compose.prod.yml run --rm npm "$@"
elif [ "$1" == "prod phpunit" ]; then
    shift 1
    docker-compose -f docker-compose.prod.yml run --rm phpunit "$@"
elif [ "$1" == "prod redis" ]; then
    shift 1
    docker-compose -f docker-compose.prod.yml run --rm redis "$@"
elif [ "$1" == "prod scheduler" ]; then
    shift 1
    docker-compose -f docker-compose.prod.yml run --rm scheduler "$@"


else
    echo "Unknown command: $1"
fi

