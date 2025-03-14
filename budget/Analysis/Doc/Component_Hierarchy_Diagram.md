# Component Hierarchy Diagram for Cashew App

## 0. Introduction

This document provides an overview of the Cashew app's component hierarchy, illustrating the relationships and organization of various components within the application.

## 1. Cashew App Component Hierarchy

HomePage
├── HomePageWalletSwitcher
│   └── EditHomePagePinnedWalletsPopup
├── HomePageWalletList
│   └── EditHomePagePinnedWalletsPopup
├── HomePageBudgets
│   └── EditHomePagePinnedBudgetsPopup
├── HomePageUpcomingTransactions
│   └── openOverdueUpcomingSettings
├── HomePageAllSpendingSummary
│   └── openAllSpendingSettings
├── HomePageNetWorth
│   └── openNetWorthSettings
├── HomePageObjectives
│   ├── (ObjectiveType.goal)
│   │   └── EditHomePagePinnedGoalsPopup
│   └── (ObjectiveType.loan)
│       └── EditHomePagePinnedGoalsPopup
├── HomePageLineGraph
│   ├── RadioItems
│   └── showCustomDatePicker
├── HomePagePieChart
│   └── openPieChartHomePageBottomSheetSettings
│       ├── WalletPickerPeriodCycle
│       └── IncomeAndExpenseOnlyPicker
├── HomePageHeatMap
│   └── openHeatMapHomePageBottomSheetSettings
├── HomeTransactions
│   ├── SlidingSelectorIncomeExpense
│   ├── ViewAllTransactionsButton
│   └── TransactionsListHomePageBottomSheetSettings
│       ├── SettingsContainerDropdown
│       └── IncomeAndExpenseOnlyPicker
├── HomePageUsername
│   ├── enterNameBottomSheet
│   └── HomePageBannerSettings
├── HomePageRatingBox
│   ├── ScalingStars
│   └── Button (x2)
└── EditHomePage
    └── SliverReorderableList
        └── HomePageEditRowEntry
            ├── (Cupertino)Switch
            └── EditRowEntry
                ├── Icon
                └── TextFont
    └── HomePageEditRowEntryUsername
        └── HomePageBannerSettings
            ├── SettingsContainer
            │   ├── MoreChevron
            │   └── enterNameBottomSheet
            └── SettingsContainerSwitch

## 2. Project Structure Analysis

- The Cashew app follows a structured organization, primarily located in the `lib` directory.
- Key components include:
  - **Pages**: Main screens of the application.
  - **Widgets**: Reusable UI components.
  - **Struct**: Contains core business logic and data models.
  - **Database**: Manages data access and persistence.

## 3. UI Component Hierarchy

- The UI component hierarchy is structured to facilitate navigation and user interaction.
- Key reusable widgets include:
  - **Header**: Displays the app title and navigation options.
  - **Footer**: Contains links to additional resources.
  - **Form Components**: Used for user input in budgeting and transaction features.

## 4. Feature Mapping

- Main features of the app include:
  - Budgeting
  - Transactions
  - Accounts
  - Objectives
- Each feature is mapped to its corresponding code files, illustrating how they interact with the UI components.

## 5. Conclusion

The Component Hierarchy Diagram serves as a valuable reference for understanding the structure and relationships of components within the Cashew app, aiding in future development and maintenance.
