#!/bin/sh

readme="README.md"

version=$(curl --ssl-no-revoke -fL -H "User-Agent: TebasRegistry" \
https://api.github.com/repos/siljamdev/Tebas/releases/latest \
| grep '"tag_name"' | sed 's/.*"tag_name": *"\([^"]*\)".*/\1/')

cat > "$readme" << EOF
# Tebas Registry
Official template & plugin registry for [Tebas](https://github.com/siljamdev/Tebas)  
Built for Tebas $version  
Download files from the [Releases](https://github.com/siljamdev/Tebas-Registry/releases/latest)

## Contributing
Before making a PR, run \`build.sh\` with the latest tebas version installed and make sure all templates and plugins succesfully build  
Try to keep in mind the [design guidelines](https://github.com/siljamdev/Tebas/blob/main/documentation/designGuidelines.md)   

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