#!/bin/bash

chmod -R +x .

printf "export PATH=\"$PWD/scripts:\$PATH\"" >> ~/.bashrc
printf "export PATH=\"$PWD/scripts/s3:\$PATH\"" >> ~/.bashrc
printf "export PATH=\"$PWD/scripts/download:\$PATH\"" >> ~/.bashrc

source ~/.bashrc