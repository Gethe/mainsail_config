#!/bin/sh

if [ -e /tmp/printer ]; then
    echo "RESTART" > /tmp/printer
fi
