#!/bin/sh

if [ $# -lt 2 ]; then
  echo ''
  echo Usage: "'update.sh (package_name) (local | test | prod)'"
  echo ''
  exit
fi
PKG_NAME=$1
WHERE=$2

if [ ! ${PWD##*/} = $PKG_NAME ]; then
  cd $PKG_NAME
fi

pip3 install --upgrade --no-cache-dir -r requirements.txt
python3 setup.py sdist bdist_wheel

if [ $WHERE = "local" ]; then
  pip3 uninstall $PKG_NAME -y
  pip3 install --no-cache-dir dist/*.whl
fi

if [ $WHERE = "test" ]; then
  twine upload --repository-url https://test.pypi.org/legacy/ dist/*
  sleep 3
  pip3 install --no-cache-dir --upgrade --index-url https://test.pypi.org/simple $PKG_NAME
fi

if [ $WHERE = "prod" ]; then
  twine upload dist/*
  sleep 3
  pip3 install --no-cache-dir --upgrade $PKG_NAME
fi

rm -rf dist build $PKG_NAME.egg-info
pip3 freeze | grep $PKG_NAME

cd ..
