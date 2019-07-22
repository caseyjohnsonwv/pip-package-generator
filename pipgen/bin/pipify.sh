echo ''

#folder containing package must be supplied
if [ $# -lt 1 ]; then
  printf "Usage: 'pipify.sh (path to Python project)'\n"
  exit
fi
PROJ_PATH=$1

#create new project if directory not found
CREATE="N"
if [ ! -d "$PROJ_PATH" ]; then
  read -p "Path '$PROJ_PATH' not found - create new project? [y/N]: " CREATE
  if [ ${CREATE:0:1} = "y" ] || [ ${CREATE:0:1} = "Y" ]; then
    CREATE="Y"
    mkdir "$PROJ_PATH"
  else
    exit
  fi
fi
cd "$PROJ_PATH"

#check for pre-pipified project
if [ -f "setup.py" ] || [ -d "$PKG_NAME" ]; then
  printf "Found 'setup.py' - project already pipified.\n"
  exit
fi

printf "Creating package file hierarchy.\n"
#package name is always the same as its parent folder
PKG_NAME=${PWD##*/}
mkdir "$PKG_NAME"
SEARCHTREE="./*/"
if [ "$CREATE" = "Y" ]; then
  echo '' > $PKG_NAME/project.py
else
  #move all source to package and populate imports in __init__.py
  printf "Moving project source to package.\n"
  mv *.py */ ./"$PKG_NAME" 2>/dev/null || true
  if [ -d $SEARCHTREE/**/ ]; then
    SEARCHTREE="./*/ ./*/**/"
  fi
fi
for DIR in $SEARCHTREE; do
  NUMPYFILES=$(ls -1 $DIR | grep '.py'| wc -l | sed -E 's/[[:blank:]]//g')
  if [ $NUMPYFILES != "0" ]; then
    echo "$(ls -1 "$DIR" | grep .py | sed -E 's/^/from \./g' | sed -E 's/.py//g' | sed -E 's/$/ import */g')" > ./"$DIR"/__init__.py
  fi
done
#move extensionless script files to /bin
INCLUDESCRIPTS="$(ls -F | grep -v '/' | grep -v '\.' | grep -v 'LICENSE') $(ls | grep '.sh')"
if [ "$INCLUDESCRIPTS" != " " ]; then
  mkdir ./bin
  mv $INCLUDESCRIPTS ./bin
  #get files in python list syntax for setup.py
  INCLUDESCRIPTS=$(echo $INCLUDESCRIPTS\"] | sed -E 's/^/["bin\//' | sed -E 's/[[:blank:]]/","bin\//g')
else
  INCLUDESCRIPTS="[]"
fi

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

#create a license, readme, and manifest if not already present
if [ ! -f "README.md" ]; then
  printf "Creating package README file.\n"
  echo "# $PKG_NAME" > README.md
fi

if [ ! -f "LICENSE" ]; then
  printf "Creating package LICENSE file.\n"
  echo "https://choosealicense.com/" > LICENSE
fi

if [ ! -f "MANIFEST.in" ]; then
  printf "Creating package MANIFEST file.\n"
  echo '' > MANIFEST.in
fi

#generate setup.py template
printf "Creating setup.py from project dependencies.\n"
PYTHON_VERSION=$(python3 --version | sed -E 's/Python //')
PYTHON_VERSION=${PYTHON_VERSION:0:1}
cat > setup.py <<- EOM
import setuptools

with open("README.md", "r") as fh:
  long_description = fh.read()

setuptools.setup(
  name = "$PKG_NAME",
  version = "0.0.1",
  author = "",
  author_email = "",
  description = "",
  long_description = long_description,
  long_description_content_type = "text/markdown",
  url = "",
  packages = setuptools.find_packages(),
  include_package_data = True,
  scripts = $INCLUDESCRIPTS,
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

printf "\nPip package '$PKG_NAME' successfully created.\n\n"
