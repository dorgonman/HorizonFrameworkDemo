[Marketplace](https://www.unrealengine.com/marketplace/horizonframework-plugin) 


[![Build Status](https://hsgame.visualstudio.com/UE4HorizonPlugin/_apis/build/status/HorizonFramework/HorizonFrameworkDemo-Shipping-CI?branchName=master)](https://hsgame.visualstudio.com/UE4HorizonPlugin/_build/latest?definitionId=28&branchName=master)

public feed: nuget.org  

[![nuget.org package in feed in ](https://img.shields.io/nuget/v/HorizonFrameworkDemo.svg)](https://www.nuget.org/packages/HorizonFrameworkDemo/)

private feed(only for internal use): 

[![HorizonFrameworkDemo package in UE4HorizonPlugin feed in Azure Artifacts](https://feeds.dev.azure.com/hsgame/_apis/public/Packaging/Feeds/319fdc64-73ff-4910-b3b8-2ee206a67a49/Packages/5098845a-f9dd-48c2-a996-f5fc69389226/Badge)](https://dev.azure.com/hsgame/UE4HorizonPlugin/_packaging?_a=package&feed=319fdc64-73ff-4910-b3b8-2ee206a67a49&package=5098845a-f9dd-48c2-a996-f5fc69389226&preferRelease=true)


Note: 

master branch may be unstable since it is in development, please switch to tags, for example: editor/4.25.0



----------------------------------------------  
How to Run Demo Project before purchase:(Only for Win64 editor build, no source code)
1. [Download nuget executable](https://www.nuget.org/downloads) and copy the exe into C:\Windows\system32\ or any place listed in your PATH environment.
2. Install [Git for Windows](https://gitforwindows.org/)
3. Double click install_package_from_nuget.org.bat, and check if UE4Editor-*.dll are installed to Binaries\Win64 and Plugins\HorizonFrameworkPlugin\Binaries\Win64\
4. Double click HorizonFrameworkDemo.uproject  
----------------------------------------------

 

----------------------------------------------  
<h2 align="center">				
			HorizonFrameworkPlugin<br>
					4.25.0   <br>
			http://dorgon.horizon-studio.net  <br>
				dorgonman@hotmail.com  <br>
</h2>
----------------------------------------------  

 The goal of this plugin is to provide a general game framework that can manage WidgetBlueprints and related game logic with more organized way.

-----------------------  
System Requirements
-----------------------  
Supported UnrealEngine version: 4.18-4.25


-----------------------
Installation Guide
-----------------------  

Put HorizonFrameworkPlugin into YOUR_PROJECT/Plugins folder, 
and then add module to your project 
YOUR_PROJECT.Build.cs:
PublicDependencyModuleNames.AddRange(new string[] { "HorizonFramework" });

-----------------------
User Guide
-----------------------  
1. Create classes that inherited from AHorizonScene
2. Design your own Widget Blueprint.
3. Assign Widget Blueprint to HorizonScene's HorizonPlugin|Framework|UI|WidgetClass
4. Use functions in AHorizonSceneManager, UHorizonSceneManagerLibrary or UHorizonSceneManagerProxy to control HorizonScene

-----------------------
Technical Details
-----------------------  

List of Modules: HorizonFramework(Runtime), HorizonFrameworkEditor(Editor)

Intended Platform: All Platforms  

Platforms Tested: Windows

Demo Project: https://github.com/dorgonman/HorizonFrameworkDemo

DemoVideo: https://youtu.be/TQ3oFkdn2Pg

-----------------------
What does your plugin do/What is the intent of your plugin
-----------------------  

* Because UMG Widget behavior are encapsulated into HorizonScene, so we need to create classes that inherited from AHorizonScene and use funtions in AHorizonSceneManager to determine which widget we want to display in screen. For example ChangeSceneByClass will create widget assigned in HorizonScene; PushSceneByClass will add Widget on the top of other scene; PopScene will remove top widget in SceneStack from screen.

* AHorizonScene is inherited from AHorizonSceneBase with VR support that will check if game is running in VR mode, if game is running in VR mode, then plugin will use WidgetComponent to display Widget instead of calling AddToViewport.

* AHorizonTutorialSystem is a simple tutorial framework intend to create step by step task.

* UHorizonStaticMeshComponent: StaticMeshComponent that will generate dynamic material automatically.


-----------------------
User Guide
-----------------------

example 1: AHorizonScenen::OnStartTransInNative and AHorizonScenen::OnTopToBackNative Callback
```
	UCLASS()
	class UMyUserWidget: public UUserWidget
	{
		UPROPERTY(meta = (BindWidgetOptional))
		UButton* Button_PushOtherScene;
		UPROPERTY(EditAnywhere, Category = "Scene")
		TSubclassOf<AHorizonSceneBase> OtherSceneClass;
	}

	void UMyUserWidget::NativeConstruct()
	{
		...
		Button_PushOtherScene->OnClicked.AddDynamic(this, &ThisClass::OnPushOtherScene);
		...
	}
	void UMyUserWidget::OnPushOtherScene()
	{
			auto pSceneManager = UHorizonSceneManagerLibrary::GetDefaultSceneManager(this);
			int32 playerIndex = UGameplayStatics::GetPlayerControllerID(GetOwningPlayer());
			auto pSceneEvent = pSceneManager->PushSceneByClass(OtherSceneClass, false, playerIndex);
			auto pTransInScene = pSceneEvent->GetTransInScene();
			ensureMsgf(pTransInScene, TEXT("oops! something error"));
			pTransInScene->OnStartTransInNative.AddLambda([pSceneEvent]()
			{
				auto pOtherSceneWidget = Cast<UMyOtherSceneWidget>>(pSceneEvent->GetTransInSceneWidget());
				pOtherSceneWidget->Setup(false);
			});

			pTransInScene->OnTopToBackNative.AddLambda([this]() 
			{
				auto pOwningPlayer = GetOwningPlayer();
				UWidgetBlueprintLibrary::SetInputMode_UIOnlyEx(pOwningPlayer, Button_PushOtherScene, EMouseLockMode::DoNotLock);
			});

	}
```

-----------------------
Contact and Support
-----------------------  

email: dorgonman@hotmail.com


-----------------------
 Version History
-----------------------  


*4.25.0 

* [UHorizonFrameworkFunctionLibrary] Refactor GetPlayerIndex

* AB#1499 [New][AHorizonSceneManager] Implement IsSceneEventRunning

* AB#1496 [Refactor][UHorizonSceneEvent] Refactor ProcessTransIn and ProcessTransOut

* AB#1496 [New][AHorizonSceneManager] Implement IsEmpty: check SceneEventList and SceneStack

* AB#1495 [New][UHorizonSceneEvent] BlueprintPure for GetTransInScene and GetTransOutScene

* AB#1486 [New][AHorizonSceneManager] Implement CreateScene that the scene will not be managed by SceneManager

* AB#1485 [AHorizonSceneManager] SetVisibilityForAllWidget and Adjust EnableWidget Visibility Toggle

* [Refactor][SceneEvent] Remove Deprecations and remove bGreyOutWhenSceneTransition from PopScene and RemoveScene

* AB#1484 [Refactor]  IsTransInFinished and IsTransOutFinished should check IsAnyAnimationPlaying by default

* AB#1479 [BugFix] Fix ChangeScene and PopScene param setup timing

* AB#1482 [New][UHorizonSceneManagerLibrary] Implement GetSceneManagerWithName

* AB#1479 [BugFix][HorizonScenePushEvent] Fix PopScene didn't pop previous scene correctly

* AB#1333 [New] GetNumSceneEvent

* AB#1332 [New] bAutoSave flag for ApplicationWillEnterBackground and Shutdown

* [HorizonSceneEvent] GetTransInSceneWidget and GetTransOutSceneWidget

* AB#1112 [New] GetDefaultSceneManager should try find SceneManager in level first before spawn one

* AB#1573 [New][HorizonSceneManager] Implement PushSceneByClass_SingleInstance: Check is SceneClass already exist be fore push new scene

* [New][HorizonGameInstance] Implement GetLoadingScreenWidget

* AB#1573 [New][HorizonSceneManager] Implement PushSceneByClass_SingleInstance: Check is SceneClass already exist be fore push new scene

* [BugFix][HorizonGameInstance] Fix MySaveGame GCAssumption warning





*4.24.0 

	New: [HorizonSceneManager] Implement RemoveSceneEvent  

	New: [UHorizonFrameworkFunctionLibrary] GetPlayerIndex  

	BugFix:[AHorizonSceneBase] OwningObject should come from PlayerIndex  

	Refactor:[AHorizonSceneBase] Change IsTransInFinished && IsTransOutFinished to BlueprintNativeEvent  

	Refactor: Adjust naming convention  


*4.23.0

	New: [UHorizonFrameworkFunctionLibrary] ShouldDisplayTouchInterface  

	Refactor: [HorizonSceneManager] Implement PlayerIndex for CreateWidget  
	     
	Refactor: Deprecated Default Functions  

	BugFix: Fix UHorizonFrameworkFunctionLibrary::GetUserWidgetAnimation Crash  

*4.22.0

	BugFix: UserWidget and Scene are created twice  

	New: [HorizonFrameworkFunctionLibrary] SetComponentRotationToPlayer  

	BugFix: [HorizonSceneBase] IsUserWidgetAnimationFinished when animName not found  


*4.21.1

	BugFix: UserWidget and Scene are created twice  

	New: [HorizonFrameworkFunctionLibrary] SetComponentRotationToPlayer  

	BugFix: [HorizonSceneBase] IsUserWidgetAnimationFinished when animName not found  
	
 
*4.21.0

	New: [AHorizonSceneManager] Add GetSceneEventList, GetSceneManagerOfClass and GetSceneManagerByTag.  

	New: [AHorizonSceneBase] Add OnStartTransIn, OnStartTransOut, OnTopToBack and OnBackToTop Callback.  

	New: [AHorizonSceneBase] RegisterAutoGeneratedDefaultEvent for ReceiveBeginPlay, ReceiveEnter, ReceiveStartTransIn, ReceiveOnEnter, ReceiveTickScene, ReceiveExit, ReceiveStartTransOut, ReceiveOnExit and ReceiveEndPlay.  

	BugFix: [AHorizonSceneManager] ClearSceneStack when AHorizonSceneManager::EndPlay  

	BugFix: [AHorizonSceneBase] AHorizonSceneBase::IsUserWidgetAnimationFinished always true if IsDedicatedServer.  

	BugFix: [AHorizonSceneManager] Use PushSceneByClass instead of ChangeScene at BeginPlay.  

	BugFix: [UHorizonChangeSceneEvent] ChangeScene TransInFinished called twice.  

	BugFix:  [AHorizonScene] Don't SetDrawAtDesiredSize by default for WidgetComponent
	BugFix: [UHorizonGameInstance] SaveGame didn't save properly.

	Refactor:  Add Default suffix to functions in UHorizonSceneManagerLibrary, ex:ChangeSceneByClassDefault, PushSceneByClassDefault.

*4.20.0  

	Refactor Source Folder

*4.19.2  

	New: Param warning in HorizonScene's animation name DropDown list if param name not found.  

	Fix: Add WhitelistPlatform for IOS and HTML5.  

*4.19.0  

	FIX: HorizonScene's WidgetComponent bugs in VR Mode.  

*4.18.0  

	NEW: First Version including core features.  