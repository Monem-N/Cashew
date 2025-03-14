# High-Level Components List

This document lists the major functional components of the Cashew application.

## Core Functionality

-   **Budget Management**: Creating, editing, and tracking budgets. This includes setting budget limits, associating transactions with budgets, and visualizing budget progress.
-   **Transaction Management**: Adding, editing, categorizing, and searching transactions. This includes support for different transaction types (income, expense, transfers) and recurring transactions.
-   **Account/Wallet Management**: Managing multiple accounts or wallets, tracking balances, and viewing transaction history for each account.
-   **Objective/Goal Tracking**: Setting financial goals (e.g., saving for a purchase, paying off debt), tracking progress, and visualizing goal achievement.
-   **Reporting and Analysis**: Generating reports and visualizations to analyze spending patterns, income/expense trends, and net worth. This includes charts (pie charts, line graphs, heatmaps) and summary views.
-   **Notifications**: Providing reminders for upcoming transactions, overdue bills, and budget alerts.
-   **Settings and Configuration**: Managing user preferences, application settings, and account details. This includes options for theming, notifications, and data synchronization.
- **Import/Export**: Functionality to import and export data in CSV and database formats.

## Supporting Components

-   **Authentication**: User authentication using Firebase Authentication (with Google Sign-In) and local biometrics.
-   **Data Synchronization**: Synchronizing data between the local database (Drift/SQLite) and Firebase Cloud Firestore.
-   **Internationalization**: Support for multiple languages and currencies using `easy_localization`.

## UI Components (Summary)

The application's UI is built using a combination of standard Flutter widgets and custom components. Key UI components include:

-   **HomePage**: A customizable dashboard displaying various sections like wallet switcher, budget summaries, upcoming transactions, and charts.
-   **NavigationSidebar**: A sidebar for navigating between major sections of the application.
-   **EditHomePage**: A screen for customizing the layout and content of the HomePage.
- **Various Pages**: Dedicated pages for managing accounts, budgets, transactions, objectives, and settings.

(See `component_hierarchy.md` for a detailed UI component breakdown.)