# Architecture Overview

## Introduction

This document provides an overview of the architecture of the Cashew budget tracking application. The application is built using the Flutter framework and utilizes a combination of local storage, Firebase services, and custom UI components.

## Core Technologies

-   **Language**: Dart
-   **Framework**: Flutter
-   **UI**: Flutter Material Design, custom widgets
-   **State Management**: `provider`, `shared_preferences`
-   **Database**: `drift` (local SQLite database), `cloud_firestore` (Firebase)
-   **Authentication**: `firebase_auth`, `google_sign_in`, `local_auth`
-   **Internationalization**: `easy_localization`
-   **Notifications**: `flutter_local_notifications`, `notification_listener_service`

## Application Structure

The application's code is organized within the `lib/` directory, with the following key subdirectories:

-   **`database/`**: Contains code related to database interactions, including schema definitions, data access objects (DAOs), and platform-specific implementations.
-   **`pages/`**: Contains the UI code for different screens/pages of the application. The `homePage/` subdirectory further organizes components specific to the home page.
-   **`struct/`**: Contains data structures, utility functions, and global constants used throughout the application.
-   **`widgets/`**: Contains reusable UI components used across multiple pages.
-   **`main.dart`**: The entry point of the application. It handles initialization of services (Firebase, localization, database, notifications) and sets up the root widget (`MaterialApp`).

## Navigation

The application uses a custom navigation system built with `PageNavigationFramework`, `NavigationSidebar`, and `InitialPageRouteNavigator`. This suggests a sidebar-based navigation structure, likely with nested routes for different sections of the app.

## State Management

The application appears to use a combination of state management approaches:

-   **`setState`**: Used within individual widgets and managed through global keys (`appStateKey`, `pageNavigationFrameworkKey`, etc.) for triggering rebuilds.
-   **`provider`**: Listed as a dependency, suggesting its use for providing data and services to widgets.
-   **`shared_preferences`**: Used for storing persistent application settings and user preferences.
-   **Custom Widgets**: `WatchSelectedWalletPk` and `WatchAllWallets` indicate a custom approach for managing wallet-related data in the application state.

## Data Flow

1.  **Initialization**: The app initializes Firebase, localization, the local database, notifications, and user settings.
2.  **User Authentication**: The app supports Firebase Authentication (including Google Sign-In) and local authentication (biometrics).
3.  **Data Loading**: The app loads currency and language data, and likely fetches user data from the local database and/or Firestore.
4.  **UI Rendering**: The `MaterialApp` sets up the theme and initial route. The `PageNavigationFramework` and `NavigationSidebar` manage navigation.
5.  **User Interaction**: Users interact with UI components, triggering state updates and database operations.
6.  **Data Persistence**: Changes are saved to the local database (using `drift`) and potentially synchronized with Firestore.
7.  **Notifications**: The app uses local notifications and potentially listens for external notifications.

## Component Hierarchy

(See the `component_hierarchy.md` file for a detailed breakdown of the UI component structure.) The main components are organized within the `HomePage` widget, which conditionally renders various sections based on user settings. The `EditHomePage` allows users to customize the layout and visibility of these sections.

## Dependencies

The `pubspec.yaml` file lists a wide range of dependencies, including those for UI components (`fl_chart`, `animations`, etc.), database interactions (`drift`, `sqlite3_flutter_libs`), Firebase services (`firebase_core`, `cloud_firestore`, etc.), and various utilities.

## Conclusion

The Cashew application is a complex Flutter application with a rich feature set. It utilizes a combination of local and cloud-based data storage, a custom navigation system, and a modular UI structure. The architecture demonstrates a well-organized approach to state management, data persistence, and user interaction.