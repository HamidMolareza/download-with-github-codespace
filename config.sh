#!/bin/bash

chmod -R +x .

echo "export PATH=\"$PWD/script:\$PATH\"" >> ~/.bashrc
echo "export PATH=\"$PWD/script/download:\$PATH\"" >> ~/.bashrc
echo "export PATH=\"$PWD/script/s3:\$PATH\"" >> ~/.bashrc

source ~/.bashrc