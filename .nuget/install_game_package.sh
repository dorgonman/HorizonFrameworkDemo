#!/bin/bash
set -e
basePath=$(cd "$(dirname "$0")"; pwd)
projectRoot=$(cd "${basePath}/../"; pwd)
pushd ..
    projectFileName=$(find *.uproject)
    projectName=${projectFileName%.*}

    NUGET=${projectRoot}/ue_ci_scripts/bin/Win64/nuget/nuget
    if [ -f "$NUGET" ]
    then
        NUGET=nuget
    fi
popd
packageName=${projectName}

export outputDirectory=$(cd ../../; pwd)

echo outputDirectory: ${outputDirectory}
echo packageName: ${packageName}
echo FEED_NAME: ${FEED_NAME}
pushd ${projectRoot}
    git fetch --prune --tags origin
    git tag -l --points-at HEAD
    packageVersion=$(git tag -l --points-at HEAD | grep -a "editor" | grep -Eo '[.0-9]*{1,9}') || true
popd


if [ -n "${packageVersion}" ]; then
    installVersion="-Version ${packageVersion}"
else
    echo "[Info] can't find packageVersion, will install latest"
    installVersion=' '
fi

cmd=" \
    ${NUGET} install ${packageName} ${installVersion} \
    -OutputDirectory ${outputDirectory} -PackageSaveMode nuspec \
    -Source ${FEED_NAME} \
    -ExcludeVersion -ForceEnglishOutput  \
    "
#-Verbosity detailed
echo ${cmd}
eval ${cmd} 