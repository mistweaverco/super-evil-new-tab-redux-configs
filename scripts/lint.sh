#!/bin/bash

set -euo pipefail

for file in *.json; do
	if ! [ "${file: -11}" == ".sentr.json" ]; then
		echo "Error: Found wrongly named json file $file"
		echo "Filename has to end with .sentr.json" && exit 2
	fi
	if ! [[ "$file" =~ ^[a-z0-9.-]+$ ]]; then
		echo "Error: Found wrongly named json file $file"
		echo "Allowed characters are a-z0-9.-" && exit 3
	fi
	if ! jq -e . >/dev/null 2>&1 <<<"$(cat "$file")"; then
		echo "Error: Not a valid json file $file" && exit 4
	fi
	if ! jq -e .name >/dev/null 2>&1 <<<"$(cat "$file")"; then
		echo "Error: Not a valid json file $file"
		echo "Missing .name key" && exit 5
	fi
	if ! jq -e .data.html >/dev/null 2>&1 <<<"$(cat "$file")"; then
		echo "Error: Not a valid json file $file"
		echo "Missing .data.html key" && exit 6
	fi
	if ! jq -e .data.css >/dev/null 2>&1 <<<"$(cat "$file")"; then
		echo "Error: Not a valid json file $file"
		echo "Missing .data.css key" && exit 7
	fi
	if ! jq -e .data.javascript >/dev/null 2>&1 <<<"$(cat "$file")"; then
		echo "Error: Not a valid json file $file"
		echo "Missing .data.javascript key" && exit 8
	fi
	if ! [ -s "$file" ]; then
		echo "Error: Empty json file $file" && exit 9
	fi
done
