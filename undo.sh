
if [ $# -gt 0 ]; then
  cd $PWD/$*
fi

PKG_NAME=${PWD##*/}
mv $PKG_NAME/*.py .
mv __init__.py setup.py LICENSE requirements.txt $PKG_NAME
rm -rf $PKG_NAME
