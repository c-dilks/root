#!/usr/bin/env bash
#
# custom build for `dispin`
#
set -e

parent_dir=$(realpath ..)
ver=$(git rev-parse --abbrev-ref HEAD)
build_dir=$parent_dir/root-$ver-build
install_dir=$parent_dir/root-$ver-install
echo """
===============================================
parent_dir  = $parent_dir
ver         = $ver
build_dir   = $build_dir
install_dir = $install_dir
===============================================
echo: pausing for 10 seconds, so you can check if these variables are right...
"""
sleep 10

# build options
build_opts=(
  -Dmathmore=ON # for brufit
  -Dproof=ON # for brufit
  -Dbuiltin_tbb=ON # for 6.30.08 compatibility with Arch Linux, which currently has onetbb 2022.0.0-2 (maybe too new)
)

cmake -S . -B $build_dir --install-prefix=$install_dir ${build_opts[*]}
cmake --build $build_dir -j4
cmake --install $build_dir
