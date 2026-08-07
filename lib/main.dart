import 'package:flanexec/app.dart';
import 'package:flanexec/core/storage/database.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database early if needed, or just let Riverpod handle it.
  final database = AppDatabase();

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
      ],
      child: const NetScanApp(),
    ),
  );
}
