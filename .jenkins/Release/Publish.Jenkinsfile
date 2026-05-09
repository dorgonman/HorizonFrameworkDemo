// .jenkins/Release/Jenkinsfile — release publish entrypoint for HorizonFrameworkDemo.
@Library('jenkins-unreal-pipeline-library') _

unrealReleaseDeployPipeline(
    upstreamJob: 'HorizonPlugin/HorizonFrameworkDemo/Build/Development',
    ugsBuildJob: 'HorizonPlugin/HorizonFrameworkDemo/Build/UGSBuild'
)