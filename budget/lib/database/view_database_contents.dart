import 'package:budget/struct/databaseGlobal.dart';
import 'package:drift/drift.dart';

Future<void> viewDatabaseContents() async {
  print('\n=== Database Contents ===\n');

  // View Wallets
  final wallets = await database.select(database.wallets).get();
  print('Wallets (${wallets.length}):');
  for (final wallet in wallets) {
    print('- ${wallet.name}: ${wallet.currency} ${wallet.currencyFormat}');
  }
  print('');

  // View Categories
  final categories = await database.select(database.categories).get();
  print('Categories (${categories.length}):');
  for (final category in categories) {
    print('- ${category.name} (${category.income ? "Income" : "Expense"})');
  }
  print('');

  // View Recent Transactions
  final transactions = await database.select(database.transactions)
    ..limit(10)
    ..orderBy([(t) => OrderingTerm(expression: t.dateCreated, mode: OrderingMode.desc)]);
  final recentTransactions = await transactions.get();
  print('Recent Transactions (last 10):');
  for (final transaction in recentTransactions) {
    print('- ${transaction.name}: ${transaction.amount} (${transaction.dateCreated})');
  }
  print('');

  // View Budgets
  final budgets = await database.select(database.budgets).get();
  print('Budgets (${budgets.length}):');
  for (final budget in budgets) {
    print('- ${budget.name}: ${budget.amount}');
  }
  print('');

  // Execute custom query using Drift's custom select
  try {
    final query = await database.customSelect(
      'SELECT name, amount, date_created FROM transactions ORDER BY date_created DESC LIMIT 5',
    ).get();
    
    print('Custom Query Results:');
    for (final row in query) {
      print('- ${row.data['name']}: ${row.data['amount']} (${row.data['date_created']})');
    }
  } catch (e) {
    print('Error executing custom query: $e');
  }

  print('\n=== End of Database Contents ===\n');
}

// Function to execute custom SELECT queries
Future<void> executeCustomQuery(String sqlQuery) async {
  if (!sqlQuery.trim().toUpperCase().startsWith('SELECT')) {
    print('Error: Only SELECT queries are allowed for safety reasons');
    return;
  }

  try {
    final result = await database.customSelect(sqlQuery).get();
    print('\n=== Query Results ===\n');
    if (result.isEmpty) {
      print('No results found');
    } else {
      // Print column names
      print(result.first.data.keys.join(' | '));
      print('-' * 50);
      
      // Print rows
      for (final row in result) {
        print(row.data.values.join(' | '));
      }
    }
    print('\n=== End of Query Results ===\n');
  } catch (e) {
    print('Error executing query: $e');
  }
}