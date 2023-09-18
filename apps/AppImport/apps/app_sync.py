#!/usr/bin/env python

from __future__ import print_function

import base64
import glob
import hashlib
import json
import netrc
import os
import re
import requests
import sys

def download_and_verify_okcar_apps():
    # Get the directory of the current script
    script_dir = os.path.dirname(os.path.realpath(__file__))    
    aosp_root_dir = os.path.realpath(os.path.join(script_dir, '../../../../'))
    apps_dest_dir= os.path.realpath(os.path.join(aosp_root_dir, 'okcar/apps/AppImport/apps'))

    # Load the JSON data from okcar_apps.json
    with open(apps_dest_dir + '/okcar_apps.json', 'r') as json_file:
        app_data = json.load(json_file)

    for app in app_data:
        name = app['name']
        path = app['path']
        url = app['url']
        expected_hash = app['hash']
    
        dest_dir = os.path.join(apps_dest_dir, path)
        local_path = os.path.join(dest_dir, f"{name}.apk")

        if os.path.exists(local_path):
            with open(local_path, 'rb') as f:
                local_hash = hashlib.sha256(f.read()).hexdigest()
            if local_hash == expected_hash:
                #print(f"{name}.apk already exists and hash matches.")
                continue  # Hash matches, skip downloading
            else:
                #print(f"{name}.apk exists but hash doesn't match. Redownloading...")
                os.remove(local_path)
        else:
            print(f"Downloading {local_path} ...")

        #Download the file
        response = requests.get(url)
        if response.status_code == 200:
            os.makedirs(dest_dir, exist_ok=True)
            with open(local_path, 'wb') as f:
                f.write(response.content)

            downloaded_hash = hashlib.sha256(response.content).hexdigest()
            if downloaded_hash == expected_hash:
                print(f"Download succeeded.")
            else:
                print(f"{local_path} download succeeded but hash verification failed.")
                sys.exit(1)
        else:
            print(f"Download failed.")
            sys.exit(1)        

download_and_verify_okcar_apps()
