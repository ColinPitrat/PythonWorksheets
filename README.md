# PythonWorksheets

[![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/ColinPitrat/PythonWorksheets/blob/main/README.md)
[![fr](https://img.shields.io/badge/lang-fr-blue.svg)](https://github.com/ColinPitrat/PythonWorksheets/blob/main/README-fr.md)

[![Release](https://github.com/ColinPitrat/PythonWorksheets/actions/workflows/build.yml/badge.svg)](https://github.com/ColinPitrat/PythonWorksheets/actions/workflows/build.yml)

Some worksheets to learn programming in Python for kids.

See also [my Linux worksheets](https://github.com/ColinPitrat/LinuxWorksheets)

You can download all the sheets as PDF:
 - [one file per sheet (zip)](https://github.com/ColinPitrat/PythonWorksheets/releases/download/latest/python-sheets-en.zip)
 - [all sheets in one file (pdf)](https://github.com/ColinPitrat/PythonWorksheets/releases/download/latest/python-sheets-en.pdf)

## Building

To build the sheets from source, you need:
 - `make`
 - `typest`
 - the fonts `Linux Libertine` and `Fira Code`

To install the required packages on Debian and its derivatives:
```
sudo apt install make typest fonts-linuxlibertine fonts-firacode snapd
sudo snap install typst
```

Build the sheets from source with:
```
make
```

----

The previous version of these sheets were using LibreOffice and were not split per project.

You can download all the old sheets as PDF:
 - [one file per sheet (zip)](https://github.com/ColinPitrat/PythonWorksheets/releases/download/latest/python-sheets-old-en.zip)
 - [all sheets in one file (pdf)](https://github.com/ColinPitrat/PythonWorksheets/releases/download/latest/python-sheets-old-en.pdf)
