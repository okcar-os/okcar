#!/bin/bash
# Get the directory of the current script
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
AOSP_DIR=$(readlink -f "$SCRIPT_DIR/../../../")

# Define the file mapping, format is "local path download link expected hash"
file_map=(
    "OkAutoconn/autoconn.apk https://cdn.okcaros.com/apps/autoconn_265_0822_22_36.apk c63e23b0b26fae4411f5ec28d98deafd85892306ff59c6946c7dd34f750a4832"
    "OkMinusScreen/minusscreen.apk https://cdn.okcaros.com/apps/minusscreen_1_0822_22_41.apk a1e0d17a91fded886bdaf255a2e7093ef2c64071e02a55c2b581bfb6af197eea"
    "OkAppStore/okappstore.apk https://cdn.okcaros.com/apps/okappstore_9_0822_22_48.apk 28d0ed0bb1baa12f3628ffb5aa478716c274e46c5d3ee98b92dd4def97c676c9"    
    "OkLauncher/oklauncher.apk https://cdn.okcaros.com/apps/oklauncher_12010005_0822_23_01.apk 5a042fc0cbe28501920f60a49354f96cbd232df2d42d48b04993f94f49608497"
)

# Traverse through key-value pairs in the map, download files and verify hashes
for item in "${file_map[@]}"; do
    IFS=' ' read -r -a item_array <<< "$item"
    projName="${item_array[0]%%/*}"
    destDir="$SCRIPT_DIR/apps/$projName"
    apk_name=$(basename "${item_array[0]}")
    local_path="$destDir/$apk_name"

    download_link="${item_array[1]}"
    expected_hash="${item_array[2]}"

    if [ -e "$local_path" ]; then
        local_hash=$(sha256sum "$local_path" | awk '{print $1}')
        if [ "$local_hash" = "$expected_hash" ]; then
            echo "$apk_name already exists and hash matches."
            continue  # Hash matches, skip downloading
        else
            echo "$apk_name exists but hash doesn't match. Redownloading..."
            rm "$local_path"
        fi
    else
        echo "Downloading $apk_name ..."
    fi

    # Download the file
    wget -O "$local_path" "$download_link"

    # Check if the download was successful
    if [ $? -eq 0 ]; then
        downloaded_hash=$(sha256sum "$local_path" | awk '{print $1}')
        if [ "$downloaded_hash" = "$expected_hash" ]; then
            echo "$apk_name download and hash verification succeeded."
        else
            echo "$apk_name download succeeded but hash verification failed."
        fi
    else
        echo "$apk_name download failed."
    fi
done
