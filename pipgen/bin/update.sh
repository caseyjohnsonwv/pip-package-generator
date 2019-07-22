if [ $# -lt 2 ]; then
  printf "Usage: 'update.sh (path to package top-level) (local | test | prod)'\n\n"
  exit
fi
WHERE=$2
cd $1
PKG_NAME=${PWD##*/}

#install/update requirements for using pip
printf "Installing and updating pip dependencies.\n"
pip3 install -q --upgrade --no-cache-dir -r requirements.txt

#build pip package
printf "Building package from file hierarchy.\n"
python3 setup.py -q sdist -q bdist_wheel

#install new version on local only
printf "Uninstalling and reinstalling '$PKG_NAME' with pip.\n"
pip3 uninstall -q "$PKG_NAME" -y
pip3 install -q --no-cache-dir dist/*.whl

#install on local, then release on test.pypi
if [ $WHERE = "test" ]; then
  printf "Uploading '$PKG_NAME' to https://test.pypi.org/project/$PKG_NAME/.\n"
  twine upload --repository-url https://test.pypi.org/legacy/ dist/*
fi

#install on local, then release on production pypi
if [ $WHERE = "prod" ]; then
  printf "Uploading '$PKG_NAME' to https://pypi.org/project/$PKG_NAME/.\n"
  twine upload dist/*
fi

#cleanup build files
rm -rf dist build *.egg-info
cd ..

echo \'$PKG_NAME\' is now on version \'$(pip3 freeze | grep "$PKG_NAME" | sed "s/$PKG_NAME==//")\' && echo ''
