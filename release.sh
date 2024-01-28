#!/bin/bash

source ~/anaconda3/etc/profile.d/conda.sh
conda activate base
rm tests.log
rm dist* -r
rm -r .tox
rm -r .pytest_cache
rm -r build
rm -r alexfitter-reqs
rm -R *egg-info
conda remove -n alexfitter-reqs --all -y
set +e
rm tests.log
rm -r .tox
rm -r .pytest_cache
rm -r build
rm -r alexfitter-reqs
rm -R *egg-info
git_tag=$1
conda remove -n alexfitter-reqs --all -y
set -e
conda create -n alexfitter-reqs python=3.10 -y
conda activate alexfitter-reqs
python3 -m pip install pip -U
python3 -m pip install numpy==1.23.5
sed -i '23s/.*/version = "'${git_tag}'",/' setup.py
python3 -m pip install -e .
python3 -m pip list --format=freeze > requirements.txt
conda deactivate
git add requirements.txt
git add setup.py
git commit -m "Preparing release ${git_tag}"
git tag ${git_tag} -m "New release"
git push
git push --tags
set +e
rm -R alexfitter-reqs
rm dist* -r
rm -r .tox
rm -r .pytest_cache
rm -r build
rm -R *egg-info
conda remove -n alexfitter-reqs --all -y
