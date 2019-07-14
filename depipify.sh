
if [ $# -lt 1 ]; then
  echo PACKAGE FOLDER PATH REQUIRED
  exit
fi
cd $1

PKG_NAME=${PWD##*/}
rm requirements.txt
mv $PKG_NAME/* .
mv __init__.py setup.py $PKG_NAME
rm -rf $PKG_NAME
