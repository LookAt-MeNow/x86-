#!/bin/bash
set -e

make build/boot.bin || { echo "make boot.bin错误!"; exit 1; }
make build/master.img || { echo "make master.img错误!"; exit 1; }
make bochs || { echo "make bochs错误"; exit 1; }