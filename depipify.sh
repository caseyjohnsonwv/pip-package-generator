
#this is an 'undo' tool, meant only for testing

if [ $# -lt 1 ]; then
  printf "\nPACKAGE FOLDER PATH REQUIRED\n"
  exit
fi
cd $1

PKG_NAME=${PWD##*/}
rm requirements.txt
mv "$PKG_NAME"/* .
mv __init__.py setup.py "$PKG_NAME"
rm -rf "$PKG_NAME"
