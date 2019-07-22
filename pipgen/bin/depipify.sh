#this is an 'undo' tool, meant only for testing

if [ $# -lt 1 ]; then
  printf "\nPACKAGE FOLDER PATH REQUIRED\n"
  exit
fi
cd $1

if [ ! -f "setup.py" ]; then
  printf "\nPROJECT ALREADY DE-PIPIFIED\n"
  exit
fi

PKG_NAME=${PWD##*/}
rm requirements.txt
for DIR in ./*/ ./*/**/; do
  rm "$DIR"/__init__.py 2>/dev/null || true
done
mv */* . 2>/dev/null || true
rm setup.py
rm -rf "$PKG_NAME" 2>/dev/null || true
