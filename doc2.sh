#!/bin/bash
# ONLYOFFICE Document Builder convenience tools for Kan-Linux
# Usage:
#   doc2pdf <input.docx|pdf|xlsx|pptx> <output.pdf>
#   doc2txt <input.docx|pdf> <output.txt>
#   doc2docx <input.pdf> <output.docx>
DIR="$(cd "$(dirname "$0")" && pwd)"
export LD_LIBRARY_PATH="$DIR:$LD_LIBRARY_PATH"

case "$1" in
  doc2pdf)
    [ $# -lt 3 ] && echo "Usage: doc2pdf <input> <output.pdf>" && exit 1
    SCRIPT=$(mktemp /tmp/doc2pdf.XXXXXX.js)
    cat > "$SCRIPT" << EOF
builder.OpenFile("$2")
builder.SaveFile("pdf", "$3")
builder.CloseFile()
EOF
    "$DIR/docbuilder" "$SCRIPT"; RC=$?
    rm -f "$SCRIPT"
    exit $RC
    ;;
  doc2txt)
    [ $# -lt 3 ] && echo "Usage: doc2txt <input> <output.txt>" && exit 1
    SCRIPT=$(mktemp /tmp/doc2txt.XXXXXX.js)
    cat > "$SCRIPT" << EOF
builder.OpenFile("$2")
builder.SaveFile("txt", "$3")
builder.CloseFile()
EOF
    "$DIR/docbuilder" "$SCRIPT"; RC=$?
    rm -f "$SCRIPT"
    exit $RC
    ;;
  doc2docx)
    [ $# -lt 3 ] && echo "Usage: doc2docx <input.pdf> <output.docx>" && exit 1
    SCRIPT=$(mktemp /tmp/doc2docx.XXXXXX.js)
    cat > "$SCRIPT" << EOF
builder.OpenFile("$2")
builder.SaveFile("docx", "$3")
builder.CloseFile()
EOF
    "$DIR/docbuilder" "$SCRIPT"; RC=$?
    rm -f "$SCRIPT"
    exit $RC
    ;;
  *)
    echo "ONLYOFFICE Document Builder tools"
    echo ""
    echo "Commands:"
    echo "  doc2pdf  <input> <output.pdf>   Convert document to PDF"
    echo "  doc2txt  <input> <output.txt>   Extract text content"
    echo "  doc2docx <input.pdf> <output.docx>  Convert PDF to DOCX"
    echo ""
    echo "Raw builder:"
    echo "  ./docbuilder.sh <script.js>"
    exit 0
    ;;
esac
