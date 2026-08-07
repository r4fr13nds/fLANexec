// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ScanResultsTable extends ScanResults
    with TableInfo<$ScanResultsTable, ScanResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ipAddressMeta = const VerificationMeta(
    'ipAddress',
  );
  @override
  late final GeneratedColumn<String> ipAddress = GeneratedColumn<String>(
    'ip_address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hostnameMeta = const VerificationMeta(
    'hostname',
  );
  @override
  late final GeneratedColumn<String> hostname = GeneratedColumn<String>(
    'hostname',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scanTimeMeta = const VerificationMeta(
    'scanTime',
  );
  @override
  late final GeneratedColumn<DateTime> scanTime = GeneratedColumn<DateTime>(
    'scan_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openPortsMeta = const VerificationMeta(
    'openPorts',
  );
  @override
  late final GeneratedColumn<String> openPorts = GeneratedColumn<String>(
    'open_ports',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ipAddress,
    hostname,
    scanTime,
    openPorts,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scan_results';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScanResult> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ip_address')) {
      context.handle(
        _ipAddressMeta,
        ipAddress.isAcceptableOrUnknown(data['ip_address']!, _ipAddressMeta),
      );
    } else if (isInserting) {
      context.missing(_ipAddressMeta);
    }
    if (data.containsKey('hostname')) {
      context.handle(
        _hostnameMeta,
        hostname.isAcceptableOrUnknown(data['hostname']!, _hostnameMeta),
      );
    }
    if (data.containsKey('scan_time')) {
      context.handle(
        _scanTimeMeta,
        scanTime.isAcceptableOrUnknown(data['scan_time']!, _scanTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_scanTimeMeta);
    }
    if (data.containsKey('open_ports')) {
      context.handle(
        _openPortsMeta,
        openPorts.isAcceptableOrUnknown(data['open_ports']!, _openPortsMeta),
      );
    } else if (isInserting) {
      context.missing(_openPortsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScanResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanResult(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ipAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ip_address'],
      )!,
      hostname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hostname'],
      ),
      scanTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scan_time'],
      )!,
      openPorts: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}open_ports'],
      )!,
    );
  }

  @override
  $ScanResultsTable createAlias(String alias) {
    return $ScanResultsTable(attachedDatabase, alias);
  }
}

class ScanResult extends DataClass implements Insertable<ScanResult> {
  final int id;
  final String ipAddress;
  final String? hostname;
  final DateTime scanTime;
  final String openPorts;
  const ScanResult({
    required this.id,
    required this.ipAddress,
    this.hostname,
    required this.scanTime,
    required this.openPorts,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ip_address'] = Variable<String>(ipAddress);
    if (!nullToAbsent || hostname != null) {
      map['hostname'] = Variable<String>(hostname);
    }
    map['scan_time'] = Variable<DateTime>(scanTime);
    map['open_ports'] = Variable<String>(openPorts);
    return map;
  }

  ScanResultsCompanion toCompanion(bool nullToAbsent) {
    return ScanResultsCompanion(
      id: Value(id),
      ipAddress: Value(ipAddress),
      hostname: hostname == null && nullToAbsent
          ? const Value.absent()
          : Value(hostname),
      scanTime: Value(scanTime),
      openPorts: Value(openPorts),
    );
  }

  factory ScanResult.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanResult(
      id: serializer.fromJson<int>(json['id']),
      ipAddress: serializer.fromJson<String>(json['ipAddress']),
      hostname: serializer.fromJson<String?>(json['hostname']),
      scanTime: serializer.fromJson<DateTime>(json['scanTime']),
      openPorts: serializer.fromJson<String>(json['openPorts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ipAddress': serializer.toJson<String>(ipAddress),
      'hostname': serializer.toJson<String?>(hostname),
      'scanTime': serializer.toJson<DateTime>(scanTime),
      'openPorts': serializer.toJson<String>(openPorts),
    };
  }

  ScanResult copyWith({
    int? id,
    String? ipAddress,
    Value<String?> hostname = const Value.absent(),
    DateTime? scanTime,
    String? openPorts,
  }) => ScanResult(
    id: id ?? this.id,
    ipAddress: ipAddress ?? this.ipAddress,
    hostname: hostname.present ? hostname.value : this.hostname,
    scanTime: scanTime ?? this.scanTime,
    openPorts: openPorts ?? this.openPorts,
  );
  ScanResult copyWithCompanion(ScanResultsCompanion data) {
    return ScanResult(
      id: data.id.present ? data.id.value : this.id,
      ipAddress: data.ipAddress.present ? data.ipAddress.value : this.ipAddress,
      hostname: data.hostname.present ? data.hostname.value : this.hostname,
      scanTime: data.scanTime.present ? data.scanTime.value : this.scanTime,
      openPorts: data.openPorts.present ? data.openPorts.value : this.openPorts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanResult(')
          ..write('id: $id, ')
          ..write('ipAddress: $ipAddress, ')
          ..write('hostname: $hostname, ')
          ..write('scanTime: $scanTime, ')
          ..write('openPorts: $openPorts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ipAddress, hostname, scanTime, openPorts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanResult &&
          other.id == this.id &&
          other.ipAddress == this.ipAddress &&
          other.hostname == this.hostname &&
          other.scanTime == this.scanTime &&
          other.openPorts == this.openPorts);
}

class ScanResultsCompanion extends UpdateCompanion<ScanResult> {
  final Value<int> id;
  final Value<String> ipAddress;
  final Value<String?> hostname;
  final Value<DateTime> scanTime;
  final Value<String> openPorts;
  const ScanResultsCompanion({
    this.id = const Value.absent(),
    this.ipAddress = const Value.absent(),
    this.hostname = const Value.absent(),
    this.scanTime = const Value.absent(),
    this.openPorts = const Value.absent(),
  });
  ScanResultsCompanion.insert({
    this.id = const Value.absent(),
    required String ipAddress,
    this.hostname = const Value.absent(),
    required DateTime scanTime,
    required String openPorts,
  }) : ipAddress = Value(ipAddress),
       scanTime = Value(scanTime),
       openPorts = Value(openPorts);
  static Insertable<ScanResult> custom({
    Expression<int>? id,
    Expression<String>? ipAddress,
    Expression<String>? hostname,
    Expression<DateTime>? scanTime,
    Expression<String>? openPorts,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ipAddress != null) 'ip_address': ipAddress,
      if (hostname != null) 'hostname': hostname,
      if (scanTime != null) 'scan_time': scanTime,
      if (openPorts != null) 'open_ports': openPorts,
    });
  }

  ScanResultsCompanion copyWith({
    Value<int>? id,
    Value<String>? ipAddress,
    Value<String?>? hostname,
    Value<DateTime>? scanTime,
    Value<String>? openPorts,
  }) {
    return ScanResultsCompanion(
      id: id ?? this.id,
      ipAddress: ipAddress ?? this.ipAddress,
      hostname: hostname ?? this.hostname,
      scanTime: scanTime ?? this.scanTime,
      openPorts: openPorts ?? this.openPorts,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ipAddress.present) {
      map['ip_address'] = Variable<String>(ipAddress.value);
    }
    if (hostname.present) {
      map['hostname'] = Variable<String>(hostname.value);
    }
    if (scanTime.present) {
      map['scan_time'] = Variable<DateTime>(scanTime.value);
    }
    if (openPorts.present) {
      map['open_ports'] = Variable<String>(openPorts.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanResultsCompanion(')
          ..write('id: $id, ')
          ..write('ipAddress: $ipAddress, ')
          ..write('hostname: $hostname, ')
          ..write('scanTime: $scanTime, ')
          ..write('openPorts: $openPorts')
          ..write(')'))
        .toString();
  }
}

class $SavedScansTable extends SavedScans
    with TableInfo<$SavedScansTable, SavedScan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedScansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hostsJsonMeta = const VerificationMeta(
    'hostsJson',
  );
  @override
  late final GeneratedColumn<String> hostsJson = GeneratedColumn<String>(
    'hosts_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt, hostsJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_scans';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedScan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('hosts_json')) {
      context.handle(
        _hostsJsonMeta,
        hostsJson.isAcceptableOrUnknown(data['hosts_json']!, _hostsJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_hostsJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedScan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedScan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      hostsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hosts_json'],
      )!,
    );
  }

  @override
  $SavedScansTable createAlias(String alias) {
    return $SavedScansTable(attachedDatabase, alias);
  }
}

class SavedScan extends DataClass implements Insertable<SavedScan> {
  final int id;
  final String name;
  final DateTime createdAt;
  final String hostsJson;
  const SavedScan({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.hostsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['hosts_json'] = Variable<String>(hostsJson);
    return map;
  }

  SavedScansCompanion toCompanion(bool nullToAbsent) {
    return SavedScansCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      hostsJson: Value(hostsJson),
    );
  }

  factory SavedScan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedScan(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      hostsJson: serializer.fromJson<String>(json['hostsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'hostsJson': serializer.toJson<String>(hostsJson),
    };
  }

  SavedScan copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    String? hostsJson,
  }) => SavedScan(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    hostsJson: hostsJson ?? this.hostsJson,
  );
  SavedScan copyWithCompanion(SavedScansCompanion data) {
    return SavedScan(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      hostsJson: data.hostsJson.present ? data.hostsJson.value : this.hostsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedScan(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('hostsJson: $hostsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt, hostsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedScan &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.hostsJson == this.hostsJson);
}

class SavedScansCompanion extends UpdateCompanion<SavedScan> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<String> hostsJson;
  const SavedScansCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.hostsJson = const Value.absent(),
  });
  SavedScansCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime createdAt,
    required String hostsJson,
  }) : name = Value(name),
       createdAt = Value(createdAt),
       hostsJson = Value(hostsJson);
  static Insertable<SavedScan> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<String>? hostsJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (hostsJson != null) 'hosts_json': hostsJson,
    });
  }

  SavedScansCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<String>? hostsJson,
  }) {
    return SavedScansCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      hostsJson: hostsJson ?? this.hostsJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (hostsJson.present) {
      map['hosts_json'] = Variable<String>(hostsJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedScansCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('hostsJson: $hostsJson')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ScanResultsTable scanResults = $ScanResultsTable(this);
  late final $SavedScansTable savedScans = $SavedScansTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [scanResults, savedScans];
}

typedef $$ScanResultsTableCreateCompanionBuilder =
    ScanResultsCompanion Function({
      Value<int> id,
      required String ipAddress,
      Value<String?> hostname,
      required DateTime scanTime,
      required String openPorts,
    });
typedef $$ScanResultsTableUpdateCompanionBuilder =
    ScanResultsCompanion Function({
      Value<int> id,
      Value<String> ipAddress,
      Value<String?> hostname,
      Value<DateTime> scanTime,
      Value<String> openPorts,
    });

class $$ScanResultsTableFilterComposer
    extends Composer<_$AppDatabase, $ScanResultsTable> {
  $$ScanResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ipAddress => $composableBuilder(
    column: $table.ipAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hostname => $composableBuilder(
    column: $table.hostname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scanTime => $composableBuilder(
    column: $table.scanTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get openPorts => $composableBuilder(
    column: $table.openPorts,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScanResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScanResultsTable> {
  $$ScanResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ipAddress => $composableBuilder(
    column: $table.ipAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hostname => $composableBuilder(
    column: $table.hostname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scanTime => $composableBuilder(
    column: $table.scanTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get openPorts => $composableBuilder(
    column: $table.openPorts,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScanResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScanResultsTable> {
  $$ScanResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ipAddress =>
      $composableBuilder(column: $table.ipAddress, builder: (column) => column);

  GeneratedColumn<String> get hostname =>
      $composableBuilder(column: $table.hostname, builder: (column) => column);

  GeneratedColumn<DateTime> get scanTime =>
      $composableBuilder(column: $table.scanTime, builder: (column) => column);

  GeneratedColumn<String> get openPorts =>
      $composableBuilder(column: $table.openPorts, builder: (column) => column);
}

class $$ScanResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScanResultsTable,
          ScanResult,
          $$ScanResultsTableFilterComposer,
          $$ScanResultsTableOrderingComposer,
          $$ScanResultsTableAnnotationComposer,
          $$ScanResultsTableCreateCompanionBuilder,
          $$ScanResultsTableUpdateCompanionBuilder,
          (
            ScanResult,
            BaseReferences<_$AppDatabase, $ScanResultsTable, ScanResult>,
          ),
          ScanResult,
          PrefetchHooks Function()
        > {
  $$ScanResultsTableTableManager(_$AppDatabase db, $ScanResultsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScanResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScanResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScanResultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> ipAddress = const Value.absent(),
                Value<String?> hostname = const Value.absent(),
                Value<DateTime> scanTime = const Value.absent(),
                Value<String> openPorts = const Value.absent(),
              }) => ScanResultsCompanion(
                id: id,
                ipAddress: ipAddress,
                hostname: hostname,
                scanTime: scanTime,
                openPorts: openPorts,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ipAddress,
                Value<String?> hostname = const Value.absent(),
                required DateTime scanTime,
                required String openPorts,
              }) => ScanResultsCompanion.insert(
                id: id,
                ipAddress: ipAddress,
                hostname: hostname,
                scanTime: scanTime,
                openPorts: openPorts,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScanResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScanResultsTable,
      ScanResult,
      $$ScanResultsTableFilterComposer,
      $$ScanResultsTableOrderingComposer,
      $$ScanResultsTableAnnotationComposer,
      $$ScanResultsTableCreateCompanionBuilder,
      $$ScanResultsTableUpdateCompanionBuilder,
      (
        ScanResult,
        BaseReferences<_$AppDatabase, $ScanResultsTable, ScanResult>,
      ),
      ScanResult,
      PrefetchHooks Function()
    >;
typedef $$SavedScansTableCreateCompanionBuilder =
    SavedScansCompanion Function({
      Value<int> id,
      required String name,
      required DateTime createdAt,
      required String hostsJson,
    });
typedef $$SavedScansTableUpdateCompanionBuilder =
    SavedScansCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<String> hostsJson,
    });

class $$SavedScansTableFilterComposer
    extends Composer<_$AppDatabase, $SavedScansTable> {
  $$SavedScansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hostsJson => $composableBuilder(
    column: $table.hostsJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavedScansTableOrderingComposer
    extends Composer<_$AppDatabase, $SavedScansTable> {
  $$SavedScansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hostsJson => $composableBuilder(
    column: $table.hostsJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavedScansTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavedScansTable> {
  $$SavedScansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get hostsJson =>
      $composableBuilder(column: $table.hostsJson, builder: (column) => column);
}

class $$SavedScansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavedScansTable,
          SavedScan,
          $$SavedScansTableFilterComposer,
          $$SavedScansTableOrderingComposer,
          $$SavedScansTableAnnotationComposer,
          $$SavedScansTableCreateCompanionBuilder,
          $$SavedScansTableUpdateCompanionBuilder,
          (
            SavedScan,
            BaseReferences<_$AppDatabase, $SavedScansTable, SavedScan>,
          ),
          SavedScan,
          PrefetchHooks Function()
        > {
  $$SavedScansTableTableManager(_$AppDatabase db, $SavedScansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavedScansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavedScansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavedScansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> hostsJson = const Value.absent(),
              }) => SavedScansCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                hostsJson: hostsJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required DateTime createdAt,
                required String hostsJson,
              }) => SavedScansCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                hostsJson: hostsJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavedScansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavedScansTable,
      SavedScan,
      $$SavedScansTableFilterComposer,
      $$SavedScansTableOrderingComposer,
      $$SavedScansTableAnnotationComposer,
      $$SavedScansTableCreateCompanionBuilder,
      $$SavedScansTableUpdateCompanionBuilder,
      (SavedScan, BaseReferences<_$AppDatabase, $SavedScansTable, SavedScan>),
      SavedScan,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ScanResultsTableTableManager get scanResults =>
      $$ScanResultsTableTableManager(_db, _db.scanResults);
  $$SavedScansTableTableManager get savedScans =>
      $$SavedScansTableTableManager(_db, _db.savedScans);
}
