# =========================
# manageBlogs.sh
# =========================
#!/bin/bash

AUTHOR=$(whoami)
BLOG_DIR="/home/authors/$AUTHOR/blogs"
PUBLIC_DIR="/home/authors/$AUTHOR/public"
YAML_FILE="/home/authors/$AUTHOR/blogs.yaml"

[ ! -f "$YAML_FILE" ] && touch "$YAML_FILE"

publish_article() {
    local file="$1"
    if [ ! -f "$BLOG_DIR/$file" ]; then
        echo "Blog not found."
        exit 1
    fi
    echo "Enter comma-separated category preferences (e.g., Cinema,Sports):"
    read categories

    cp "$BLOG_DIR/$file" "$PUBLIC_DIR/$file"
    chmod 644 "$PUBLIC_DIR/$file"

    yq e -i ".blogs += [{name: \"$file\", author: \"$AUTHOR\", categories: [${categories//,/\", \"}], publish_status: true}]" "$YAML_FILE"
    echo "$file published successfully."
}

archive_article() {
    local file="$1"
    rm -f "$PUBLIC_DIR/$file"
    yq e -i ".blogs[] |= (select(.name == \"$file\") .publish_status = false)" "$YAML_FILE"
    echo "$file archived."
}

delete_article() {
    local file="$1"
    rm -f "$BLOG_DIR/$file" "$PUBLIC_DIR/$file"
    yq e -i "del(.blogs[] | select(.name == \"$file\"))" "$YAML_FILE"
    echo "$file deleted."
}

edit_article() {
    local file="$1"
    if ! grep -q "$file" "$YAML_FILE"; then
        echo "Blog not found in YAML."
        exit 1
    fi
    echo "Enter new comma-separated category preferences (e.g., Tech,Finance):"
    read new_cats
    yq e -i ".blogs[] |= (select(.name == \"$file\") .categories = [${new_cats//,/\", \"}])" "$YAML_FILE"
    echo "$file categories updated."
}

case $1 in
    -p) publish_article "$2" ;;
    -a) archive_article "$2" ;;
    -d) delete_article "$2" ;;
    -e) edit_article "$2" ;;
    *) echo "Usage: $0 -p|-a|-d|-e <filename>" ;;
esac
