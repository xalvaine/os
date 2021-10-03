#!/bin/bash

for filename in "$(pwd)"/*; do
  cp "$filename" "$filename".bak
done
