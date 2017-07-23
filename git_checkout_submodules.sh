GIT_BRANCH=$(git symbolic-ref --short HEAD)

git submodule foreach --recursive "git checkout -f ${GIT_BRANCH} || :"
git submodule foreach --recursive "git pull"


