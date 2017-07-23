GIT_PATH=$(grep path .gitmodules | sed 's/.*= //')
GIT_URL=$(grep url .gitmodules | sed 's/.*= //')
#echo ${GIT_PATH}
#echo ${GIT_URL}

i=0
for path in ${GIT_PATH}; do
GIT_PATH_ARRAY[i]=${path}
i=$((i+1))
done

i=0
for path in ${GIT_URL}; do
GIT_URL_ARRAY[i]=${path}
i=$((i+1))
done


nArray=${#GIT_PATH_ARRAY[@]}
echo nArray: ${nArray}

for (( i=0; i<${nArray}; i++ ));
do
#echo "${i} path:" ${GIT_PATH_ARRAY[$i]}
#echo "${i} url:" ${GIT_URL_ARRAY[$i]}
git submodule add ${GIT_URL_ARRAY[$i]} ${GIT_PATH_ARRAY[$i]}
done