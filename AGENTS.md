# Repository Guidelines

## Project Structure & Module Organization

`UURecoveryApp/` contains source, storyboards, privacy metadata, and image assets. Organize features in `UURecoveryApp/Page/<Feature>` (for example, `Login`, `Service`, `Mine`, and `Web`). Put reusable foundations in `UURecoveryApp/Base`, helpers/constants in `UURecoveryApp/Tools`, and shared state in `Page/Model`. The project and shared scheme are in `UURecoveryApp.xcodeproj`; use `UURecoveryApp.xcworkspace` with CocoaPods. `Pods/` and local components (`ZCycleView`, `CXSwiftCommonModule`, and `keychain-swift`) are dependencies or vendored code; change them only for intentional dependency updates.

## Build, Test, and Development Commands

Install or refresh dependencies after changing `Podfile`:

```sh
pod install
```

Build the app from the workspace (requires Xcode and an available simulator runtime):

```sh
xcodebuild -workspace UURecoveryApp.xcworkspace -scheme UURecoveryApp -configuration Debug -sdk iphonesimulator build
```

Open `UURecoveryApp.xcworkspace` in Xcode for development, signing, running, and archiving. There is no app-owned XCTest target or automated lint/format command; use a build plus manual smoke testing for affected flows.

## Coding Style & Naming Conventions

Follow existing Swift conventions: four-space indentation, `UpperCamelCase` types, `lowerCamelCase` properties/methods, and descriptive `*ViewController`, `*View`, `*Model`, and `*Cell` suffixes. Keep feature code with its feature, use `MARK: -` sections for major extensions, and prefer existing RxSwift, SnapKit/FlexLayout, and base abstractions. Match nearby Chinese comments. No SwiftLint or formatter is configured; keep diffs focused and compile after structural changes.

## Testing Guidelines

There are no repository-owned unit or UI tests and no coverage threshold. For each change, build the `UURecoveryApp` scheme and manually verify the modified screen, navigation, networking/error state, and payment or WebView behavior when applicable. If adding tests, create an Xcode test target and use names such as `LoginViewModelTests.swift` with methods describing the expected behavior.

## Commit & Pull Request Guidelines

Existing commits use short, imperative-ish subjects, often prefixed with `feat:` or `ci:` (for example, `feat-release1.4` and `ci: add ios cloud build`). Keep commits small and explain the user-visible or build/configuration change. Pull requests should include a concise summary, testing performed, linked issue or release context when available, and screenshots or a short recording for UI changes. Call out Podfile, signing, export, or API-environment changes explicitly.

## Security & Configuration Tips

Do not commit credentials, signing secrets, payment keys, or private API endpoints. Review `Info.plist`, `exportOptions.plist`, and build settings carefully before changing release configuration; verify the target and bundle identifier before archiving.
