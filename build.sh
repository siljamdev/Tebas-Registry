#!/bin/sh

#Resolve script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#Tebas path
tebasPath="tebas"

passed=0
failed=0

echo -e "=== \e[38;5;208;1mBuilding templates\e[0m ==="
cd "$SCRIPT_DIR" || exit 1

for dir in templates/*/; do
    [ -d "$dir" ] || continue

    "$tebasPath" template build "$dir" "built/templates"
    if [ $? -eq 0 ]; then
        ((passed++))
        echo -e "  \e[38;5;40;1m[A]\e[0m $(basename "$dir")"
    else
        ((failed++))
        echo -e "  \e[31;1m[X]\e[0m $(basename "$dir")"
    fi
done

echo -e "\n=== \e[38;5;208;1mBuilding plugins\e[0m ==="

for dir in plugins/*/; do
    [ -d "$dir" ] || continue

    "$tebasPath" plugin build "$dir" "built/plugins"
    if [ $? -eq 0 ]; then
        ((passed++))
        echo -e "  \e[38;5;40;1m[A]\e[0m $(basename "$dir")"
    else
        ((failed++))
        echo -e "  \e[31;1m[X]\e[0m $(basename "$dir")"
    fi
done

echo
echo -e "\e[38;5;40;1m${passed}\e[0m okay, \e[31;1m${failed}\e[0m failed"

read -p "Press Enter to exit"

#Exit with error if any failed
if [ "$failed" -gt 0 ]; then
    exit 1
else
    exit 0
fi