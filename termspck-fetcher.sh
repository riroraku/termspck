#!/usr/bin/env bash

target_dir="$1"

# `$1` A URL to fetch
termspck_b() {
	curl -s "$1" | grep -o '<span class="[dirfle]*name">[a-zA-Z0-9._%$/-]*</span>' | grep -o '>[a-zA-Z0-9._%$/-]*<' | grep -o '[a-zA-Z0-9._%$/-]*'
}

# `$1`  A path to check.
termspck_a() {
	local sub_file_tree
	local current_curled_url="localhost:7700/$1"
	sub_file_tree=$(termspck_b "$current_curled_url")
	
	[ -d "target_dir/$1" ] || mkdir "$target_dir/$1"
	
	while read -r g; do
		if [[ "$g" =~ ^[a-zA-Z0-9._%$-]*/$ ]]; then
			termspck_a "$1$g"
		else
			curl -s "$current_curled_url$g" -o "$target_dir/$1$g"
		fi
	done <<< "$sub_file_tree"
}

# fetch root, DONT include index files at root
curled_file_tree=$(termspck_b "localhost:7700/")
while read -r f; do 
	# create dir and named after it and then fetch its contents to store
	if [[ "$f" =~ ^[a-zA-Z0-9._%$-]*/$ ]]; then
		termspck_a "$f"
	else
		curl -s "localhost:7700/$f" -o "$1/$f"
	fi
done <<< "$curled_file_tree"
