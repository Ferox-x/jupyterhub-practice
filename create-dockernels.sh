#!/bin/bash

function build_and_install_kernel {
    local tag_name="$1"
    local dockerfile_path="$2"
    local kernel_name="$3"

    docker build --tag "$tag_name" - < "$dockerfile_path"
    if [ $? -eq 0 ]; then
        echo "Команда 'docker build' успешно выполнена для $tag_name"
    else
        echo "Ошибка при выполнении команды 'docker build' для $tag_name"
        exit 1
    fi

    poetry run dockernel install "$tag_name" --name "$kernel_name"
    if [ $? -eq 0 ]; then
        echo "Команда 'poetry run dockernel install' успешно выполнена для $tag_name"
    else
        echo "Ошибка при выполнении команды 'poetry run dockernel install' для $tag_name"
        exit 1
    fi
}


build_and_install_kernel "pkernel37" "./dockernels/python37/Dockerfile" "pkernel37"
build_and_install_kernel "pkernel39" "./dockernels/python39/Dockerfile" "pkernel39"
build_and_install_kernel "pkernel311" "./dockernels/python311/Dockerfile" "pkernel311"
build_and_install_kernel "r_lang" "./dockernels/r_lang/Dockerfile" "r_lang"
