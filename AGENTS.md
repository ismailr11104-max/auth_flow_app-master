# AGENTS.md

- **App**: Flutter Supabase Authentication & Blog App (Clean Architecture + BLoC)
- **Primary Entrypoint**: `lib/main.dart`
- **Dependency Injection**: `lib/core/di/injection_container.dart` (using `get_it`)

## Essential Commands

- **Install Dependencies**: `flutter pub get`
- **Run App**: `flutter run`
- **Run Tests**: `flutter test`
- **Build APK (Android)**: `flutter build apk --release`
- **Clean Build**: `flutter clean`

## Architecture & Code Conventions

- **Clean Architecture**: Organized under `lib/features/auth/`, `lib/features/blog/`, and `lib/core/`
  - `domain/`: Pure business entities and repository interfaces.
  - `data/`: Data sources (Supabase API), models (JSON serialization), and repository implementations.
  - `presentation/`: UI screens and `flutter_bloc` state management (`SessionBloc`, `EmailAuthBloc`, `PostCrudBloc`, etc.).
- **Error Handling**: Uses `dartz` (`Either<Failure, T>`) for functional error handling and custom exceptions/failures in `lib/core/error/`.
- **State Management**: `flutter_bloc` with events and states.
- **Linting Rules**: Enforced via `analysis_options.yaml` (includes `prefer_single_quotes: true`, `prefer_const_constructors: true`, `avoid_print: true`).

## Environment & Configuration

- **Environment Variables**: `.env` file at root is required (loaded via `flutter_dotenv`).
  - Required keys: `SUPABASEURL` and `SUPABASEKEY` (Note exact keys used in `lib/main.dart`).
