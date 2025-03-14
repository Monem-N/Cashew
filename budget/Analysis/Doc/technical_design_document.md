# Cashew App Technical Design Document

## 1. Introduction

### 1.1 Purpose
This Technical Design Document (TDD) provides a comprehensive overview of the Cashew app's architecture, data models, implementation details, and technical specifications. It serves as a reference for developers working on the application and documents the technical decisions made during development.

### 1.2 Scope
This document covers the entire Cashew application, including its mobile (iOS and Android), web, and desktop implementations. It details the application's architecture, database schema, UI components, business logic, and integration with external services.

### 1.3 System Overview
Cashew is a comprehensive personal finance management application built with Flutter. It enables users to track expenses, manage budgets, set financial goals, analyze spending patterns, and synchronize data across multiple devices. The application uses a combination of local storage (SQLite via Drift) and cloud services (Firebase) to provide a seamless user experience with offline capabilities.

## 2. Architecture Overview

### 2.1 High-Level Architecture

The Cashew app follows a layered architecture with clear separation of concerns:

```
+-------------------+
|    Presentation   | <- UI Components, Pages, Widgets
+-------------------+
|   Business Logic  | <- Data Processing, Validation, State Management
+-------------------+
|    Data Access    | <- Database Operations, Cloud Synchronization
+-------------------+
|     Foundation    | <- Core Utilities, Configuration, Constants
+-------------------+
```

### 2.2 Key Technologies

- **Framework**: Flutter (Dart)
- **UI**: Flutter Material Design, custom widgets
- **State Management**: Provider, shared_preferences
- **Local Database**: Drift (SQLite)
- **Cloud Storage**: Firebase Firestore
- **Authentication**: Firebase Authentication, Google Sign-In, Local Authentication
- **Internationalization**: easy_localization
- **Charts and Visualizations**: fl_chart
- **Notifications**: flutter_local_notifications, notification_listener_service

### 2.3 Directory Structure

```
lib/
├── colors.dart             # Color definitions and theming
├── database/              # Database models and queries
├── firebase_options.dart   # Firebase configuration
├── functions.dart          # Utility functions
├── main.dart               # Application entry point
├── modified/               # Modified third-party libraries
├── pages/                  # UI screens and pages
├── struct/                 # Core business logic and data structures
└── widgets/                # Reusable UI components
```

## 3. Data Model

### 3.1 Core Entities

#### 3.1.1 Wallets
Represents financial accounts or wallets.

**Key Fields:**
- `walletPk`: Primary key (UUID)
- `name`: Wallet name
- `colour`: Optional color for UI display
- `iconName`: Optional icon identifier
- `currency`: Currency code
- `currencyFormat`: Currency formatting pattern
- `decimals`: Number of decimal places (default: 2)
- `order`: Display order in the UI
- `homePageWidgetDisplay`: List of widgets to display on the home page

#### 3.1.2 Categories
Stores transaction categories and subcategories.

**Key Fields:**
- `categoryPk`: Primary key (UUID)
- `name`: Category name
- `colour`: Optional color for UI display
- `iconName`: Optional icon identifier
- `emojiIconName`: Optional emoji icon
- `income`: Boolean flag indicating if this is an income category
- `order`: Display order in the UI
- `mainCategoryPk`: Reference to parent category (for subcategories)

#### 3.1.3 Transactions
Stores financial transactions.

**Key Fields:**
- `transactionPk`: Primary key (UUID)
- `name`: Transaction name/description
- `amount`: Transaction amount
- `note`: Additional notes
- `categoryFk`: Foreign key to category
- `subCategoryFk`: Optional foreign key to subcategory
- `walletFk`: Foreign key to wallet
- `income`: Boolean flag for income vs expense
- `paid`: Payment status
- `type`: Special transaction type (upcoming, subscription, repetitive, credit, debt)
- `objectiveFk`: Optional link to financial objective

#### 3.1.4 Budgets
Stores budget definitions and constraints.

**Key Fields:**
- `budgetPk`: Primary key (UUID)
- `name`: Budget name
- `amount`: Budget limit amount
- `startDate` and `endDate`: Budget period
- `walletFks`: List of associated wallets
- `categoryFks`: List of included categories
- `categoryFksExclude`: List of excluded categories
- `income`: Boolean flag for income vs expense budget
- `reoccurrence`: Budget recurrence pattern (daily, weekly, monthly, yearly, custom)
- `periodLength`: Length of budget period

#### 3.1.5 Objectives
Stores financial goals and loans.

**Key Fields:**
- `objectivePk`: Primary key (UUID)
- `name`: Objective name
- `targetAmount`: Target amount to save or pay
- `currentAmount`: Current progress amount
- `type`: Objective type (goal, loan)
- `startDate` and `endDate`: Objective period

### 3.2 Entity Relationships

```
+------------+     +---------------+     +------------+
|   Wallet   |<----| Transaction   |---->|  Category  |
+------------+     +---------------+     +------------+
                          |                    ^
                          |                    |
                          v                    |
+------------+     +---------------+     +------------+
|   Budget   |<----| CategoryBudget|     |SubCategory |
+------------+     |    Limit      |     +------------+
                   +---------------+
                   
+------------+
| Objective  |<----+
+------------+     |
                   |
+---------------+  |
| Transaction   |--+
+---------------+
```

## 4. Database Design

### 4.1 Local Database

The application uses Drift (formerly Moor) as an ORM for SQLite. The database schema is defined in `lib/database/tables.dart` and has evolved through multiple versions (currently at v46).

#### 4.1.1 Schema Evolution
The database schema evolution is managed through versioned migration files stored in the `drift_schemas/` directory. Each version is documented with the changes made to the schema.

#### 4.1.2 Data Access Objects (DAOs)
Data access is managed through DAOs that provide type-safe database operations. These are generated by Drift based on the table definitions.

### 4.2 Cloud Database

Firebase Firestore is used for cloud storage and synchronization. The Firestore collections mirror the local database structure with some optimizations for cloud storage.

#### 4.2.1 Synchronization Strategy
The application follows a local-first approach:
- Primary data storage in local SQLite database
- Immediate local writes for responsive user experience
- Background synchronization with Firebase when online
- Conflict resolution using timestamp-based strategy (last-write-wins)

## 5. UI Architecture

### 5.1 Component Hierarchy

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

### 5.2 Navigation System

The application uses a custom navigation system built with:
- `PageNavigationFramework`: Manages page transitions and history
- `NavigationSidebar`: Provides a sidebar for navigating between major sections
- `InitialPageRouteNavigator`: Handles initial routing based on user state

### 5.3 State Management

The application uses a combination of state management approaches:
- **`setState`**: Used within individual widgets
- **Global Keys**: Used for triggering rebuilds across the application
- **`provider`**: Used for providing data and services to widgets
- **`shared_preferences`**: Used for storing persistent application settings
- **Custom Streams**: Used for reactive updates to wallet and transaction data

## 6. Business Logic

### 6.1 Core Features

#### 6.1.1 Budget Management
- Creating, editing, and tracking budgets
- Setting budget limits for specific categories
- Visualizing budget progress
- Handling recurring budgets with different time periods

#### 6.1.2 Transaction Management
- Adding, editing, and categorizing transactions
- Supporting different transaction types (income, expense, transfers)
- Handling recurring transactions
- Automatic categorization based on transaction patterns

#### 6.1.3 Account/Wallet Management
- Managing multiple accounts or wallets
- Tracking balances and transaction history
- Supporting different currencies and formatting options

#### 6.1.4 Financial Goals
- Setting and tracking progress towards financial objectives
- Supporting different goal types (savings, debt repayment)
- Visualizing goal achievement

#### 6.1.5 Reporting and Analysis
- Generating reports and visualizations
- Analyzing spending patterns and trends
- Providing insights on financial health

### 6.2 Authentication and Security

#### 6.2.1 User Authentication
- Firebase Authentication for cloud services
- Google Sign-In integration
- Local authentication (biometrics) for app access

#### 6.2.2 Data Security
- End-to-end encryption for sensitive data
- Secure key storage and management
- Access control through Firebase security rules

## 7. External Integrations

### 7.1 Firebase Services

#### 7.1.1 Firebase Authentication
Handles user identity management and secure access to cloud data.

#### 7.1.2 Firestore
Provides cloud storage for user data and enables synchronization across devices.

### 7.2 Platform Integrations

#### 7.2.1 Notifications
Integrates with platform notification systems to provide reminders and alerts.

#### 7.2.2 Biometric Authentication
Uses platform biometric capabilities for secure local authentication.

## 8. Internationalization

### 8.1 Language Support
The application supports multiple languages through the `easy_localization` package. Translation files are stored in `assets/translations/`.

### 8.2 Currency Support
The application supports multiple currencies with customizable formatting options. Currency data is stored in `assets/static/generated/currencies.json`.

## 9. Testing Strategy

### 9.1 Unit Testing
Focuses on testing individual components and functions in isolation.

### 9.2 Integration Testing
Tests interactions between different parts of the application.

### 9.3 UI Testing
Verifies that the UI components render correctly and respond appropriately to user interactions.

## 10. Deployment

### 10.1 Platform Support
- **Android**: Deployed through Google Play Store
- **iOS**: Deployed through Apple App Store
- **Web**: Deployed through Firebase Hosting
- **macOS**: Deployed through Apple App Store

### 10.2 Release Process
Outlines the steps for building, testing, and releasing new versions of the application.

## 11. Performance Considerations

### 11.1 Optimization Strategies
- Efficient database queries and indexing
- Lazy loading of UI components
- Caching of frequently accessed data
- Background processing for intensive operations

### 11.2 Resource Management
- Battery usage optimization
- Network bandwidth management
- Storage space efficiency

## 12. Security Considerations

### 12.1 Data Protection
- Secure storage of sensitive information
- Encryption of data at rest and in transit
- Access control and authentication

### 12.2 Compliance
- Adherence to data protection regulations
- Privacy policy implementation
- Secure data deletion procedures

## 13. Future Enhancements

### 13.1 Planned Features
- Advanced data visualization options
- Enhanced synchronization capabilities
- Improved machine learning for transaction categorization
- Additional platform support

### 13.2 Technical Debt
- Code refactoring opportunities
- Performance optimization areas
- Testing coverage improvements

## 14. Conclusion

The Cashew app is built on a solid technical foundation with a well-structured architecture, robust data model, and comprehensive feature set. The application's design prioritizes user experience, data integrity, and performance while providing flexibility for future enhancements and platform expansions.

## Appendix

### A. Glossary
Defines key terms and concepts used throughout the document.

### B. References
Lists external resources and documentation referenced in the design.

### C. Revision History
Tracks changes to the technical design document over time.