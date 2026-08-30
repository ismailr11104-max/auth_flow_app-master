# Auth Flow App - Supabase Authentication Starter

Complete authentication system built with Flutter and Supabase, featuring email, social login, magic link, and phone authentication.

## Features

This starter project includes the complete structure for:

- ✅ Email & Password Authentication
- ✅ Social Login (Google, Apple, GitHub)
- ✅ Magic Link Authentication (Passwordless)
- ✅ Phone Authentication with OTP
- ✅ Session Management & Persistence
- ✅ Profile Management
- ✅ Clean Architecture with BLoC
- ✅ Error Handling with Either Pattern
- ✅ Dependency Injection with get_it

## Project Structure

```
lib/
├── core/
│   ├── di/
│   │   └── injection_container.dart    # Dependency injection setup
│   └── error/
│       ├── exceptions.dart              # Custom exceptions
│       └── failures.dart                # Failure classes for error handling
│
└── features/
    └── auth/
        ├── data/
        │   ├── datasources/
        │   │   └── auth_remote_datasource.dart   # Supabase API calls
        │   ├── models/
        │   │   └── user_model.dart               # User data model
        │   └── repositories/
        │       └── auth_repository_impl.dart     # Repository implementation
        │
        ├── domain/
        │   ├── entities/
        │   │   └── user_entity.dart              # User domain entity
        │   └── repositories/
        │       └── auth_repository.dart          # Repository interface
        │
        └── presentation/
            ├── bloc/
            │   ├── auth_bloc.dart                # Authentication BLoC
            │   ├── auth_event.dart               # Auth events
            │   └── auth_state.dart               # Auth states
            └── pages/
                ├── home_page.dart                # Home screen (authenticated)
                └── login_page.dart               # Login screen
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Supabase account ([Create one here](https://supabase.com))
- IDE (VS Code or Android Studio)

### Installation

1. **Clone the repository or use this starter code**

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up Supabase**
    - Go to [Supabase Dashboard](https://app.supabase.com)
    - Create a new project
    - Go to Settings → API
    - Copy your Project URL and anon/public key

4. **Configure environment variables**
   ```bash
   # Copy the example env file
   cp .env.example .env
   ```

   Then edit `.env` and add your Supabase credentials:
   ```env
   SUPABASE_URL=https://your-project-id.supabase.co
   SUPABASE_ANON_KEY=your_anon_key_here
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## Architecture Overview

This project follows **Clean Architecture** principles:

### Layers

1. **Domain Layer** (Business Logic)
    - Entities: Pure Dart classes representing core business objects
    - Repositories: Interfaces defining data operations

2. **Data Layer** (Data Sources)
    - Models: Data transfer objects with JSON serialization
    - Data Sources: API calls to Supabase
    - Repository Implementations: Concrete implementations of domain repositories

3. **Presentation Layer** (UI)
    - BLoC: State management using flutter_bloc
    - Pages/Widgets: UI components

### Key Patterns

- **Dependency Injection**: Using `get_it` for service location
- **Either Pattern**: Using `dartz` for functional error handling
- **BLoC Pattern**: For state management and separating business logic from UI

## What's Implemented vs What You'll Build

### ✅ Already Implemented (Starter Code)

- Complete project structure
- Error handling classes
- Dependency injection setup
- User entity and model
- Repository interfaces
- BLoC with all events and states
- Basic UI screens (Login, Home)
- Main app configuration

### 🔧 You Will Implement (During Lessons)

All methods in `AuthRemoteDataSourceImpl` are marked with `TODO` and throw `UnimplementedError`. You will implement:

- **Lesson 4.4**: Email Signup
- **Lesson 4.5**: Email Login
- **Lesson 4.6**: Email Verification
- **Lesson 4.7**: Password Reset
- **Lesson 4.8**: Google Sign-In
- **Lesson 4.9**: Apple Sign-In
- **Lesson 4.10**: GitHub Sign-In
- **Lesson 4.11**: Magic Link Authentication
- **Lesson 4.12-4.13**: Phone Authentication with OTP
- **Lesson 4.18-4.20**: Profile Management and Picture Upload

## Important Files

- **`lib/main.dart`**: App entry point and Supabase initialization
- **`lib/core/di/injection_container.dart`**: Dependency registration
- **`lib/features/auth/data/datasources/auth_remote_datasource.dart`**: Where you'll implement auth methods
- **`.env`**: Environment variables (create from `.env.example`)

## Common Commands

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run

# Run tests
flutter test

# Build for release (Android)
flutter build apk --release

# Build for release (iOS)
flutter build ios --release

# Clean build
flutter clean
```

## Troubleshooting

### "Failed to load .env file"
Make sure you created `.env` from `.env.example` and added your Supabase credentials.

### "Supabase not initialized"
Check that your `SUPABASE_URL` and `SUPABASE_ANON_KEY` are correct in `.env`.

### Import errors
Run `flutter pub get` to install all dependencies.

## Resources

- [Supabase Documentation](https://supabase.com/docs)
- [Supabase Flutter SDK](https://supabase.com/docs/reference/dart/introduction)
- [Flutter BLoC Documentation](https://bloclibrary.dev/)
- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

## Next Steps

1. Complete Lesson 4.1 to understand the project structure
2. Set up dependency injection in Lesson 4.2
3. Implement error handling strategy in Lesson 4.3
4. Start building features from Lesson 4.4 onwards

Happy coding!