# PythonWorksheets

[![en](https://img.shields.io/badge/lang-en-red.svg)](https://github.com/ColinPitrat/PythonWorksheets/blob/main/README.md)
[![fr](https://img.shields.io/badge/lang-fr-blue.svg)](https://github.com/ColinPitrat/PythonWorksheets/blob/main/README-fr.md)


[![Release](https://github.com/ColinPitrat/PythonWorksheets/actions/workflows/build.yml/badge.svg)](https://github.com/ColinPitrat/PythonWorksheets/actions/workflows/build.yml)

Des fiches pour apprendre aux enfants à programmer en Python.

J'ai aussi des [fiches sur Linux](https://github.com/ColinPitrat/LinuxWorksheets/blob/main/README-fr.md)

Les fiches au format PDF peuvent être téléchargées:
 - [un fichier par fiche (zip)](https://github.com/ColinPitrat/PythonWorksheets/releases/download/latest/python-sheets-fr.zip)
 - [toutes les fiches en un seul fichier (pdf)](https://github.com/ColinPitrat/PythonWorksheets/releases/download/latest/python-sheets-fr.pdf)

## Compiler les fiches

Pour compiler les fiches il vous faudra:
 - `make`
 - `typest`
 - les polices de caractères `Linux Libertine` et `Fira Code`

Pour installer les paquets requis sous Debian et ses dérivées:
```
sudo apt install make typest fonts-linuxlibertine fonts-firacode snapd
sudo snap install typst
```

Puis compiler les fiches depuis les sources:
```
make
```

----

Une précédente version des fiches utilisait LibreOffice et était constitué d'un seul curriculum linéaire.

Elles peuvent être téléchargées au format PDF:
 - [un fichier par fiche (zip)](https://github.com/ColinPitrat/PythonWorksheets/releases/download/latest/python-sheets-old-fr.zip)
 - [toutes les fiches en un seul fichier (pdf)](https://github.com/ColinPitrat/PythonWorksheets/releases/download/latest/python-sheets-old-fr.pdf)
