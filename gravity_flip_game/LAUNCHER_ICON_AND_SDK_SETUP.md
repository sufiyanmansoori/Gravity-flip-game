Launcher icon and Android SDK setup

This project includes a vector-based placeholder launcher icon (adaptive XML + SVG) so the app has a consistent brand while you replace the artwork later.

Files added for the launcher icon:
- android/app/src/main/res/drawable/ic_launcher.xml (adaptive icon XML)
- android/app/src/main/res/drawable/ic_launcher_foreground.xml (vector drawable foreground)
- android/app/src/main/res/drawable/ic_launcher_background.xml (shape background with radial gradient)
- assets/icon.svg (SVG brand placeholder)

How this works:
- The Android adaptive icon XML is placed in drawable and the app manifest was updated to use @drawable/ic_launcher. Modern Android devices will use this adaptive icon; older devices will fall back to default behavior.
- The SVG is included as an asset for reference and for use by any build tooling or designers.

If you want to generate full PNG icons for every density (recommended for best compatibility and Play Store screenshots), use the flutter_launcher_icons package locally on your machine. Example steps:

1) Add to dev_dependencies in pubspec.yaml locally (optional):
   dev_dependencies:
     flutter_launcher_icons: ^0.10.0

   And add a config block:
   flutter_icons:
     android: true
     ios: true
     image_path: "assets/icon.png"  # provide a PNG to generate from

   Then run:
     flutter pub get
     flutter pub run flutter_launcher_icons:main

2) Alternatively, prepare PNGs (1024x1024) and place them under android/app/src/main/res/mipmap-*/ as appropriate.

Android SDK setup (Windows) — commands to run locally

1) Install Android Studio (recommended) or command-line SDK tools.
   - Android Studio: https://developer.android.com/studio

2) From Android Studio: open SDK Manager and install:
   - Android SDK Platform 33 (or latest stable)
   - Android SDK Platform-Tools
   - Android SDK Build-Tools

3) Set environment variables (PowerShell example):
   $env:ANDROID_SDK_ROOT = "C:\\Users\\<your-user>\\AppData\\Local\\Android\\Sdk"
   [Environment]::SetEnvironmentVariable('ANDROID_SDK_ROOT', 'C:\\Users\\<your-user>\\AppData\\Local\\Android\\Sdk', 'User')
   # Add platform-tools to PATH
   [Environment]::SetEnvironmentVariable('Path', $env:Path + ";C:\\Users\\<your-user>\\AppData\\Local\\Android\\Sdk\\platform-tools", 'User')

4) Accept licenses and check setup:
   flutter doctor --android-licenses
   flutter doctor

5) Build the APK once SDK is configured:
   cd C:\\Users\\mohds\\OneDrive\\Desktop\\DJANGO\\gravity_flip_game
   flutter pub get
   flutter build apk --debug

Notes:
- Replace <your-user> above with your Windows username or the actual SDK path.
- If you prefer not to install Android Studio, install the "Command line tools only" package and then use sdkmanager to install platforms and platform-tools.
- After SDK is set, running the build command should produce: build/app/outputs/flutter-apk/app-debug.apk

If you want, I can also:
- Generate PNG icons for every density here and place them in mipmap-*/ (requires an input PNG or programmatic image generation), or
- Add a flutter_launcher_icons config and run it here (if you provide or allow creating a PNG source), or
- Walk you through installing Android SDK step-by-step on your machine interactively.