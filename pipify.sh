
if [ $# -gt 0 ]; then
  cd $PWD/$*
fi

PKG_NAME=${PWD##*/}

mkdir $PKG_NAME
mv *.py ./$PKG_NAME
echo "" > ./$PKG_NAME/__init__.py
echo "" > setup.py
echo "" > LICENSE
echo -e "twine\nsetuptools\nwheel" > requirements.txt

if [ ! -f "README.md" ]; then
  echo "" > README.md
fi
