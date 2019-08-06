import setuptools

with open("../README.md") as readmefile:
    long_description = readmefile.read()

setuptools.setup(
  name = "pipgen",
  version = "0.2.1",
  author = "Casey Johnson",
  author_email = "ctj0001@mix.wvu.edu",
  description = "A package for easily creating and distributing pip packages.",
  long_description = long_description,
  long_description_content_type = "text/markdown",
  url = "https://github.com/caseyjohnsonwv/pip-package-generator",
  packages = setuptools.find_packages(),
  include_package_data = True,
  scripts = ['./bin/pipify.sh', './bin/depipify.sh', './bin/pippush.sh'],
  install_requires = ['twine', 'setuptools', 'wheel'],
  classifiers = [
    "Programming Language :: Python :: 3",
    "License :: OSI Approved :: MIT License",
    "Operating System :: OS Independent",
  ],
)
