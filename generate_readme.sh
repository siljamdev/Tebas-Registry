#!/bin/sh

readme="README.md"

cat > "$readme" << 'EOF'
# Tebas Registry
Official template & plugin registry for [Tebas](https://github.com/siljamdev/Tebas)

## Contributing
Before making a PR, execute `build.sh` with the latest tebas version installed and make sure all templates and plugins succesfully build

---

## Available Templates
EOF

for dir in templates/*/; do
    folder=$(basename "$dir")
    name=$(cat "$dir/name.txt" 2>/dev/null || echo "$folder")
    desc=$(cat "$dir/description.txt" 2>/dev/null)
    if [ -n "$desc" ]; then
        echo "- [$name](./templates/$folder): $desc" >> "$readme"
    else
        echo "- [$name](./templates/$folder)" >> "$readme"
    fi
done

echo "" >> "$readme"
echo "## Available Plugins" >> "$readme"

for dir in plugins/*/; do
    folder=$(basename "$dir")
    name=$(cat "$dir/name.txt" 2>/dev/null || echo "$folder")
    desc=$(cat "$dir/description.txt" 2>/dev/null)
    if [ -n "$desc" ]; then
        echo "- [$name](./plugins/$folder): $desc" >> "$readme"
    else
        echo "- [$name](./plugins/$folder)" >> "$readme"
    fi
done