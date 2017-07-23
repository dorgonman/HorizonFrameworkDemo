// Created by dorgon, All Rights Reserved.
// email: dorgonman@hotmail.com
// blog: dorgon.horizon-studio.net

using UnrealBuildTool;
using System.Collections.Generic;

public class HorizonFrameworkDemoEditorTarget : TargetRules
{
	public HorizonFrameworkDemoEditorTarget(TargetInfo Target) : base(Target)
	{
		Type = TargetType.Editor;

		ExtraModuleNames.AddRange( new string[] { "HorizonFrameworkDemo" } );
	}
}
