## 📋 Project Overview

Rick and Morty Explorer is a comprehensive demonstration app showcasing advanced Flutter development practices through the lens of the popular Rick and Morty universe. This project implements a **Clean Architecture** approach, strategically integrating multiple technologies to highlight modern development expertise and system design capabilities.

## 🏗️ Technical Architecture

### Clean Architecture Implementation

The application strictly follows Clean Architecture principles with clearly separated layers:

- **Presentation Layer**: UI components, BLoC state management
- **Domain Layer**: Use cases, repository interfaces, domain models
- **Data Layer**: Repository implementations, data sources, DTOs
- **Core/Utils**: Common utilities, extensions, and constants

This separation ensures that business logic remains independent of external frameworks, making the codebase highly maintainable and testable.

### State Management

The project deliberately implements multiple state management approaches to demonstrate versatility:

- **BLoC Pattern with flutter_bloc**: For reactive state management
- **BLoC Provider**: For efficient dependency injection of BLoC instances
- **GetIt**: For service location and dependency management

### Data Sources

Multiple data persistence strategies are implemented:

- **Remote**: Rick and Morty API integration
- **Local**:
  - **SharedPreferences**: For lightweight key-value storage
  - **SQLite (sqflite)**: For structured local database persistence

### Network Integration

The app demonstrates versatility in API integration through:

- **RESTful API** consumption using Dio
- **GraphQL** implementation for optimized data fetching
- **Connectivity handling** for graceful offline experiences

### Firebase Integration

Comprehensive Firebase services implementation:

- **Firebase Cloud Messaging**: For push notification capabilities
- **Firebase Analytics**: For user behavior tracking
- **Firebase Crashlytics**: For crash reporting and analysis

## 🚀 Key Features

- Character exploration with detailed information
- Episodes catalog with associated characters
- Infinite scroll pagination for efficient data loading
- Offline-first architecture with local caching
- Responsive design with Flutter ScreenUtil

## 💡 Technical Highlights

- **Error Handling**: Comprehensive error handling using Dartz Either type
- **Reactive Programming**: Stream-based reactivity throughout the application
- **Navigation**: Type-safe routing with AutoRoute
- **Caching Strategy**: Two-level caching with memory and persistent storage
- **Localization**: Internationalization support with flutter_localizations
- **Testing**: Extensive unit and integration tests using Mocktail framework

## 📦 Package Utilization

| Category | Packages |
|----------|----------|
| **Architecture** | dartz, get_it, flutter_bloc |
| **Networking** | dio, graphql, connectivity_plus |
| **UI Components** | flutter_svg, lottie, flutter_screenutil |
| **Local Storage** | shared_preferences, sqflite |
| **Firebase** | firebase_core, firebase_analytics, firebase_crashlytics, firebase_messaging |
| **Navigation** | auto_route |
| **Image Handling** | cached_network_image, flutter_cache_manager |
| **Code Generation** | freezed, build_runner, json_annotation |
| **Testing** | mocktail, flutter_test |

## 🧠 Development Approach

This application intentionally explores diverse implementation approaches to demonstrate flexibility and comprehensive understanding of mobile development concepts. While this creates additional complexity, it serves the primary goal of showcasing technical versatility and architectural knowledge.

The project prioritizes:

1. **Maintainability**: Through clear separation of concerns
2. **Testability**: With dependency injection and pure business logic
3. **Scalability**: Via modular architecture design
4. **Resilience**: Through comprehensive error handling and offline support

## 🧪 Testing Strategy

The project incorporates a comprehensive testing approach:

### Unit Testing
- Extensive unit tests for business logic components
- Mock-based testing using Mocktail for dependency isolation
- Tests for repositories, use cases, and BLoCs
- Coverage for error handling and edge cases

### Test Utilities
- Custom test helpers and fixtures
- Mock data generators


## 🛠️ Getting Started

```bash
# Clone the repository
git clone https://github.com/tosyak/template_app.git

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## ⚙️ Configuration

To run the project, you'll need to set up:

1. Firebase project configuration
2. Rick and Morty API access (public API, no authentication required)

---

<p align="center">
  <em>This project is designed as a technical showcase and is not affiliated with the official Rick and Morty franchise.</em>
</p>
