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
if [ $WHERE = "local" ]; then
  printf "Uninstalling and reinstalling '$PKG_NAME' with pip.\n"
  pip3 uninstall -q "$PKG_NAME" -y
  pip3 install -q --no-cache-dir dist/*.whl
fi

#release new version on test.pypi, then install on local
if [ $WHERE = "test" ]; then
  printf "Uploading '$PKG_NAME' to https://test.pypi.org/project/$PKG_NAME/.\n"
  twine upload --repository-url https://test.pypi.org/legacy/ dist/*
  sleep 3
  printf "Installing and updating '$PKG_NAME' with pip.\n"
  pip3 install --no-cache-dir --upgrade --index-url https://test.pypi.org/simple "$PKG_NAME"
fi

#release new version on real pypi, then install on local
if [ $WHERE = "prod" ]; then
  printf "Uploading '$PKG_NAME' to https://pypi.org/project/$PKG_NAME/.\n"
  twine upload dist/*
  sleep 3
  printf "Installing and updating '$PKG_NAME' with pip.\n"
  pip3 install --no-cache-dir --upgrade "$PKG_NAME"
  #retroactively release on test.pypi as well
  printf "Uploading '$PKG_NAME' to https://test.pypi.org/project/$PKG_NAME/.\n"
  twine upload --repository-url https://test.pypi.org/legacy/ dist/*
fi

#cleanup build files
rm -rf dist build *.egg-info
cd ..

echo \'$PKG_NAME\' is now on version \'$(pip3 freeze | grep "$PKG_NAME" | sed "s/$PKG_NAME==//")\' && echo ''
