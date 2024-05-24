#!/bin/bash

chmod -R +x .

printf "export PATH=\"$PWD/scripts:\$PATH\"" >> ~/.bashrc

source ~/.bashrc