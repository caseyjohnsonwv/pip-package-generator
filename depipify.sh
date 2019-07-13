if [ $# -gt 0 ]; then
  cd $*
fi

PKG_NAME=${PWD##*/}
rm requirements.txt
mv $PKG_NAME/* .
mv __init__.py setup.py $PKG_NAME
rm -rf $PKG_NAME
