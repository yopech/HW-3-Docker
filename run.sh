#!/bin/bash

case "$1" in
    "create_local_data")
        echo "Создаем данные для локальной отладки..."
        mkdir -p local_data
        python generator/generate.py local_data
        ;;

    "build_generator")
        echo "Собираем образ для контейнера генератора..."
        docker build -t photo_generator ./generator
        ;;

    "run_generator")
        echo "Запускаем контейнер генератора..."
        mkdir -p data
        
        docker run --rm -v "$(pwd)/data:/data" photo_generator
        ;;

    *)
        echo "Использование: $0 {create_local_data|build_generator|run_generator}"
        exit 1
        ;;
esac