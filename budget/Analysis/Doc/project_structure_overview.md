# Cashew App Project Structure Overview

## Introduction

This document provides a comprehensive overview of the Cashew app's project structure, component hierarchy, and code organization. It serves as a visual guide to understanding the architecture and relationships between different parts of the application.

## Project Directory Structure

```
budget/
├── .firebaserc                 # Firebase project configuration
├── .gitignore                  # Git ignore rules
├── .metadata                   # Flutter project metadata
├── .vscode/                    # VS Code configuration
├── Analysis/                   # Project analysis documentation
├── README.md                   # Project documentation
├── analysis_options.yaml       # Dart analyzer configuration
├── android/                    # Android platform code
├── assets/                     # Static assets (images, fonts, etc.)
│   ├── categories/             # Category-related assets
│   ├── fonts/                  # Custom fonts
│   ├── icon/                   # App icons
│   ├── icons/                  # UI icons
│   ├── images/                 # Image assets
│   ├── landing/                # Landing page assets
│   ├── static/                 # Static content
│   └── translations/           # Localization files
├── bin/                        # Utility scripts
├── component_hierarchy.md      # UI component hierarchy documentation
├── drift_schemas/              # Database schema evolution files
├── firebase.json               # Firebase configuration
├── ios/                        # iOS platform code
├── lib/                        # Main application code
│   ├── colors.dart             # Color definitions and theming
│   ├── database/               # Database models and queries
│   ├── firebase_options.dart   # Firebase configuration
│   ├── functions.dart          # Utility functions
│   ├── main.dart               # Application entry point
│   ├── modified/               # Modified third-party libraries
│   ├── pages/                  # UI screens and pages
│   ├── struct/                 # Core business logic and data structures
│   └── widgets/                # Reusable UI components
├── macos/                      # macOS platform code
├── packages/                   # Custom and modified packages
├── pubspec.yaml                # Dependencies and configuration
├── test/                       # Application tests
└── web/                        # Web platform files
```

## Core Application Structure

### Entry Point

The application starts in `lib/main.dart`, which initializes:
- Firebase integration
- Localization system
- Database connection
- Notification system
- Settings and preferences
- Time zone configuration

### Code Organization

The codebase follows a modular structure with clear separation of concerns:

1. **Pages (`lib/pages/`)**: Contains all application screens and pages, organized by feature.
   - `homePage/`: Home screen components
   - Individual feature pages (budgets, transactions, wallets, etc.)

2. **Widgets (`lib/widgets/`)**: Reusable UI components used across the application.
   - `framework/`: Page frameworks and navigation components
   - UI elements (buttons, charts, selectors, etc.)

3. **Business Logic (`lib/struct/`)**: Core business logic and data structures.
   - Settings management
   - Currency functions
   - Authentication
   - Synchronization

4. **Database (`lib/database/`)**: Database models, tables, and queries.
   - Table definitions
   - Data access objects (DAOs)
   - Schema migrations

## Component Hierarchy

The UI follows a hierarchical structure with the HomePage as the main entry point:

```
HomePage
├── HomePageWalletSwitcher
├── HomePageWalletList
├── HomePageBudgets
├── HomePageUpcomingTransactions
├── HomePageAllSpendingSummary
├── HomePageNetWorth
├── HomePageObjectives (goals)
├── HomePageCreditDebts
├── HomePageObjectives (loans)
├── HomePageLineGraph
├── HomePagePieChart
├── HomePageHeatMap
├── HomeTransactions
├── HomePageUsername
├── HomePageRatingBox
└── EditHomePage
```

Each component has its own child components and settings dialogs, creating a modular and maintainable UI structure.

## Database Structure

The application uses Drift (formerly Moor) as its database ORM with the following key entities:

- **Transactions**: Financial transactions with categories and metadata
- **Wallets**: Financial accounts for tracking balances
- **Budgets**: Budget definitions with limits and filters
- **Categories**: Transaction categories with icons and colors
- **Objectives**: Financial goals and loans

The database schema evolves over time, with migration files stored in the `drift_schemas/` directory.

## Key Features

1. **Budget Management**: Create and track budgets with customizable periods and categories
2. **Transaction Tracking**: Record and categorize financial transactions
3. **Wallet Management**: Manage multiple accounts and track balances
4. **Financial Goals**: Set and track progress towards financial objectives
5. **Data Visualization**: View financial data through various charts and graphs
6. **Localization**: Support for multiple languages

## Platform Integration

The application is built with Flutter for cross-platform compatibility:

- **Android**: Platform-specific code in `android/`
- **iOS**: Platform-specific code in `ios/`
- **Web**: Web platform files in `web/`
- **macOS**: macOS platform code in `macos/`

## Conclusion

The Cashew app follows a well-organized Flutter project structure with clear separation of concerns. The modular architecture facilitates maintenance, feature development, and collaboration among developers. The component hierarchy demonstrates a thoughtful UI design that promotes reusability and maintainability.