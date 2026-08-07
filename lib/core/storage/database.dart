import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class ScanResults extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ipAddress => text()();
  TextColumn get hostname => text().nullable()();
  DateTimeColumn get scanTime => dateTime()();
  TextColumn get openPorts => text()(); // Store as comma-separated or JSON
}

class SavedScans extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get hostsJson => text()(); // Serialized List<Host>
}

@DriftDatabase(tables: [ScanResults, SavedScans])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // final cachebase = await getTemporaryDirectory();
    // sqlite3.tempDirectory = cachebase.path;

    return NativeDatabase.createInBackground(file);
  });
}
