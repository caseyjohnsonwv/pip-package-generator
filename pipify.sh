
if [ $# -gt 0 ]; then
  cd $PWD/$*
fi

PKG_NAME=${PWD##*/}

mkdir $PKG_NAME
mv *.py ./$PKG_NAME
echo -e "twine\nsetuptools\nwheel" > requirements.txt
echo "" > setup.py
echo "" > ./$PKG_NAME/__init__.

if [ ! -f "README.md" ]; then
  echo "" > README.md
fi

if [ ! -f "LICENSE" ]; then
  echo "https://choosealicense.com/" > LICENSE
fi
