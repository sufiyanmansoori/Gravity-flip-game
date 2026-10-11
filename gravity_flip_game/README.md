# Gravity Flip Game

A production-oriented Flutter game project built for Android, iOS, web, and desktop platforms.

## Features

- Environment-aware app startup for development, staging, and production
- Game domain, data, and presentation structure
- Shared configuration and dependency injection
- Audio, notifications, theme, and app services
- Asset pipeline for localization, levels, and UI resources
- Test coverage for core game logic and persistence

## Project Structure

- lib/ - application code
- test/ - automated tests
- assets/ - game media, localization, and level data
- android/ - Android project
- ios/ - iOS project
- web/ - web app files
- linux/ - Linux desktop project
- macos/ - macOS desktop project
- windows/ - Windows desktop project

## Getting Started

### Prerequisites

- Flutter SDK 3.13+
- Android Studio / Xcode / VS Code with Flutter extension
- Git

### Install dependencies

```bash
flutter pub get
```

### Run locally

```bash
flutter run
```

### Run in specific environment

```bash
flutter run -t lib/main_dev.dart
flutter run -t lib/main_staging.dart
flutter run -t lib/main_prod.dart
```

### Run tests

```bash
flutter test
```

## Environment Configuration

Use the `app_config.yaml` and `.env.example` files as the base configuration reference for environment-specific app settings.

## Documentation

- [ARCHITECTURE.md](ARCHITECTURE.md)
- [CONTRIBUTING.md](CONTRIBUTING.md)

## License

This project is intended for internal or educational use unless otherwise specified.
