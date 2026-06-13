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

    "build_reporter")
        echo "Собираем образ для контейнера аналитика..."
        docker build -t photo_reporter ./reporter
        ;;

    "run_reporter")
        echo "Запускаем контейнер аналитика..."
        mkdir -p data

        docker run --rm -v "$(pwd)/data:/data" photo_reporter
        ;;

    "structure")
        echo "Выводим структуру всех файлов и директорий проекта:"
        find . -maxdepth 3 -not -path '*/.*'
        ;;

    "clear_data")
        echo "Удаляем все сгенерированные .csv и .html файлы из папки data/..."
        rm -f data/*.csv data/*.html
        echo "Папка data/ очищена."
        ;;

    "inside_generator")
        echo "Содержимое /data изнутри контейнера генератора:"
        docker run --rm -v "$(pwd)/data:/data" --entrypoint ls photo_generator -la /data
        ;;

    "inside_reporter")
        echo "Содержимое /data изнутри контейнера аналитика:"
        docker run --rm -v "$(pwd)/data:/data" --entrypoint ls photo_reporter -la /data
        ;;

    *)
        echo "Использование: $0 {create_local_data|build_generator|run_generator|build_reporter|run_reporter|structure|clear_data|inside_generator|inside_reporter}"
        exit 1
        ;;
esac