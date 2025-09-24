# NFL Survival Pool (Flutter MVP)

MVP app for an NFL Survival Pool with freemium vs premium, mock data, and swappable repositories.

## Stack
- Flutter 3.x, Dart 3.x
- Routing: go_router
- State: Riverpod (hooks_riverpod)
- HTTP: Dio + retrofit (stubs)
- Models: freezed + json_serializable
- Storage: Hive
- Env: flutter_dotenv
- Theming: Material 3
- Dates/times: intl (UTC store, local render)

## Getting Started
```bash
flutter pub get
dart run build_runner build -d
flutter run -d macos  # or choose iOS/Android once toolchains are installed
```

If iOS/Android toolchains are missing, you can develop on macOS/web first.

## Features
- Sign in anonymously
- Create/join leagues (mock). Freemium limited to 1 league.
- Make a weekly pick. Deadline locks 5 minutes before first kickoff.
- News feed with premium-gated live score widget (mock)
- Paywall and subscription mock; Ads placeholders for freemium

## Project Structure
See `lib/` feature-first layout and `lib/data/*` repositories. Models in `lib/data/models`.

## CI
GitHub Actions runs format, analyze, and tests.

## Notes
- No NFL trademarks/logos included.
- Replace mocks with real backends later (Firebase Auth, RevenueCat, AdMob, etc.).

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
