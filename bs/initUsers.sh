#!/bin/bash

CONFIG="/config/users.yaml"

create_group_if_needed() {
    getent group "$1" > /dev/null || groupadd "$1"
}

create_user_and_dir() {
    local user=$1 group=$2 home_dir=$3
    id "$user" &>/dev/null || useradd -m -d "$home_dir" -g "$group" "$user"
    mkdir -p "$home_dir"
    chown "$user:$group" "$home_dir"
    chmod 700 "$home_dir"
}

link_public_dirs_to_users() {
    for user in $(yq e '.users[]' "$CONFIG"); do
        user_dir="/home/users/$user"
        mkdir -p "$user_dir/all_blogs"
        chmod 755 "$user_dir/all_blogs"
        for author in $(yq e '.authors[]' "$CONFIG"); do
            ln -sf "/home/authors/$author/public" "$user_dir/all_blogs/$author"
        done
    done
}

assign_mod_access() {
    for mod in $(yq e '.moderators[].name' "$CONFIG"); do
        mod_dir="/home/mods/$mod"
        mkdir -p "$mod_dir"
        chown "$mod:g_mod" "$mod_dir"
        chmod 700 "$mod_dir"

        # Assign public directories of authors
        authors=$(yq e ".moderators[] | select(.name == \"$mod\") | .assigned_authors[]" "$CONFIG")
        for author in $authors; do
            ln -sf "/home/authors/$author/public" "$mod_dir/$author"
        done
    done
}

# MAIN EXECUTION
create_group_if_needed g_user
create_group_if_needed g_author
create_group_if_needed g_mod
create_group_if_needed g_admin

# Users
for user in $(yq e '.users[]' "$CONFIG"); do
    create_user_and_dir "$user" g_user "/home/users/$user"
    mkdir -p "/home/users/$user/all_blogs"
    chmod 755 "/home/users/$user/all_blogs"
    chown "$user:g_user" "/home/users/$user/all_blogs"
done

# Authors
for author in $(yq e '.authors[]' "$CONFIG"); do
    create_user_and_dir "$author" g_author "/home/authors/$author"
    mkdir -p "/home/authors/$author/blogs" "/home/authors/$author/public"
    chown -R "$author:g_author" "/home/authors/$author"
done

# Moderators
for mod in $(yq e '.moderators[].name' "$CONFIG"); do
    create_user_and_dir "$mod" g_mod "/home/mods/$mod"
done

# Admin
for admin in $(yq e '.admins[]' "$CONFIG"); do
    create_user_and_dir "$admin" g_admin "/home/admin/$admin"
    usermod -aG g_user,g_author,g_mod "$admin"
done

link_public_dirs_to_users
assign_mod_access

chmod -R g+rX /home/authors/*/public
chmod -R o-rwx /home/authors/*/public
chmod -R 750 /scripts

# Done
