
#folder containing package can be supplied
if [ $# -gt 0 ]; then
  cd $*
fi

#package name is always the same as its parent folder
PKG_NAME=${PWD##*/}
mkdir $PKG_NAME

#move all source to package and create empty __init__.py
mv *.py ./$PKG_NAME
echo "" > ./$PKG_NAME/__init__.py

#get dependencies in python list syntax, then move requirements.txt to package
REQUIREMENTS=$(echo $(cat requirements.txt)\"] | sed 's/^/["/' | sed -E 's/[[:blank:]]+/","/g')
mv requirements.txt ./$PKG_NAME

#generate setup.py template
PYTHON_VERSION=$(python3 --version | sed -E 's/[Pp]ython //')
cat > setup.py <<- EOM
import setuptools

with open("README.md", "r") as fh:
  long_description = fh.read()

setuptools.setup(
  name = "$PKG_NAME",
  version = "0.0.1",
  author = "",
  author_email = "",
  description = "Auto-generated pip package from GitHub project 'pip-package-generator'.",
  long_description = long_description,
  long_description_content_type = "text/markdown",
  url = "https://github.com/caseyjohnsonwv/pip-package-generator",
  packages = setuptools.find_packages(),
  install_requires = $REQUIREMENTS,
  classifiers = [
    "Programming Language :: Python :: $PYTHON_VERSION",
    "License :: LICENSE UNKNOWN",
    "Operating System :: OS Independent",
  ],
)
EOM

#create a file for pip3 requirements
echo "twine\nsetuptools\nwheel" > requirements.txt

#create a license and readme if not already present
if [ ! -f "README.md" ]; then
  echo "" > README.md
fi

if [ ! -f "LICENSE" ]; then
  echo "https://choosealicense.com/" > LICENSE
fi
