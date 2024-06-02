#!/bin/sh
echo -ne '\033c\033]0;Last Stand\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Last Stand.x86_64" "$@"
