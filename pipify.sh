
#folder containing package must be supplied
if [ $# -lt 1 ]; then
  printf "Usage: 'pipify.sh (path to Python project)'\n"
  exit
fi
cd $1

#check for pre-pipified project
if [ -f "setup.py" ]; then
  printf "Found 'setup.py' - project already pipified.\n"
  exit
fi

#package name is always the same as its parent folder
printf "Creating package file hierarchy.\n"
PKG_NAME=${PWD##*/}
mkdir "$PKG_NAME"

#move all source to package and populate imports in __init__.py
printf "Moving project source to package.\n"
mv *.py */ ./"$PKG_NAME" 2>/dev/null || true
SEARCHTREE="./*/"
if [ -d $SEARCHTREE/**/ ]; then
  SEARCHTREE="./*/**/"
fi
for DIR in $SEARCHTREE; do
  echo "$(ls -1 "$DIR" | grep .py | sed -E 's/^/from \./g' | sed -E 's/.py//g' | sed -E 's/$/ import */g')" > ./"$DIR"/__init__.py
done

#get dependencies in python list syntax, then move requirements.txt to package
if [ ! -f "requirements.txt" ]; then
  printf "Creating project requirements.txt.\n"
  echo '' > requirements.txt
fi
printf "Reading project dependencies from requirements.txt.\n"
REQUIREMENTS=$(echo $(cat requirements.txt)\"] | sed 's/^/["/' | sed -E 's/[[:blank:]]+/","/g')
if [ $REQUIREMENTS = "[\"\"]" ]; then
  REQUIREMENTS="[]"
fi
mv requirements.txt ./"$PKG_NAME"

#create a license and readme if not already present
if [ ! -f "README.md" ]; then
  printf "Creating package README file.\n"
  echo "" > README.md
fi

if [ ! -f "LICENSE" ]; then
  printf "Creating package LICENSE file.\n"
  echo "https://choosealicense.com/" > LICENSE
fi

#generate setup.py template
printf "Creating setup.py from project dependencies.\n"
PYTHON_VERSION=$(python3 --version | sed -E 's/[Pp]ython //')
cat > setup.py <<- EOM
import setuptools

with open("README.md", "r") as fh:
  long_description = fh.read()

setuptools.setup(
  name = ""$PKG_NAME"",
  version = "0.0.1",
  author = "Author Name",
  author_email = "person@example.com",
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
printf "Creating package requirements.txt.\n"
echo "twine\nsetuptools\nwheel" > requirements.txt

printf "\nPip package '"$PKG_NAME"' successfully created.\n\n"
