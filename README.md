[Marketplace](https://www.unrealengine.com/marketplace/horizonframework-plugin) 


[![Build Status](https://dev.azure.com/hsgame/UEHorizonPlugin/_apis/build/status/HorizonFramework/HorizonFrameworkDemo-Shipping-CI?repoName=HorizonFrameworkDemo&branchName=main)](https://dev.azure.com/hsgame/UEHorizonPlugin/_build/latest?definitionId=28&repoName=HorizonFrameworkDemo&branchName=main)

public feed: nuget.org  

[![nuget.org package in feed in ](https://img.shields.io/nuget/v/HorizonFrameworkDemo.svg)](https://www.nuget.org/packages/HorizonFrameworkDemo/)


Note: 

main branch may be unstable since it is in development, please switch to tags, for example: editor/4.25.0



----------------------------------------------  
How to Run Demo Project before purchase:(Only for Win64 editor build, no source code)
1. Double click install_game_package_from_nuget_org.cmd, and check if UE4Editor-*.dll are installed to Binaries\Win64 and Plugins\HorizonFrameworkPlugin\Binaries\Win64\
2. Double click HorizonFrameworkDemo.uproject  
----------------------------------------------

 

----------------------------------------------  
<h2 align="center">				
			HorizonFrameworkPlugin<br>
					5.5.0   <br>
			http://dorgon.horizon-studio.net  <br>
				dorgonman@hotmail.com  <br>
</h2>
----------------------------------------------  

 The goal of this plugin is to provide a general game framework that can manage WidgetBlueprints and related game logic with more organized way.

-----------------------  
System Requirements
-----------------------  
Supported UnrealEngine version: 4.18-5.3


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
3. Assign Widget Blueprint to HorizonScene's WidgetClass
4. Use functions in AHorizonSceneManager, UHorizonSceneManagerLibrary or UHorizonSceneManagerProxy to push, pop or change to your UI Scene.

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

This plugin is a UI Management Framework that focus on manage your UMG and relate game logic with stack operation, ex: PushScene, PopScene, ChangeScene and ReplaceScene.  


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


*5.4.1

* [New] Implement Push/Change Scene by SoftClass

* [New] Implement Push/Change Scene using UserWidget Only, without Create Scene BP Asset

* [Optimization] include UE_INLINE_GENERATED_CPP_BY_NAME to all .cpp for increase compile time


*5.4.0

* [Refactor] Use TObjectPtr instead of RawPointer


*5.3.0

	Update to 5.3.0
	
*5.2.0   

Source\HorizonFramework

* [Refactor] Fix 5.2 warning


*5.1.0   

Source\HorizonFramework

* [Refactor] Fix 5.1 warning

*5.0.0   

Source\HorizonFramework

* [Refactor] Fix 5.0 warning

* [New] Add Test.spec and ProxyArchive

* [BugFix] Fix UE5 GetLoadedPath warning

* AB#2479 [BugFix] Widget sometimes not removed from viewport when seamless travel to next map

* AB#2401 [BugFix] Fix UE5 'IsPendingKill' deprecated message

* AB#2477 [BugFix][HorizonSceneBase] IsTransInFinished and IsTransOutFinished not work as expected


Source\HorizonFrameworkEditor

* [BugFix] Unregister custom class layout when ShutdownModule



*4.27.0   

Source\HorizonFramework

* AB#1867 [New][HorizonSceneBase] Implement ReceiveTransInFinished and ReceiveTransOutFinished

* AB#1854 [SceneManager] Callback OnAddScene only if Scene exists

* AB#1854 [New][HorizonSceneManager] Implement OnAddScene callback

* AB#2091 [BugFix][HorizonGameInstance] Should not auto save if game didn't use it.

* [HorizonSceneBase] Add comment to TransOutAnimationName

* AB#2041 [New][HorizonSceneBase] PlayAnimationReverse when StartTransOut if TransInAnimationName equal to TransOutAnimationName

* AB#2015 [BugFix][SceneManager] SceneEvent can't finished if Scene are cached and still running

* AB#1929 [NEW][SceneManager] Implement SceneCache so cached SceneClass will only spawn single instance and will not create multiple time so improve performance

* AB#1930 [BugFix] RemoveSceneByWidget should not remove TopScene and should remove Delegate after callback finished

* Fix tutorial Scene

* AB#1917 [BugFix][HorizonSceneBase] IsTransInFinished and IsTransOutFinished should check correct Animation name

* AB#1921 [HorizonSceneEvent] Unused Scene callbacks should not appear in BP

* AB#1887 [New][UHorizonSceneEvent] InitWidget when try to GetTransInSceneWidget


Source\HorizonFrameworkEditor

* AB#1867 [New][HorizonSceneBase] Implement ReceiveTransInFinished and ReceiveTransOutFinished


*4.26.0   

* [BugFix][HorizonSceneManager] OnRemoveScene should call OnPopScene if it is TopScene

* [BugFix][HorizonSceneManager] RemoveScene and GetSceneByWidget should check SceneStack and SceneEventList

* [BugFix][HorizonSceneManager] RemoveScene should find target scene from SceneStack

* [BugFix][HorizonSceneManager] HasScene logic

* [Refactor][HorizonSceneBase] Set StatusEnum to EHorizonSceneBaseStatusEnum::Init when init

* [New][HorizonScene] Implement DestroyWidget and set InitWidget to public

* [Refactor][HorizonSceneManager] Deprecate IsEmpty, use HasScene instead

* [BugFix][HorizonSceneManager] IsSceneEventRunning should check current event status and refactor IsEmpty

* [New][UHorizonSceneManagerLibrary] GetSceneManagerWithName will SetActorLabel in editor

* [New][HorizonFrameworkFunctionLibrary] Implement SetComponentRotationToPlayer for BP simulation

* [Refactor][HorizonScene] Set Default WidgetComponent DrawSize to 1920x1080

* [HorizonSceneManager][Refactor] Change PlayerIndex to ControllerID

* [Refactor] using copy for GetSceneManagerWithName

* [Refactor] Always spawn DefaultSceneManagerWeakPtr is not exist

* AB#1780 [BugFix] Move all AHorizonSceneManager to HorizonSceneSystem



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