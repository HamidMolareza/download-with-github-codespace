#!/bin/bash

chmod -R +x .

echo 'export PATH="$PWD/script:$PATH"' >> ~/.bashrc

source ~/.bashrc