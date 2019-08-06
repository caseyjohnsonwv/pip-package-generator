# pip-package-generator

- Maintained by Casey Johnson.
- A pip package for easily creating and distributing pip packages.
- https://github.com/caseyjohnsonwv/pip-package-generator
- https://pypi.org/project/pipgen

Installation:
1. Install `Python 3+` and `pip3`.
2. Run `pip3 install pipgen`.

To create a new Python project with the pip package structure:
1. Run `sh pipify.sh <new/project/path>`.

To rearrange a Python project into the pip package structure:
1. Run `sh pipify.sh <existing/project/path>`.

To update a pip package distribution:
1. Run `sh pippush.sh <path/to/project> <local|test|prod>`.

To convert a pip package back into a Python project (for testing only):
1. Run `sh depipify.sh <path/to/project>`.
