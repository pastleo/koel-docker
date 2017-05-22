#!/bin/sh

echo ">> creating user koel with uid $KOEL_UID..."
adduser -u $KOEL_UID -D koel || true

