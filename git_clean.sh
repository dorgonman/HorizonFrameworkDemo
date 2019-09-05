#!/bin/sh
set -e
git clean -xfdd
git submodule foreach --recursive "git clean -xfdd"