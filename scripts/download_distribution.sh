#!/bin/bash
set -ev

# Copyright (C) 2013 Goodow.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

j2objc_version=1.0.1

if [[ -d dist ]]; then
  exit
fi

echo "fetching j2objc"
curl -OL https://github.com/AJ9/j2objc/releases/download/1.0.1.0/J2ObjC101.zip
mkdir dist
unzip -q J2ObjC101.zip
rm -rf __MACOSX
