import setuptools

with open("README.md", "r") as fh:
  long_description = fh.read()

setuptools.setup(
  name = "pipgen",
  version = "0.0.2",
  author = "Casey Johnson",
  author_email = "ctj0001@mix.wvu.edu",
  description = "A package for easily creating and distributing pip packages.",
  long_description = long_description,
  long_description_content_type = "text/markdown",
  url = "https://github.com/caseyjohnsonwv/pip-package-generator",
  packages = setuptools.find_packages(),
  include_package_data = True,
  scripts = ['./pipgen/pipify.sh', './pipgen/depipify.sh', './pipgen/update.sh'],
  install_requires = [],
  classifiers = [
    "Programming Language :: Python :: 3",
    "License :: OSI Approved :: MIT License",
    "Operating System :: OS Independent",
  ],
)
