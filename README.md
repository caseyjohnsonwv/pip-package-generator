# pip-package-generator

- _Maintained by Casey Johnson._
- A series of shell scripts for easily creating and distributing pip packages.
- https://github.com/caseyjohnsonwv/pip-package-generator


To create a new Python project with the pip package structure:
1. Run `pipify.sh (project-name)`

To convert a Python project into a pip package:
1. Move `pipify.sh` to the top-level source folder.
2. Run `pipify.sh .`

To update a pip package distribution:
1. Move `update.sh` to the top-level package folder (containing `setup.py`).
2. Run `update.sh . (local | test | prod)`

To convert a pip package back into a Python project (for testing only):
1. Move `depipify.sh` to the top-level package folder (containing `setup.py`).
2. Run `depipify.sh .`
