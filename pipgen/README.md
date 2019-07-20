# pip-package-generator

- Maintained by Casey Johnson.
- A pip package for easily creating and distributing pip packages.
- https://github.com/caseyjohnsonwv/pip-package-generator
- https://pypi.org/project/pipgen

Installation:
1. Install `Python 3` and `pip3`.
2. Run `pip install pipgen`.

To create a new Python project with the pip package structure:
1. Launch the Python3 interpreter with the command `Python` or `Python3`.
2. Run `import pipgen`.
3. Run `pipgen.pipify('< projectname >')`.

To convert a Python project into a pip package:
1. Launch the Python3 interpreter with the command `Python` or `Python3`.
2. Run `import pipgen`.
3. Run `pipgen.pipify('< path/to/project >')`.

To update a pip package distribution:
1. Launch the Python3 interpreter with the command `Python` or `Python3`.
2. Run `import pipgen`.
3. Run `pipgen.update('< path/to/project >', < 'local' | 'test' | 'prod' >)`.

To convert a pip package back into a Python project (for testing only):
1. Launch the Python3 interpreter with the command `Python` or `Python3`.
2. Run `import pipgen`
3. Run `pipgen.depipify('< path/to/project >')`
