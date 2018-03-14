VSTS Build Status: ![VSTS Build Status](https://hsgame.visualstudio.com/_apis/public/build/definitions/aeaa314b-7b56-4733-89fa-67e9bccfb809/7/badge)


Note: 

master branch may be unstable since it is in development, please switch to tags, for example: release/4.18.0


----------------------------------------------  
<h2 align="center">				
			HorizonFrameworkPlugin<br>
					4.19.0   <br>
			http://dorgon.horizon-studio.net  <br>
				dorgonman@hotmail.com  <br>
</h2>
----------------------------------------------  

 The goal of this plugin is to provide a general game framework that can manage WidgetBlueprints and related game logic with more organized way.

-----------------------  
System Requirements
-----------------------  
Tested UnrealEngine version: 4.18, 4.19


-----------------------
Installation Guide
-----------------------  

Put HorizonFrameworkPlugin into YOUR_PROJECT/Plugins folder, 
and then add module to your project 
YOUR_PROJECT.Build.cs:
PublicDependencyModuleNames.AddRange(new string[] { "HorizonFramework"});

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
Contact and Support
-----------------------  

email: dorgonman@hotmail.com


-----------------------
 Version History
-----------------------  

*4.19.0
- Refactor

*4.18.0
 - NEW: First Version including core features.