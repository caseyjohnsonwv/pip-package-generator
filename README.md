# pip-package-generator

####Maintained by Casey Johnson.

https://github.com/caseyjohnsonwv/pip-package-generator


A series of shell scripts for easily creating and distributing pip packages.


To convert a Python project into a pip package:
1. Move `pipify.sh` to the top-level source folder.
2. Run `pipify.sh .`

To update a pip package distribution:
1. Move `update.sh` to the top-level package folder (containing `setup.py`).
2. Run `update.sh . (local | test | prod)`

To convert a pip package back into a Python project (for testing only):
1. Move `depipify.sh` to the top-level package folder (containing `setup.py`).
2. Run `depipify.sh` .'
