# AGENTS.md - HorizonFrameworkDemo Development Guide

## Project Overview
HorizonFrameworkDemo is an Unreal Engine 5.7 demo project showcasing the HorizonFrameworkPlugin - a UI management framework for managing UMG widgets and game logic using stack-based scene operations (PushScene, PopScene, ChangeScene, ReplaceScene).

**Engine Version:** UE 5.7 (supports 4.18-5.3)  
**Modules:** HorizonFrameworkDemo (Runtime)  
**Platform:** Windows (primary), cross-platform support

---

## Build & Compilation

### Generate Project Files
```bash
# Windows - Generate Visual Studio solution
./GenerateProjectFiles.bat

# Or use Unreal Automation Tool
"C:\Program Files\Epic Games\UE_5.7\Engine\Build\BatchFiles\Build.bat" HorizonFrameworkDemo Win64 Development -Project="HorizonFrameworkDemo.uproject"
```

### Build Commands
```bash
# Full development build
"C:\Program Files\Epic Games\UE_5.7\Engine\Build\BatchFiles\Build.bat" HorizonFrameworkDemo Win64 Development

# Shipping build
"C:\Program Files\Epic Games\UE_5.7\Engine\Build\BatchFiles\Build.bat" HorizonFrameworkDemo Win64 Shipping

# Editor build
"C:\Program Files\Epic Games\UE_5.7\Engine\Build\BatchFiles\Build.bat" HorizonFrameworkDemoEditor Win64 Development
```

### Open in Editor
```bash
# Double-click the .uproject file or use command line
"C:\Program Files\Epic Games\UE_5.7\Engine\Binaries\Win64\UE4Editor.exe" "HorizonFrameworkDemo.uproject"
```

---

## Code Style Guidelines

### C++ Naming Conventions
- **Classes:** `AClassName` (Actors), `UClassName` (Objects), `FStructName` (Structs), `IInterfaceName` (Interfaces)
- **Functions:** `PascalCase` for public/protected, `PascalCase` for private
- **Variables:** `PascalCase` with type prefix (e.g., `bIsActive`, `pSceneManager`, `SceneStack`)
- **Constants:** `CONSTANT_NAME` or `PascalCase` with `const` keyword
- **Enums:** `EEnumName` with `E` prefix

### File Organization
- Header files: `.h` extension with `#pragma once` guard
- Implementation: `.cpp` extension with `#include "FileName.h"` first
- Generated files: `.generated.h` suffix for Unreal reflection system
- Module structure: `Source/ModuleName/Public/` and `Source/ModuleName/Private/`

### Formatting Standards
- **Indentation:** 4 spaces (configured in `.editorconfig`)
- **Line Length:** Max 120 characters
- **Charset:** UTF-8
- **Trailing Whitespace:** Preserve (not trimmed)
- **Braces:** Allman style (opening brace on new line for classes/functions)

### Header File Template
```cpp
// Created by [Author], All Rights Reserved.
// email: [email]
// blog: [website]

#pragma once

#include "CoreMinimal.h"
#include "GameFramework/GameModeBase.h"
#include "ClassName.generated.h"

UCLASS()
class HORIZONFRAMEWORKDEMO_API AClassName : public AGameModeBase
{
    GENERATED_BODY()
};
```

### Includes & Dependencies
- Always include `CoreMinimal.h` first in headers
- Use `#pragma once` instead of include guards
- Include generated files last: `#include "ClassName.generated.h"`
- Organize includes: Engine → Plugin → Local
- Use `HORIZONFRAMEWORKDEMO_API` macro for public symbols

### Module Dependencies
**Public Dependencies:**
- Core, CoreUObject, Engine, InputCore

**Private Dependencies:**
- HorizonFramework (the plugin being demoed)

### Unreal Reflection Macros
- `UCLASS()` - Mark classes for reflection
- `UPROPERTY()` - Expose properties to editor/blueprint
- `UFUNCTION()` - Expose functions to blueprint
- `GENERATED_BODY()` - Required in class body
- `GENERATED_UCLASS_BODY()` - Legacy (avoid)

### Error Handling
- Use `ensureMsgf()` for non-fatal assertions with messages
- Use `check()` for critical failures
- Use `UE_LOG()` for debug output
- Prefer early returns over deep nesting

### Type Safety
- Use `TObjectPtr<>` for object pointers (UE 5.4+)
- Use `TSubclassOf<>` for class references
- Use `TWeakObjectPtr<>` for weak references
- Avoid raw pointers in new code

---

## Project Structure

```
HorizonFrameworkDemo/
├── Source/
│   ├── HorizonFrameworkDemo/          # Main game module
│   │   ├── HorizonFrameworkDemo.Build.cs
│   │   ├── HorizonFrameworkDemo.h/cpp
│   │   └── HorizonFrameworkDemoGameModeBase.h/cpp
│   ├── HorizonFrameworkDemo.Target.cs
│   └── HorizonFrameworkDemoEditor.Target.cs
├── Content/                           # Game assets, blueprints, levels
├── Plugins/                           # HorizonFrameworkPlugin (marketplace)
├── Config/                            # Project configuration
├── Binaries/                          # Compiled binaries
├── Intermediate/                      # Build artifacts
├── HorizonFrameworkDemo.uproject      # Project descriptor
└── HorizonFrameworkDemo.sln           # Visual Studio solution
```

---

## Git Workflow

### Commit Message Format
Follow conventional commits pattern observed in history:
```
[Category] Brief description

Optional detailed explanation
```

**Categories:**
- `[New]` - New feature
- `[BugFix]` - Bug fix
- `[Refactor]` - Code refactoring
- `[Optimization]` - Performance improvement
- `[EngineUpgrade]` - Engine version update
- `[Plugin]` - Plugin-related changes

### Branch Strategy
- `main` - Stable releases (may be unstable during development)
- Feature branches for new work
- Use tags for releases: `editor/5.7.0`, `editor/5.6.0`, etc.

---

## Testing & Validation

### Compile Checks
- Verify no compilation errors in Visual Studio
- Check for warnings (treat as errors in strict mode)
- Use `Analyze` → `Run Code Analysis` in Visual Studio

### Editor Validation
- Open project in UE Editor
- Verify all blueprints compile
- Check Content Browser for missing references
- Test scene transitions (PushScene, PopScene, ChangeScene)

### Platform Support
- Primary: Windows 64-bit
- Tested: Windows
- Supported: All platforms (via plugin)

---

## Common Tasks

### Adding New Scene
1. Create C++ class inheriting from `AHorizonSceneBase`
2. Create Widget Blueprint for UI
3. Assign widget to scene's `WidgetClass` property
4. Use `UHorizonSceneManagerLibrary::GetDefaultSceneManager()` to manage scenes

### Modifying Module Dependencies
Edit `HorizonFrameworkDemo.Build.cs`:
```csharp
PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore" });
PrivateDependencyModuleNames.AddRange(new string[] { "HorizonFramework" });
```

### Debugging
- Use `UE_LOG()` with appropriate verbosity levels
- Attach Visual Studio debugger to running editor
- Use `Output Log` window in editor
- Enable `bUseDebugSymbols` in build configuration

---

## Performance Considerations

- Use `TObjectPtr` for automatic null checking
- Cache scene manager references when possible
- Avoid creating scenes in tight loops
- Profile with `stat unit` console command
- Monitor memory with `stat memory`

---

## References

- **Plugin Documentation:** See README.md
- **Marketplace:** https://www.unrealengine.com/marketplace/horizonframework-plugin
- **Demo Video:** https://youtu.be/TQ3oFkdn2Pg
- **Contact:** dorgonman@hotmail.com
- **Blog:** http://dorgon.horizon-studio.net

---

## Version History

Current: **5.7.0** (UE 5.7 compatible)

See README.md for detailed version history and changelog.
