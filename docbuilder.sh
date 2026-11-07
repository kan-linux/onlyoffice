#!/bin/bash
# ONLYOFFICE Document Builder - minimal package for Kan-Linux
# Usage: ./docbuilder.sh <script.js>
DIR="$(cd "$(dirname "$0")" && pwd)"
exec env LD_LIBRARY_PATH="$DIR:$LD_LIBRARY_PATH" "$DIR/docbuilder" "$@"
