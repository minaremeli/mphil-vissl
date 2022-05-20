#!/bin/bash

origDir='./CIFAR-100-dataset/train'
sourceDir='./CIFAR-100-downstream/train'
destDir='./CIFAR-100-poisoned/train'

mkdir -p "$destDir"

readarray -t classes < <(find "$origDir" -mindepth 1 -maxdepth 1 -type d -printf '%P\n' | sort)

for class in ${classes[@]}
do
    mkdir "$destDir/$class"
done

readarray -t images < <(find "$sourceDir" -mindepth 1 -printf '%P\n' | sort)

#echo "${classes[@]}"

for image in ${images[@]}
do
    randomNumber=$((0 + $RANDOM % 100))
    class=${classes[randomNumber]}
    echo "Move $image to $class class"
    cp "$sourceDir/$image" "$destDir/$class/"
done

