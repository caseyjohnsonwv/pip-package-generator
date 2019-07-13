
if [ $# -gt 0 ]; then
  cd $*
fi

PKG_NAME=${PWD##*/}
mv $PKG_NAME/*.py .
mv __init__.py setup.py requirements.txt $PKG_NAME
rm -rf $PKG_NAME
