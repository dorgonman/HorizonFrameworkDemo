# AGENTS.md — HorizonFrameworkDemo

Unreal Engine 5.7 plugin demo project. Build/test via `Build/Script/` local overrides and `Build/Base/Script/` shared scripts.

## Quick Start

From repo root (Git Bash on Windows):
```sh
./git_submodule_update.sh
./git_checkout_main.sh
```

## Build Commands

Run from Git Bash on Windows unless noted otherwise.

**Plugin (Shipping):**
```sh
./Build/Script/win64/plugin/shipping.sh
```

**Standalone (Development):**
```sh
./Build/Base/Script/win64/standalone/development.sh
```

## Test Commands

**Run full test suite:**
```sh
./Build/Script/win64/editor/test.sh
```

**Run single automation test:**
```sh
export EXTRA_PARAMETERS='-ExecCmds="Automation RunTests Plugin.HorizonFramework; Quit"'
AUTOMATION_TEST_FILTER='Plugin.HorizonFramework' ./Build/Script/win64/editor/test.sh
```

Available tests (from `Plugins/HorizonFrameworkPlugin/Source/HorizonFramework/Private/Test/`):
- `Plugin.HorizonFramework`

## Code Style & Conventions

### Naming (Unreal Standard)
- `U` prefix: UObject-derived classes
- `A` prefix: AActor-derived classes
- `S` prefix: Slate widgets
- `F` prefix: structs
- `E` prefix: enums
- `T` prefix: template types
- `b` prefix: bool variables (e.g., `bIsEnabled`)

### Includes & Headers
- Use `#pragma once` in all headers
- Include generated header **last**: `#include "<File>.generated.h"`
- In `.cpp`: include matching header first, then local module headers, then engine headers
- Prefer forward declarations in headers

### Types & Ownership
- Prefer Unreal types: `int32`, `uint8`, `float`, `FString`, `FName`, `FText`, `FVector2D`
- Use UE containers: `TArray`, `TMap`, `TOptional`
- For UObjects:
  - `TObjectPtr<T>` for owning UPROPERTY references (UE5)
  - `TWeakObjectPtr<T>` for weak references
  - `TSoftObjectPtr<T>` for soft asset references

### Error Handling & Logging
- Use UE assertion macros: `check`, `checkf` (fatal), `ensure`, `ensureMsgf` (non-fatal)
- Plugin logging category: `LogHorizonFramework`
- For editor warnings: `FMessageLog("HorizonFramework")`

### Threading & Constructor Safety
- Avoid constructor-time asset loading
- UWidget construction can happen off-game-thread in UE5
- Defer asset loads to safe runtime points (e.g., NativeConstruct, NativeOnInitialized)

### Formatting
- **Indentation:** 4 spaces (UTF-8, max line 120 chars)
- **YAML files:** 2 spaces
- See `.editorconfig` for baseline

## Module Structure

**HorizonFramework (Runtime)**
- Location: `Plugins/HorizonFrameworkPlugin/Source/HorizonFramework/`
- Public headers: `Public/`
- Private implementation: `Private/`

**Key Components:**
- `HorizonSceneSystem`: scene stack and scene lifecycle management
- `HorizonSceneManagerLibrary`: blueprint-accessible scene manager helpers
- `HorizonSceneManagerProxy`: async/proxy access for scene operations

## Automation Tests

Tests are guarded by `WITH_DEV_AUTOMATION_TESTS`. When adding tests:
1. Follow existing pattern in `Plugins/HorizonFrameworkPlugin/Source/HorizonFramework/Private/Test/*.cpp`
2. Use `FAutomationTestBase` or `FSimpleAutomationTestBase`
3. Register with Unreal automation macros/specs
4. Name format: `Plugin.Category.PluginName.TestName`

## CI/CD

- Azure Pipelines: `.azure-pipelines/`
- Uses EpicGames templates (`verify-plugin-build.yml@templates`)
- UAT invoked via `RunUAT.*` in `Build/Base/Script/common.sh`

## Important Notes

- Prefer `Build/Script/` overrides first, then `Build/Base/Script/` shared scripts
- Shared scripts contain MSYS/Git-Bash conditionals (`OSTYPE == msys`)
- On Windows, run scripts from **Git Bash**
- No dedicated lint command; use IDE tooling for formatting
- No Cursor/Copilot rules found (`.cursorrules`, `.github/copilot-instructions.md`)

## Useful Paths

- Plugin descriptor: `Plugins/HorizonFrameworkPlugin/HorizonFrameworkPlugin.uplugin`
- Tests: `Plugins/HorizonFrameworkPlugin/Source/HorizonFramework/Private/Test/`
- Build scripts: `Build/Script/` (overrides) and `Build/Base/Script/` (shared)
- CI config: `.azure-pipelines/`
