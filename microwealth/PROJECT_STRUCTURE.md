# Flutter Project Structure Guide 📁

## Introduction

Flutter projects follow a well-defined folder structure that separates platform-specific code, application logic, assets, and configuration files. Understanding this structure is essential for building scalable, maintainable, and cross-platform mobile applications. This document explores the MicroWealth app's folder organization and explains the purpose of each core directory.

---

## 📂 Complete Folder Hierarchy

```
MicroWealth/
├── microwealth/
│   ├── lib/                    # Main application code (Dart)
│   │   ├── main.dart           # App entry point
│   │   ├── screens/            # UI screens
│   │   ├── widgets/            # Reusable widgets
│   │   ├── services/           # Backend services
│   │   ├── models/             # Data models
│   │   └── firebase_options.dart
│   │
│   ├── android/                # Android-specific configuration
│   │   ├── app/
│   │   │   ├── build.gradle.kts
│   │   │   ├── google-services.json
│   │   │   └── src/
│   │   └── build.gradle.kts
│   │
│   ├── ios/                    # iOS-specific configuration
│   │   ├── Runner/
│   │   │   ├── Info.plist
│   │   │   └── AppDelegate.swift
│   │   └── Runner.xcodeproj/
│   │
│   ├── web/                    # Web platform files
│   │   ├── index.html
│   │   └── manifest.json
│   │
│   ├── assets/                 # Static resources (manual)
│   │   ├── images/
│   │   ├── fonts/
│   │   └── icons/
│   │
│   ├── test/                   # Unit & widget tests
│   │   └── widget_test.dart
│   │
│   ├── pubspec.yaml            # Project configuration
│   ├── pubspec.lock            # Dependency lock file
│   ├── README.md               # Project documentation
│   ├── .gitignore              # Git exclusions
│   │
│   └── build/                  # Auto-generated build files
```

---

## 🗂️ Core Folders Explained

| Folder | Purpose | Key Files | Editable? |
|--------|---------|-----------|-----------|
| **lib/** | Contains all Dart application code | `main.dart` | ✅ Yes |
| **android/** | Android platform configuration | `build.gradle.kts`, `google-services.json` | ✅ Yes (carefully) |
| **ios/** | iOS platform configuration | `Info.plist`, `AppDelegate.swift` | ✅ Yes (carefully) |
| **web/** | Web platform files | `index.html`, `manifest.json` | ✅ Yes |
| **assets/** | Static resources (images, fonts, JSON) | User-created files | ✅ Yes |
| **test/** | Test files for quality assurance | `widget_test.dart` | ✅ Yes |
| **build/** | Compiled output files | Auto-generated | ❌ No |
| **.dart_tool/** | Dart SDK tools cache | Auto-generated | ❌ No |

---

## 📖 Detailed Folder Breakdown

### 1. **lib/** - Application Logic

The heart of your Flutter app containing all Dart code.

**Default Structure:**
```
lib/
├── main.dart              # Entry point - initializes Firebase and runs app
├── firebase_options.dart  # Firebase configuration (auto-generated)
│
├── screens/               # Full-page UI screens
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── responsive_home.dart
│   └── welcome_screen.dart
│
├── widgets/               # Reusable UI components
│   └── auth_wrapper.dart
│
├── services/              # Backend logic & API calls
│   ├── auth_service.dart      # Firebase Authentication
│   └── firestore_service.dart # Firestore Database
│
└── models/                # Data structures
    ├── user_model.dart
    └── transaction_model.dart
```

**Why this structure?**
- **Separation of concerns**: Screens, widgets, services, and models are isolated
- **Reusability**: Widgets and services can be used across multiple screens
- **Maintainability**: Easy to locate and modify specific functionality
- **Scalability**: New features can be added without disrupting existing code

---

### 2. **android/** - Android Platform Files

Contains all Android-specific configurations required to build and run the app on Android devices.

**Key Files:**
- **`android/app/build.gradle.kts`**
  - Defines app name, package ID, version number, and minimum SDK
  - Manages Android dependencies and build configurations
  
- **`android/app/google-services.json`**
  - Firebase configuration for Android
  - Downloaded from Firebase Console
  
- **`AndroidManifest.xml`** (in `android/app/src/main/`)
  - Declares app permissions (internet, camera, location)
  - Defines app name and launcher icon

**Purpose:** Ensures Flutter code compiles into a native Android application.

---

### 3. **ios/** - iOS Platform Files

Contains iOS-specific build configuration and metadata for iPhone/iPad deployment.

**Key Files:**
- **`ios/Runner/Info.plist`**
  - Manages app display name, bundle identifier, permissions
  - Declares privacy usage descriptions (camera, location, etc.)
  
- **`ios/Runner/AppDelegate.swift`**
  - Entry point for iOS app initialization
  - Handles iOS-specific app lifecycle events
  
- **`ios/Runner.xcodeproj/`**
  - Xcode project configuration
  - Used when building with Xcode

**Purpose:** Enables your Flutter app to run natively on Apple devices.

---

### 4. **assets/** - Static Resources

A **manually created** folder to store non-code resources like images, fonts, and JSON files.

**Example Structure:**
```
assets/
├── images/
│   ├── logo.png
│   └── background.jpg
├── fonts/
│   ├── Roboto-Regular.ttf
│   └── Roboto-Bold.ttf
└── data/
    └── countries.json
```

**Important:** Assets must be declared in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/
    - assets/fonts/
  fonts:
    - family: Roboto
      fonts:
        - asset: assets/fonts/Roboto-Regular.ttf
```

---

### 5. **test/** - Testing Scripts

Contains unit tests, widget tests, and integration tests to ensure code quality.

**Default File:**
- `widget_test.dart` - Tests the default counter app functionality

**Example Test:**
```dart
void main() {
  testWidgets('Login screen has email field', (WidgetTester tester) async {
    await tester.pumpWidget(LoginScreen());
    expect(find.byType(TextField), findsWidgets);
  });
}
```

**Benefits:**
- Catches bugs early in development
- Ensures UI widgets render correctly
- Validates business logic before deployment
- Supports test-driven development (TDD)

---

### 6. **pubspec.yaml** - Project Configuration

The **most critical file** in any Flutter project. It defines:

```yaml
name: microwealth
description: "A new Flutter project."
version: 1.0.0+1

environment:
  sdk: ^3.11.0

dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^3.9.0        # Firebase initialization
  firebase_auth: ^5.3.4        # Authentication
  cloud_firestore: ^5.5.2      # Database

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

**Key Sections:**
- **dependencies**: Production packages
- **dev_dependencies**: Development-only tools
- **flutter**: Asset declarations and Material Design settings

---

## 🛠️ Supporting Files

| File | Purpose |
|------|---------|
| **.gitignore** | Excludes build files, IDE configs, and sensitive data from Git |
| **README.md** | Project documentation and setup instructions |
| **pubspec.lock** | Locks exact dependency versions (auto-generated) |
| **analysis_options.yaml** | Dart linter rules for code quality |
| **build/** | Compiled APK/IPA files and build artifacts (ignored by Git) |

---

## 🎯 Benefits of This Structure

### 1. **Separation of Concerns**
Each folder has a single responsibility, making it easy to locate specific functionality.

### 2. **Cross-Platform Support**
Platform-specific code (Android/iOS/Web) is isolated, while `lib/` contains shared logic.

### 3. **Scalability**
As your app grows, you can add more folders (e.g., `lib/utils/`, `lib/constants/`) without breaking existing code.

### 4. **Team Collaboration**
Developers can work on different modules (screens, services, tests) in parallel without conflicts.

### 5. **Maintainability**
Clear organization reduces cognitive load when debugging or adding features.

### 6. **Best Practices**
Follows Flutter's recommended architecture, making it easier for new developers to onboard.

---

## 💭 Reflection

### How does this structure help build scalable apps?

The modular folder structure allows developers to:
- **Add new features independently** without modifying core files
- **Reuse components** across different parts of the app
- **Isolate bugs** to specific folders (e.g., authentication issues → `services/auth_service.dart`)
- **Scale teams** by assigning ownership of folders to different developers

### Why separate platform-specific code?

Platform folders (`android/`, `ios/`, `web/`) enable:
- **Custom native integrations** (Kotlin/Swift plugins)
- **Platform-specific permissions** (camera, location)
- **Build customizations** without affecting shared logic
- **True cross-platform development** from a single codebase

### Real-world example from MicroWealth:

In this project:
- **`lib/services/auth_service.dart`** handles Firebase Authentication logic
- **`lib/screens/login_screen.dart`** uses `AuthService` for UI interactions
- **`android/app/google-services.json`** enables Firebase on Android
- **`test/widget_test.dart`** validates that login screen renders correctly

If authentication logic needs updating, we only modify `auth_service.dart` — the UI and tests remain untouched. This is the power of organized architecture.

---

## 🚀 Next Steps

To improve your project structure:
1. Add a `lib/utils/` folder for helper functions
2. Create a `lib/constants/` folder for app-wide values (colors, strings)
3. Implement a state management folder (`lib/providers/` or `lib/blocs/`)
4. Add integration tests in `integration_test/`
5. Document your architecture in this file as it evolves

---

**Last Updated:** March 8, 2026  
**Project:** MicroWealth - Personal Finance Management App
