<#
PowerShell helper script: setup_and_build.ps1
Purpose: Install Android command-line tools (if missing), install required SDK packages,
accept licenses (interactive), configure Flutter SDK path, fetch pub packages and build debug APK.

Usage (run in PowerShell as the same user):
  Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
  .\scripts\setup_and_build.ps1

This script is interactive at the license acceptance step. If you prefer, run the commands manually
as described in the project README / LAUNCHER_ICON_AND_SDK_SETUP.md.
#>

# ----- Configuration -----
$SdkRoot = "$env:LOCALAPPDATA\Android\Sdk"
$FlutterProject = (Resolve-Path "..").ProviderPath # assumes running from project root; adjust if needed

Write-Host "Using SDK root: $SdkRoot"
Write-Host "Project root (assumed): $FlutterProject"

# Ensure SDK directories
if (-not (Test-Path $SdkRoot)) {
    Write-Host "Creating SDK root: $SdkRoot"
    New-Item -ItemType Directory -Force -Path $SdkRoot | Out-Null
}

# Helper to locate sdkmanager
function Get-SdkManagerPath {
    param($sdkRoot)
    $candidates = @(
        Join-Path $sdkRoot 'cmdline-tools\latest\bin\sdkmanager.bat',
        Join-Path $sdkRoot 'cmdline-tools\bin\sdkmanager.bat',
        Join-Path $sdkRoot 'tools\bin\sdkmanager.bat'
    )
    foreach ($c in $candidates) {
        if (Test-Path $c) { return $c }
    }
    return $null
}

$sdkmanager = Get-SdkManagerPath -sdkRoot $SdkRoot
if (-not $sdkmanager) {
    Write-Host "Android command-line tools not found. Downloading them now (≈150MB)." -ForegroundColor Yellow
    $zipUrl = 'https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip'
    $zipPath = Join-Path $env:TEMP 'android-cmdline-tools.zip'
    Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath -UseBasicParsing
    $extractDir = Join-Path $SdkRoot 'cmdline-tools-temp'
    if (Test-Path $extractDir) { Remove-Item -Recurse -Force $extractDir }
    Expand-Archive -Path $zipPath -DestinationPath $extractDir -Force
    # copy contents 'cmdline-tools' into cmdline-tools\latest
    $src = Join-Path $extractDir 'cmdline-tools'
    $dest = Join-Path $SdkRoot 'cmdline-tools\latest'
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    Get-ChildItem -Path $src -Force | ForEach-Object { Copy-Item -Path $_.FullName -Destination $dest -Recurse -Force }
    Remove-Item -Recurse -Force $extractDir
    Remove-Item -Force $zipPath
    $sdkmanager = Get-SdkManagerPath -sdkRoot $SdkRoot
    if (-not $sdkmanager) { Write-Error "Failed to install command-line tools. Please install via Android Studio SDK Manager."; exit 1 }
}

Write-Host "sdkmanager path: $sdkmanager"

# Install packages
$packages = @('platform-tools','platforms;android-35','build-tools;35.0.0','cmdline-tools;latest')
Write-Host "Installing SDK packages: $($packages -join ', ')"
& $sdkmanager --sdk_root="$SdkRoot" $packages

# Accept licenses interactively
Write-Host "Now accepting SDK licenses interactively. Type 'y' at each prompt."
& $sdkmanager --sdk_root="$SdkRoot" --licenses

# Configure flutter to use the SDK
Write-Host "Configuring Flutter to use SDK root: $SdkRoot"
flutter config --android-sdk "$SdkRoot"

# Build the app
Write-Host "Fetching pub packages..."
Set-Location -Path $FlutterProject
flutter pub get

Write-Host "Building debug APK (this may take a few minutes)..."
flutter build apk --debug

Write-Host "If the build succeeded, APK will be at: $FlutterProject\build\app\outputs\flutter-apk\app-debug.apk" -ForegroundColor Green
