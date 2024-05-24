#!/bin/bash

# https://github.com/abhinavsingh/proxy.py

docker run -it -p 8899:8899 --rm -d abhinavsingh/proxy.py:latest

echo "Proxy enabled on port 8899."




# Another proxy: https://github.com/qwj/python-proxy