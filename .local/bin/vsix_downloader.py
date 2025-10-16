#!/usr/bin/env python
import sys
unique_identifier = sys.argv[1]
version = sys.argv[2]
target_platform = ''
if len(sys.argv) > 3:
    target_platform = sys.argv[3]

publisher, package = unique_identifier.split('.')
url = (
    f'https://marketplace.visualstudio.com/_apis/public/gallery/publishers/{publisher}/vsextensions/{package}/{version}/vspackage?targetPlatform='
    + (f'{target_platform}' if target_platform else 'win32-x64'))
print(url)
