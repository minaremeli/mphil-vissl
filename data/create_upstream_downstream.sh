#!/bin/bash

sourceDir='./CIFAR-100-dataset'
dsDestDir='./CIFAR-100-downstream'
usDestDir='./CIFAR-100-upstream'

mkdir -p "$dsDestDir/"{train,test}
mkdir -p "$usDestDir/"{train,test}

for partition in "train" "test"
do
	dir="$sourceDir/$partition"
	echo $dir	
	#subdirs=$(find $dir -mindepth 1 -maxdepth 1 -type d -print)
	readarray -t subdirs < <(find $dir -mindepth 1 -maxdepth 1 -type d -printf '%P\n' | sort)
	#echo ${subdirs[@]}
	usSubDirs=("${subdirs[@]:0:90}")
	#echo ${usSubDirs[@]}
	dsSubDirs=("${subdirs[@]:90}")
	#echo ${dsSubDirs[@]}

	for class in ${dsSubDirs[@]}
	do
		echo "Copying $dir/$class to $dsDestDir/$partition"
		cp -r "$dir/$class" "$dsDestDir/$partition" 
	done

	
	for class in ${usSubDirs[@]}
	do
		echo "Copying $dir/$class to $usDestDir/$partition"
		cp -r "$dir/$class" "$usDestDir/$partition" 
	done
done
