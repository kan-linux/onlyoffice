# ONLYOFFICE Document Builder — Minimal Package for Kan-Linux

The minimal ONLYOFFICE document engine, built from source within Kan-Linux v0.3.1, demonstrates that Kan-Linux is capable of serving as a productivity OS. Supports parsing/converting docx, xlsx, pptx, pdf and other formats.

## Quick Start

```bash
# Convert document to PDF
./doc2.sh doc2pdf input.docx output.pdf

# Extract text content
./doc2.sh doc2txt input.docx output.txt

# Convert PDF to DOCX
./doc2.sh doc2docx input.pdf output.docx

# Raw JS script mode
./docbuilder.sh myscript.js

```

## Script API Examples

```javascript
// Create a document
builder.CreateFile("docx")
var oDocument = Api.GetDocument()
var oParagraph = oDocument.GetElement(0)
oParagraph.AddText("Hello!")
builder.SaveFile("docx", "/tmp/out.docx")
builder.CloseFile()

// Open and convert
builder.OpenFile("/tmp/input.docx")
builder.SaveFile("pdf", "/tmp/output.pdf")
builder.CloseFile()
```

## Directory Structure

```
/
├── docbuilder          # Main program (JS script executor)
├── x2t                 # Format converter
├── docbuilder.sh       # Launcher script (sets LD_LIBRARY_PATH)
├── doc2.sh             # Convenience tools (doc2pdf/doc2txt/doc2docx)
├── DoctRenderer.config # V8 engine configuration
├── *.so                # Core engine libraries (19 files)
├── sdkjs/              # JS document engine runtime
├── fonts/              # Fonts + rendering cache
├── dictionaries/       # Spell-check dictionaries
├── empty/              # Blank document templates
├── cmap.bin            # Character map
├── font_selection.bin  # Font selection cache
├── icudtl.dat          # ICU data
└── icudtl_extra.dat    # ICU extended data
```

## System Dependencies

Only the following system-level shared libraries are needed (verified via ldd):

| Library | Min Version | Purpose |
|---------|-------------|---------|
| libc.so.6 | 2.23+ | C standard library |
| libstdc++.so.6 | 6.0+ | C++ runtime |
| libgcc_s.so.1 | 7.0+ | GCC runtime |
| libm.so.6 | 2.23+ | Math library |
| libmvec.so.1 | 2.23+ | Vector math (glibc) |

**No other external dependencies** — all ONLYOFFICE engine libraries are bundled (V8 JS engine, ICU, graphics rendering, etc.).


## Package Size

- Total: ~226MB
- Core engines (.so): ~80MB
- x2t converter: 55MB
- sdkjs runtime: 34MB
- Fonts: 15MB
- Dictionaries: 5.9MB
- Data files: 12MB

## Optional Trim

- `libIWorkFile.so` (5.2MB) — Apple iWork format, safe to remove if not needed
- `libHWPFile.so` (3MB) — Korean Hangul format
- `libFb2File.so` (1.1MB) — FictionBook format
- `dictionaries/` (5.9MB) — spell-check, safe to remove if not needed
- Fonts can be trimmed further (currently Latin base fonts only)
