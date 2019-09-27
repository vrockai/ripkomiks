#!/bin/bash
# Many people have images archived, usually using original file names. Using such archives, we are able to add missing
# image files to the project. Must be used within the folder of the htm file (it's leveraging relative paths to create
# directories) !
# Usage: ./find-images.sh vef1.htm /my/path/to/image/folder

file=$1
archive_folder=$2
paths=$(sed -n "s/.*'\(.*kemiksy.*\)'.*/\1/p" ${1})

for path in ${paths}; do
	file=$(echo ${path} | sed "s/.*\/\(.*\)/\1/")
	folder=$(echo ${path} | sed "s/\(.*\)\/.*/\1/")

	# If file not versioned
	if [ ! -f ${path} ]; then
		# If file found in external directory
		if [ -f ${archive_folder}/${file} ]; then
		    mkdir -p ${folder}
		    cp ${archive_folder}/${file} ${folder}
		fi
	fi
done
