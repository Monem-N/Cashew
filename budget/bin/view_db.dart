import 'package:budget/database/tables.dart';
import 'package:budget/struct/databaseGlobal.dart';
import 'package:budget/database/view_database_contents.dart';

void main() async {
  database = await constructDb('db');
  await viewDatabaseContents();
}