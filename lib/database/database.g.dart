// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, PgDateTime> createdAt =
      GeneratedColumn<PgDateTime>(
        'created_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        clientDefault: () => PgDateTime(DateTime.now().toUtc()),
      ).withConverter<DateTime>($UsersTable.$convertercreatedAt);
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, PgDateTime> updatedAt =
      GeneratedColumn<PgDateTime>(
        'updated_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        clientDefault: () => PgDateTime(DateTime.now().toUtc()),
      ).withConverter<DateTime>($UsersTable.$converterupdatedAt);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    firstName,
    lastName,
    username,
    email,
    passwordHash,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      firstName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}first_name'],
          )!,
      lastName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}last_name'],
          )!,
      username:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}username'],
          )!,
      email:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}email'],
          )!,
      passwordHash:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}password_hash'],
          )!,
      createdAt: $UsersTable.$convertercreatedAt.fromSql(
        attachedDatabase.typeMapping.read(
          PgTypes.timestampWithTimezone,
          data['${effectivePrefix}created_at'],
        )!,
      ),
      updatedAt: $UsersTable.$converterupdatedAt.fromSql(
        attachedDatabase.typeMapping.read(
          PgTypes.timestampWithTimezone,
          data['${effectivePrefix}updated_at'],
        )!,
      ),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }

  static TypeConverter<DateTime, PgDateTime?> $convertercreatedAt =
      const PostgreSQLTimestampConverter();
  static TypeConverter<DateTime, PgDateTime?> $converterupdatedAt =
      const PostgreSQLTimestampConverter();
}

class User extends Table implements Insertable<User> {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String passwordHash;
  final DateTime createdAt;
  final DateTime updatedAt;
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.passwordHash,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['username'] = Variable<String>(username);
    map['email'] = Variable<String>(email);
    map['password_hash'] = Variable<String>(passwordHash);
    {
      map['created_at'] = Variable<PgDateTime>(
        $UsersTable.$convertercreatedAt.toSql(createdAt),
        PgTypes.timestampWithTimezone,
      );
    }
    {
      map['updated_at'] = Variable<PgDateTime>(
        $UsersTable.$converterupdatedAt.toSql(updatedAt),
        PgTypes.timestampWithTimezone,
      );
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      username: Value(username),
      email: Value(email),
      passwordHash: Value(passwordHash),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      username: serializer.fromJson<String>(json['username']),
      email: serializer.fromJson<String>(json['email']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'username': serializer.toJson<String>(username),
      'email': serializer.toJson<String>(email),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? passwordHash,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => User(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    username: username ?? this.username,
    email: email ?? this.email,
    passwordHash: passwordHash ?? this.passwordHash,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      username: data.username.present ? data.username.value : this.username,
      email: data.email.present ? data.email.value : this.email,
      passwordHash:
          data.passwordHash.present
              ? data.passwordHash.value
              : this.passwordHash,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    firstName,
    lastName,
    username,
    email,
    passwordHash,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.username == this.username &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> username;
  final Value<String> email;
  final Value<String> passwordHash;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.username = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String passwordHash,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : firstName = Value(firstName),
       lastName = Value(lastName),
       username = Value(username),
       email = Value(email),
       passwordHash = Value(passwordHash);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? username,
    Expression<String>? email,
    Expression<String>? passwordHash,
    Expression<PgDateTime>? createdAt,
    Expression<PgDateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (username != null) 'username': username,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String>? username,
    Value<String>? email,
    Value<String>? passwordHash,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<PgDateTime>(
        $UsersTable.$convertercreatedAt.toSql(createdAt.value),
        PgTypes.timestampWithTimezone,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<PgDateTime>(
        $UsersTable.$converterupdatedAt.toSql(updatedAt.value),
        PgTypes.timestampWithTimezone,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('username: $username, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PlaylistsTable extends Playlists
    with TableInfo<$PlaylistsTable, Playlist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, PgDateTime> createdAt =
      GeneratedColumn<PgDateTime>(
        'created_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        clientDefault: () => PgDateTime(DateTime.now().toUtc()),
      ).withConverter<DateTime>($PlaylistsTable.$convertercreatedAt);
  static const VerificationMeta _thumbnailMeta = const VerificationMeta(
    'thumbnail',
  );
  @override
  late final GeneratedColumn<String> thumbnail = GeneratedColumn<String>(
    'thumbnail',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    userId,
    createdAt,
    thumbnail,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlists';
  @override
  VerificationContext validateIntegrity(
    Insertable<Playlist> instance, {
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
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('thumbnail')) {
      context.handle(
        _thumbnailMeta,
        thumbnail.isAcceptableOrUnknown(data['thumbnail']!, _thumbnailMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Playlist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Playlist(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      userId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}user_id'],
          )!,
      createdAt: $PlaylistsTable.$convertercreatedAt.fromSql(
        attachedDatabase.typeMapping.read(
          PgTypes.timestampWithTimezone,
          data['${effectivePrefix}created_at'],
        )!,
      ),
      thumbnail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail'],
      ),
    );
  }

  @override
  $PlaylistsTable createAlias(String alias) {
    return $PlaylistsTable(attachedDatabase, alias);
  }

  static TypeConverter<DateTime, PgDateTime?> $convertercreatedAt =
      const PostgreSQLTimestampConverter();
}

class Playlist extends DataClass implements Insertable<Playlist> {
  final int id;
  final String name;
  final int userId;
  final DateTime createdAt;
  final String? thumbnail;
  const Playlist({
    required this.id,
    required this.name,
    required this.userId,
    required this.createdAt,
    this.thumbnail,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['user_id'] = Variable<int>(userId);
    {
      map['created_at'] = Variable<PgDateTime>(
        $PlaylistsTable.$convertercreatedAt.toSql(createdAt),
        PgTypes.timestampWithTimezone,
      );
    }
    if (!nullToAbsent || thumbnail != null) {
      map['thumbnail'] = Variable<String>(thumbnail);
    }
    return map;
  }

  PlaylistsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistsCompanion(
      id: Value(id),
      name: Value(name),
      userId: Value(userId),
      createdAt: Value(createdAt),
      thumbnail:
          thumbnail == null && nullToAbsent
              ? const Value.absent()
              : Value(thumbnail),
    );
  }

  factory Playlist.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Playlist(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      userId: serializer.fromJson<int>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      thumbnail: serializer.fromJson<String?>(json['thumbnail']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'userId': serializer.toJson<int>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'thumbnail': serializer.toJson<String?>(thumbnail),
    };
  }

  Playlist copyWith({
    int? id,
    String? name,
    int? userId,
    DateTime? createdAt,
    Value<String?> thumbnail = const Value.absent(),
  }) => Playlist(
    id: id ?? this.id,
    name: name ?? this.name,
    userId: userId ?? this.userId,
    createdAt: createdAt ?? this.createdAt,
    thumbnail: thumbnail.present ? thumbnail.value : this.thumbnail,
  );
  Playlist copyWithCompanion(PlaylistsCompanion data) {
    return Playlist(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      thumbnail: data.thumbnail.present ? data.thumbnail.value : this.thumbnail,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Playlist(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('thumbnail: $thumbnail')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, userId, createdAt, thumbnail);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Playlist &&
          other.id == this.id &&
          other.name == this.name &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt &&
          other.thumbnail == this.thumbnail);
}

class PlaylistsCompanion extends UpdateCompanion<Playlist> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> userId;
  final Value<DateTime> createdAt;
  final Value<String?> thumbnail;
  const PlaylistsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.thumbnail = const Value.absent(),
  });
  PlaylistsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int userId,
    this.createdAt = const Value.absent(),
    this.thumbnail = const Value.absent(),
  }) : name = Value(name),
       userId = Value(userId);
  static Insertable<Playlist> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? userId,
    Expression<PgDateTime>? createdAt,
    Expression<String>? thumbnail,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (thumbnail != null) 'thumbnail': thumbnail,
    });
  }

  PlaylistsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? userId,
    Value<DateTime>? createdAt,
    Value<String?>? thumbnail,
  }) {
    return PlaylistsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      thumbnail: thumbnail ?? this.thumbnail,
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
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<PgDateTime>(
        $PlaylistsTable.$convertercreatedAt.toSql(createdAt.value),
        PgTypes.timestampWithTimezone,
      );
    }
    if (thumbnail.present) {
      map['thumbnail'] = Variable<String>(thumbnail.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('thumbnail: $thumbnail')
          ..write(')'))
        .toString();
  }
}

class $PlaylistItemsTable extends PlaylistItems
    with TableInfo<$PlaylistItemsTable, PlaylistItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _playlistIdMeta = const VerificationMeta(
    'playlistId',
  );
  @override
  late final GeneratedColumn<int> playlistId = GeneratedColumn<int>(
    'playlist_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES playlists (id)',
    ),
  );
  static const VerificationMeta _trackIdMeta = const VerificationMeta(
    'trackId',
  );
  @override
  late final GeneratedColumn<String> trackId = GeneratedColumn<String>(
    'track_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackTitleMeta = const VerificationMeta(
    'trackTitle',
  );
  @override
  late final GeneratedColumn<String> trackTitle = GeneratedColumn<String>(
    'track_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackArtistMeta = const VerificationMeta(
    'trackArtist',
  );
  @override
  late final GeneratedColumn<String> trackArtist = GeneratedColumn<String>(
    'track_artist',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackThumbnailPathMeta =
      const VerificationMeta('trackThumbnailPath');
  @override
  late final GeneratedColumn<String> trackThumbnailPath =
      GeneratedColumn<String>(
        'track_thumbnail_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _trackDurationSecondsMeta =
      const VerificationMeta('trackDurationSeconds');
  @override
  late final GeneratedColumn<int> trackDurationSeconds = GeneratedColumn<int>(
    'track_duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, PgDateTime> addedAt =
      GeneratedColumn<PgDateTime>(
        'added_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        clientDefault: () => PgDateTime(DateTime.now().toUtc()),
      ).withConverter<DateTime>($PlaylistItemsTable.$converteraddedAt);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    playlistId,
    trackId,
    trackTitle,
    trackArtist,
    trackThumbnailPath,
    trackDurationSeconds,
    addedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaylistItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('playlist_id')) {
      context.handle(
        _playlistIdMeta,
        playlistId.isAcceptableOrUnknown(data['playlist_id']!, _playlistIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('track_id')) {
      context.handle(
        _trackIdMeta,
        trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('track_title')) {
      context.handle(
        _trackTitleMeta,
        trackTitle.isAcceptableOrUnknown(data['track_title']!, _trackTitleMeta),
      );
    } else if (isInserting) {
      context.missing(_trackTitleMeta);
    }
    if (data.containsKey('track_artist')) {
      context.handle(
        _trackArtistMeta,
        trackArtist.isAcceptableOrUnknown(
          data['track_artist']!,
          _trackArtistMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_trackArtistMeta);
    }
    if (data.containsKey('track_thumbnail_path')) {
      context.handle(
        _trackThumbnailPathMeta,
        trackThumbnailPath.isAcceptableOrUnknown(
          data['track_thumbnail_path']!,
          _trackThumbnailPathMeta,
        ),
      );
    }
    if (data.containsKey('track_duration_seconds')) {
      context.handle(
        _trackDurationSecondsMeta,
        trackDurationSeconds.isAcceptableOrUnknown(
          data['track_duration_seconds']!,
          _trackDurationSecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistItem(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      playlistId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}playlist_id'],
          )!,
      trackId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}track_id'],
          )!,
      trackTitle:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}track_title'],
          )!,
      trackArtist:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}track_artist'],
          )!,
      trackThumbnailPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}track_thumbnail_path'],
      ),
      trackDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_duration_seconds'],
      ),
      addedAt: $PlaylistItemsTable.$converteraddedAt.fromSql(
        attachedDatabase.typeMapping.read(
          PgTypes.timestampWithTimezone,
          data['${effectivePrefix}added_at'],
        )!,
      ),
    );
  }

  @override
  $PlaylistItemsTable createAlias(String alias) {
    return $PlaylistItemsTable(attachedDatabase, alias);
  }

  static TypeConverter<DateTime, PgDateTime?> $converteraddedAt =
      const PostgreSQLTimestampConverter();
}

class PlaylistItem extends DataClass implements Insertable<PlaylistItem> {
  final int id;
  final int playlistId;
  final String trackId;
  final String trackTitle;
  final String trackArtist;
  final String? trackThumbnailPath;
  final int? trackDurationSeconds;
  final DateTime addedAt;
  const PlaylistItem({
    required this.id,
    required this.playlistId,
    required this.trackId,
    required this.trackTitle,
    required this.trackArtist,
    this.trackThumbnailPath,
    this.trackDurationSeconds,
    required this.addedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['playlist_id'] = Variable<int>(playlistId);
    map['track_id'] = Variable<String>(trackId);
    map['track_title'] = Variable<String>(trackTitle);
    map['track_artist'] = Variable<String>(trackArtist);
    if (!nullToAbsent || trackThumbnailPath != null) {
      map['track_thumbnail_path'] = Variable<String>(trackThumbnailPath);
    }
    if (!nullToAbsent || trackDurationSeconds != null) {
      map['track_duration_seconds'] = Variable<int>(trackDurationSeconds);
    }
    {
      map['added_at'] = Variable<PgDateTime>(
        $PlaylistItemsTable.$converteraddedAt.toSql(addedAt),
        PgTypes.timestampWithTimezone,
      );
    }
    return map;
  }

  PlaylistItemsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistItemsCompanion(
      id: Value(id),
      playlistId: Value(playlistId),
      trackId: Value(trackId),
      trackTitle: Value(trackTitle),
      trackArtist: Value(trackArtist),
      trackThumbnailPath:
          trackThumbnailPath == null && nullToAbsent
              ? const Value.absent()
              : Value(trackThumbnailPath),
      trackDurationSeconds:
          trackDurationSeconds == null && nullToAbsent
              ? const Value.absent()
              : Value(trackDurationSeconds),
      addedAt: Value(addedAt),
    );
  }

  factory PlaylistItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistItem(
      id: serializer.fromJson<int>(json['id']),
      playlistId: serializer.fromJson<int>(json['playlistId']),
      trackId: serializer.fromJson<String>(json['trackId']),
      trackTitle: serializer.fromJson<String>(json['trackTitle']),
      trackArtist: serializer.fromJson<String>(json['trackArtist']),
      trackThumbnailPath: serializer.fromJson<String?>(
        json['trackThumbnailPath'],
      ),
      trackDurationSeconds: serializer.fromJson<int?>(
        json['trackDurationSeconds'],
      ),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playlistId': serializer.toJson<int>(playlistId),
      'trackId': serializer.toJson<String>(trackId),
      'trackTitle': serializer.toJson<String>(trackTitle),
      'trackArtist': serializer.toJson<String>(trackArtist),
      'trackThumbnailPath': serializer.toJson<String?>(trackThumbnailPath),
      'trackDurationSeconds': serializer.toJson<int?>(trackDurationSeconds),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  PlaylistItem copyWith({
    int? id,
    int? playlistId,
    String? trackId,
    String? trackTitle,
    String? trackArtist,
    Value<String?> trackThumbnailPath = const Value.absent(),
    Value<int?> trackDurationSeconds = const Value.absent(),
    DateTime? addedAt,
  }) => PlaylistItem(
    id: id ?? this.id,
    playlistId: playlistId ?? this.playlistId,
    trackId: trackId ?? this.trackId,
    trackTitle: trackTitle ?? this.trackTitle,
    trackArtist: trackArtist ?? this.trackArtist,
    trackThumbnailPath:
        trackThumbnailPath.present
            ? trackThumbnailPath.value
            : this.trackThumbnailPath,
    trackDurationSeconds:
        trackDurationSeconds.present
            ? trackDurationSeconds.value
            : this.trackDurationSeconds,
    addedAt: addedAt ?? this.addedAt,
  );
  PlaylistItem copyWithCompanion(PlaylistItemsCompanion data) {
    return PlaylistItem(
      id: data.id.present ? data.id.value : this.id,
      playlistId:
          data.playlistId.present ? data.playlistId.value : this.playlistId,
      trackId: data.trackId.present ? data.trackId.value : this.trackId,
      trackTitle:
          data.trackTitle.present ? data.trackTitle.value : this.trackTitle,
      trackArtist:
          data.trackArtist.present ? data.trackArtist.value : this.trackArtist,
      trackThumbnailPath:
          data.trackThumbnailPath.present
              ? data.trackThumbnailPath.value
              : this.trackThumbnailPath,
      trackDurationSeconds:
          data.trackDurationSeconds.present
              ? data.trackDurationSeconds.value
              : this.trackDurationSeconds,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistItem(')
          ..write('id: $id, ')
          ..write('playlistId: $playlistId, ')
          ..write('trackId: $trackId, ')
          ..write('trackTitle: $trackTitle, ')
          ..write('trackArtist: $trackArtist, ')
          ..write('trackThumbnailPath: $trackThumbnailPath, ')
          ..write('trackDurationSeconds: $trackDurationSeconds, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    playlistId,
    trackId,
    trackTitle,
    trackArtist,
    trackThumbnailPath,
    trackDurationSeconds,
    addedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistItem &&
          other.id == this.id &&
          other.playlistId == this.playlistId &&
          other.trackId == this.trackId &&
          other.trackTitle == this.trackTitle &&
          other.trackArtist == this.trackArtist &&
          other.trackThumbnailPath == this.trackThumbnailPath &&
          other.trackDurationSeconds == this.trackDurationSeconds &&
          other.addedAt == this.addedAt);
}

class PlaylistItemsCompanion extends UpdateCompanion<PlaylistItem> {
  final Value<int> id;
  final Value<int> playlistId;
  final Value<String> trackId;
  final Value<String> trackTitle;
  final Value<String> trackArtist;
  final Value<String?> trackThumbnailPath;
  final Value<int?> trackDurationSeconds;
  final Value<DateTime> addedAt;
  const PlaylistItemsCompanion({
    this.id = const Value.absent(),
    this.playlistId = const Value.absent(),
    this.trackId = const Value.absent(),
    this.trackTitle = const Value.absent(),
    this.trackArtist = const Value.absent(),
    this.trackThumbnailPath = const Value.absent(),
    this.trackDurationSeconds = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  PlaylistItemsCompanion.insert({
    this.id = const Value.absent(),
    required int playlistId,
    required String trackId,
    required String trackTitle,
    required String trackArtist,
    this.trackThumbnailPath = const Value.absent(),
    this.trackDurationSeconds = const Value.absent(),
    this.addedAt = const Value.absent(),
  }) : playlistId = Value(playlistId),
       trackId = Value(trackId),
       trackTitle = Value(trackTitle),
       trackArtist = Value(trackArtist);
  static Insertable<PlaylistItem> custom({
    Expression<int>? id,
    Expression<int>? playlistId,
    Expression<String>? trackId,
    Expression<String>? trackTitle,
    Expression<String>? trackArtist,
    Expression<String>? trackThumbnailPath,
    Expression<int>? trackDurationSeconds,
    Expression<PgDateTime>? addedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playlistId != null) 'playlist_id': playlistId,
      if (trackId != null) 'track_id': trackId,
      if (trackTitle != null) 'track_title': trackTitle,
      if (trackArtist != null) 'track_artist': trackArtist,
      if (trackThumbnailPath != null)
        'track_thumbnail_path': trackThumbnailPath,
      if (trackDurationSeconds != null)
        'track_duration_seconds': trackDurationSeconds,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  PlaylistItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? playlistId,
    Value<String>? trackId,
    Value<String>? trackTitle,
    Value<String>? trackArtist,
    Value<String?>? trackThumbnailPath,
    Value<int?>? trackDurationSeconds,
    Value<DateTime>? addedAt,
  }) {
    return PlaylistItemsCompanion(
      id: id ?? this.id,
      playlistId: playlistId ?? this.playlistId,
      trackId: trackId ?? this.trackId,
      trackTitle: trackTitle ?? this.trackTitle,
      trackArtist: trackArtist ?? this.trackArtist,
      trackThumbnailPath: trackThumbnailPath ?? this.trackThumbnailPath,
      trackDurationSeconds: trackDurationSeconds ?? this.trackDurationSeconds,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playlistId.present) {
      map['playlist_id'] = Variable<int>(playlistId.value);
    }
    if (trackId.present) {
      map['track_id'] = Variable<String>(trackId.value);
    }
    if (trackTitle.present) {
      map['track_title'] = Variable<String>(trackTitle.value);
    }
    if (trackArtist.present) {
      map['track_artist'] = Variable<String>(trackArtist.value);
    }
    if (trackThumbnailPath.present) {
      map['track_thumbnail_path'] = Variable<String>(trackThumbnailPath.value);
    }
    if (trackDurationSeconds.present) {
      map['track_duration_seconds'] = Variable<int>(trackDurationSeconds.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<PgDateTime>(
        $PlaylistItemsTable.$converteraddedAt.toSql(addedAt.value),
        PgTypes.timestampWithTimezone,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistItemsCompanion(')
          ..write('id: $id, ')
          ..write('playlistId: $playlistId, ')
          ..write('trackId: $trackId, ')
          ..write('trackTitle: $trackTitle, ')
          ..write('trackArtist: $trackArtist, ')
          ..write('trackThumbnailPath: $trackThumbnailPath, ')
          ..write('trackDurationSeconds: $trackDurationSeconds, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

class $LikedSongsTable extends LikedSongs
    with TableInfo<$LikedSongsTable, LikedSong> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LikedSongsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _trackIdMeta = const VerificationMeta(
    'trackId',
  );
  @override
  late final GeneratedColumn<String> trackId = GeneratedColumn<String>(
    'track_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackTitleMeta = const VerificationMeta(
    'trackTitle',
  );
  @override
  late final GeneratedColumn<String> trackTitle = GeneratedColumn<String>(
    'track_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackArtistMeta = const VerificationMeta(
    'trackArtist',
  );
  @override
  late final GeneratedColumn<String> trackArtist = GeneratedColumn<String>(
    'track_artist',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackThumbnailPathMeta =
      const VerificationMeta('trackThumbnailPath');
  @override
  late final GeneratedColumn<String> trackThumbnailPath =
      GeneratedColumn<String>(
        'track_thumbnail_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _trackDurationSecondsMeta =
      const VerificationMeta('trackDurationSeconds');
  @override
  late final GeneratedColumn<int> trackDurationSeconds = GeneratedColumn<int>(
    'track_duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, PgDateTime> likedAt =
      GeneratedColumn<PgDateTime>(
        'liked_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        clientDefault: () => PgDateTime(DateTime.now().toUtc()),
      ).withConverter<DateTime>($LikedSongsTable.$converterlikedAt);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    trackId,
    trackTitle,
    trackArtist,
    trackThumbnailPath,
    trackDurationSeconds,
    likedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'liked_songs';
  @override
  VerificationContext validateIntegrity(
    Insertable<LikedSong> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('track_id')) {
      context.handle(
        _trackIdMeta,
        trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('track_title')) {
      context.handle(
        _trackTitleMeta,
        trackTitle.isAcceptableOrUnknown(data['track_title']!, _trackTitleMeta),
      );
    } else if (isInserting) {
      context.missing(_trackTitleMeta);
    }
    if (data.containsKey('track_artist')) {
      context.handle(
        _trackArtistMeta,
        trackArtist.isAcceptableOrUnknown(
          data['track_artist']!,
          _trackArtistMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_trackArtistMeta);
    }
    if (data.containsKey('track_thumbnail_path')) {
      context.handle(
        _trackThumbnailPathMeta,
        trackThumbnailPath.isAcceptableOrUnknown(
          data['track_thumbnail_path']!,
          _trackThumbnailPathMeta,
        ),
      );
    }
    if (data.containsKey('track_duration_seconds')) {
      context.handle(
        _trackDurationSecondsMeta,
        trackDurationSeconds.isAcceptableOrUnknown(
          data['track_duration_seconds']!,
          _trackDurationSecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LikedSong map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LikedSong(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      userId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}user_id'],
          )!,
      trackId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}track_id'],
          )!,
      trackTitle:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}track_title'],
          )!,
      trackArtist:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}track_artist'],
          )!,
      trackThumbnailPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}track_thumbnail_path'],
      ),
      trackDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_duration_seconds'],
      ),
      likedAt: $LikedSongsTable.$converterlikedAt.fromSql(
        attachedDatabase.typeMapping.read(
          PgTypes.timestampWithTimezone,
          data['${effectivePrefix}liked_at'],
        )!,
      ),
    );
  }

  @override
  $LikedSongsTable createAlias(String alias) {
    return $LikedSongsTable(attachedDatabase, alias);
  }

  static TypeConverter<DateTime, PgDateTime?> $converterlikedAt =
      const PostgreSQLTimestampConverter();
}

class LikedSong extends DataClass implements Insertable<LikedSong> {
  final int id;
  final int userId;
  final String trackId;
  final String trackTitle;
  final String trackArtist;
  final String? trackThumbnailPath;
  final int? trackDurationSeconds;
  final DateTime likedAt;
  const LikedSong({
    required this.id,
    required this.userId,
    required this.trackId,
    required this.trackTitle,
    required this.trackArtist,
    this.trackThumbnailPath,
    this.trackDurationSeconds,
    required this.likedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['track_id'] = Variable<String>(trackId);
    map['track_title'] = Variable<String>(trackTitle);
    map['track_artist'] = Variable<String>(trackArtist);
    if (!nullToAbsent || trackThumbnailPath != null) {
      map['track_thumbnail_path'] = Variable<String>(trackThumbnailPath);
    }
    if (!nullToAbsent || trackDurationSeconds != null) {
      map['track_duration_seconds'] = Variable<int>(trackDurationSeconds);
    }
    {
      map['liked_at'] = Variable<PgDateTime>(
        $LikedSongsTable.$converterlikedAt.toSql(likedAt),
        PgTypes.timestampWithTimezone,
      );
    }
    return map;
  }

  LikedSongsCompanion toCompanion(bool nullToAbsent) {
    return LikedSongsCompanion(
      id: Value(id),
      userId: Value(userId),
      trackId: Value(trackId),
      trackTitle: Value(trackTitle),
      trackArtist: Value(trackArtist),
      trackThumbnailPath:
          trackThumbnailPath == null && nullToAbsent
              ? const Value.absent()
              : Value(trackThumbnailPath),
      trackDurationSeconds:
          trackDurationSeconds == null && nullToAbsent
              ? const Value.absent()
              : Value(trackDurationSeconds),
      likedAt: Value(likedAt),
    );
  }

  factory LikedSong.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LikedSong(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      trackId: serializer.fromJson<String>(json['trackId']),
      trackTitle: serializer.fromJson<String>(json['trackTitle']),
      trackArtist: serializer.fromJson<String>(json['trackArtist']),
      trackThumbnailPath: serializer.fromJson<String?>(
        json['trackThumbnailPath'],
      ),
      trackDurationSeconds: serializer.fromJson<int?>(
        json['trackDurationSeconds'],
      ),
      likedAt: serializer.fromJson<DateTime>(json['likedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'trackId': serializer.toJson<String>(trackId),
      'trackTitle': serializer.toJson<String>(trackTitle),
      'trackArtist': serializer.toJson<String>(trackArtist),
      'trackThumbnailPath': serializer.toJson<String?>(trackThumbnailPath),
      'trackDurationSeconds': serializer.toJson<int?>(trackDurationSeconds),
      'likedAt': serializer.toJson<DateTime>(likedAt),
    };
  }

  LikedSong copyWith({
    int? id,
    int? userId,
    String? trackId,
    String? trackTitle,
    String? trackArtist,
    Value<String?> trackThumbnailPath = const Value.absent(),
    Value<int?> trackDurationSeconds = const Value.absent(),
    DateTime? likedAt,
  }) => LikedSong(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    trackId: trackId ?? this.trackId,
    trackTitle: trackTitle ?? this.trackTitle,
    trackArtist: trackArtist ?? this.trackArtist,
    trackThumbnailPath:
        trackThumbnailPath.present
            ? trackThumbnailPath.value
            : this.trackThumbnailPath,
    trackDurationSeconds:
        trackDurationSeconds.present
            ? trackDurationSeconds.value
            : this.trackDurationSeconds,
    likedAt: likedAt ?? this.likedAt,
  );
  LikedSong copyWithCompanion(LikedSongsCompanion data) {
    return LikedSong(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      trackId: data.trackId.present ? data.trackId.value : this.trackId,
      trackTitle:
          data.trackTitle.present ? data.trackTitle.value : this.trackTitle,
      trackArtist:
          data.trackArtist.present ? data.trackArtist.value : this.trackArtist,
      trackThumbnailPath:
          data.trackThumbnailPath.present
              ? data.trackThumbnailPath.value
              : this.trackThumbnailPath,
      trackDurationSeconds:
          data.trackDurationSeconds.present
              ? data.trackDurationSeconds.value
              : this.trackDurationSeconds,
      likedAt: data.likedAt.present ? data.likedAt.value : this.likedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LikedSong(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('trackId: $trackId, ')
          ..write('trackTitle: $trackTitle, ')
          ..write('trackArtist: $trackArtist, ')
          ..write('trackThumbnailPath: $trackThumbnailPath, ')
          ..write('trackDurationSeconds: $trackDurationSeconds, ')
          ..write('likedAt: $likedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    trackId,
    trackTitle,
    trackArtist,
    trackThumbnailPath,
    trackDurationSeconds,
    likedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LikedSong &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.trackId == this.trackId &&
          other.trackTitle == this.trackTitle &&
          other.trackArtist == this.trackArtist &&
          other.trackThumbnailPath == this.trackThumbnailPath &&
          other.trackDurationSeconds == this.trackDurationSeconds &&
          other.likedAt == this.likedAt);
}

class LikedSongsCompanion extends UpdateCompanion<LikedSong> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> trackId;
  final Value<String> trackTitle;
  final Value<String> trackArtist;
  final Value<String?> trackThumbnailPath;
  final Value<int?> trackDurationSeconds;
  final Value<DateTime> likedAt;
  const LikedSongsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.trackId = const Value.absent(),
    this.trackTitle = const Value.absent(),
    this.trackArtist = const Value.absent(),
    this.trackThumbnailPath = const Value.absent(),
    this.trackDurationSeconds = const Value.absent(),
    this.likedAt = const Value.absent(),
  });
  LikedSongsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String trackId,
    required String trackTitle,
    required String trackArtist,
    this.trackThumbnailPath = const Value.absent(),
    this.trackDurationSeconds = const Value.absent(),
    this.likedAt = const Value.absent(),
  }) : userId = Value(userId),
       trackId = Value(trackId),
       trackTitle = Value(trackTitle),
       trackArtist = Value(trackArtist);
  static Insertable<LikedSong> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? trackId,
    Expression<String>? trackTitle,
    Expression<String>? trackArtist,
    Expression<String>? trackThumbnailPath,
    Expression<int>? trackDurationSeconds,
    Expression<PgDateTime>? likedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (trackId != null) 'track_id': trackId,
      if (trackTitle != null) 'track_title': trackTitle,
      if (trackArtist != null) 'track_artist': trackArtist,
      if (trackThumbnailPath != null)
        'track_thumbnail_path': trackThumbnailPath,
      if (trackDurationSeconds != null)
        'track_duration_seconds': trackDurationSeconds,
      if (likedAt != null) 'liked_at': likedAt,
    });
  }

  LikedSongsCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<String>? trackId,
    Value<String>? trackTitle,
    Value<String>? trackArtist,
    Value<String?>? trackThumbnailPath,
    Value<int?>? trackDurationSeconds,
    Value<DateTime>? likedAt,
  }) {
    return LikedSongsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      trackId: trackId ?? this.trackId,
      trackTitle: trackTitle ?? this.trackTitle,
      trackArtist: trackArtist ?? this.trackArtist,
      trackThumbnailPath: trackThumbnailPath ?? this.trackThumbnailPath,
      trackDurationSeconds: trackDurationSeconds ?? this.trackDurationSeconds,
      likedAt: likedAt ?? this.likedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (trackId.present) {
      map['track_id'] = Variable<String>(trackId.value);
    }
    if (trackTitle.present) {
      map['track_title'] = Variable<String>(trackTitle.value);
    }
    if (trackArtist.present) {
      map['track_artist'] = Variable<String>(trackArtist.value);
    }
    if (trackThumbnailPath.present) {
      map['track_thumbnail_path'] = Variable<String>(trackThumbnailPath.value);
    }
    if (trackDurationSeconds.present) {
      map['track_duration_seconds'] = Variable<int>(trackDurationSeconds.value);
    }
    if (likedAt.present) {
      map['liked_at'] = Variable<PgDateTime>(
        $LikedSongsTable.$converterlikedAt.toSql(likedAt.value),
        PgTypes.timestampWithTimezone,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LikedSongsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('trackId: $trackId, ')
          ..write('trackTitle: $trackTitle, ')
          ..write('trackArtist: $trackArtist, ')
          ..write('trackThumbnailPath: $trackThumbnailPath, ')
          ..write('trackDurationSeconds: $trackDurationSeconds, ')
          ..write('likedAt: $likedAt')
          ..write(')'))
        .toString();
  }
}

class $HistoryTable extends History
    with TableInfo<$HistoryTable, HistoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _trackIdMeta = const VerificationMeta(
    'trackId',
  );
  @override
  late final GeneratedColumn<String> trackId = GeneratedColumn<String>(
    'track_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackTitleMeta = const VerificationMeta(
    'trackTitle',
  );
  @override
  late final GeneratedColumn<String> trackTitle = GeneratedColumn<String>(
    'track_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackArtistMeta = const VerificationMeta(
    'trackArtist',
  );
  @override
  late final GeneratedColumn<String> trackArtist = GeneratedColumn<String>(
    'track_artist',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackThumbnailPathMeta =
      const VerificationMeta('trackThumbnailPath');
  @override
  late final GeneratedColumn<String> trackThumbnailPath =
      GeneratedColumn<String>(
        'track_thumbnail_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _trackDurationSecondsMeta =
      const VerificationMeta('trackDurationSeconds');
  @override
  late final GeneratedColumn<int> trackDurationSeconds = GeneratedColumn<int>(
    'track_duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DateTime, PgDateTime> playedAt =
      GeneratedColumn<PgDateTime>(
        'played_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        clientDefault: () => PgDateTime(DateTime.now().toUtc()),
      ).withConverter<DateTime>($HistoryTable.$converterplayedAt);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    trackId,
    trackTitle,
    trackArtist,
    trackThumbnailPath,
    trackDurationSeconds,
    playedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'history';
  @override
  VerificationContext validateIntegrity(
    Insertable<HistoryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('track_id')) {
      context.handle(
        _trackIdMeta,
        trackId.isAcceptableOrUnknown(data['track_id']!, _trackIdMeta),
      );
    } else if (isInserting) {
      context.missing(_trackIdMeta);
    }
    if (data.containsKey('track_title')) {
      context.handle(
        _trackTitleMeta,
        trackTitle.isAcceptableOrUnknown(data['track_title']!, _trackTitleMeta),
      );
    } else if (isInserting) {
      context.missing(_trackTitleMeta);
    }
    if (data.containsKey('track_artist')) {
      context.handle(
        _trackArtistMeta,
        trackArtist.isAcceptableOrUnknown(
          data['track_artist']!,
          _trackArtistMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_trackArtistMeta);
    }
    if (data.containsKey('track_thumbnail_path')) {
      context.handle(
        _trackThumbnailPathMeta,
        trackThumbnailPath.isAcceptableOrUnknown(
          data['track_thumbnail_path']!,
          _trackThumbnailPathMeta,
        ),
      );
    }
    if (data.containsKey('track_duration_seconds')) {
      context.handle(
        _trackDurationSecondsMeta,
        trackDurationSeconds.isAcceptableOrUnknown(
          data['track_duration_seconds']!,
          _trackDurationSecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistoryEntry(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      userId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}user_id'],
          )!,
      trackId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}track_id'],
          )!,
      trackTitle:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}track_title'],
          )!,
      trackArtist:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}track_artist'],
          )!,
      trackThumbnailPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}track_thumbnail_path'],
      ),
      trackDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}track_duration_seconds'],
      ),
      playedAt: $HistoryTable.$converterplayedAt.fromSql(
        attachedDatabase.typeMapping.read(
          PgTypes.timestampWithTimezone,
          data['${effectivePrefix}played_at'],
        )!,
      ),
    );
  }

  @override
  $HistoryTable createAlias(String alias) {
    return $HistoryTable(attachedDatabase, alias);
  }

  static TypeConverter<DateTime, PgDateTime?> $converterplayedAt =
      const PostgreSQLTimestampConverter();
}

class HistoryEntry extends DataClass implements Insertable<HistoryEntry> {
  final int id;
  final int userId;
  final String trackId;
  final String trackTitle;
  final String trackArtist;
  final String? trackThumbnailPath;
  final int? trackDurationSeconds;
  final DateTime playedAt;
  const HistoryEntry({
    required this.id,
    required this.userId,
    required this.trackId,
    required this.trackTitle,
    required this.trackArtist,
    this.trackThumbnailPath,
    this.trackDurationSeconds,
    required this.playedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['track_id'] = Variable<String>(trackId);
    map['track_title'] = Variable<String>(trackTitle);
    map['track_artist'] = Variable<String>(trackArtist);
    if (!nullToAbsent || trackThumbnailPath != null) {
      map['track_thumbnail_path'] = Variable<String>(trackThumbnailPath);
    }
    if (!nullToAbsent || trackDurationSeconds != null) {
      map['track_duration_seconds'] = Variable<int>(trackDurationSeconds);
    }
    {
      map['played_at'] = Variable<PgDateTime>(
        $HistoryTable.$converterplayedAt.toSql(playedAt),
        PgTypes.timestampWithTimezone,
      );
    }
    return map;
  }

  HistoryCompanion toCompanion(bool nullToAbsent) {
    return HistoryCompanion(
      id: Value(id),
      userId: Value(userId),
      trackId: Value(trackId),
      trackTitle: Value(trackTitle),
      trackArtist: Value(trackArtist),
      trackThumbnailPath:
          trackThumbnailPath == null && nullToAbsent
              ? const Value.absent()
              : Value(trackThumbnailPath),
      trackDurationSeconds:
          trackDurationSeconds == null && nullToAbsent
              ? const Value.absent()
              : Value(trackDurationSeconds),
      playedAt: Value(playedAt),
    );
  }

  factory HistoryEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistoryEntry(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      trackId: serializer.fromJson<String>(json['trackId']),
      trackTitle: serializer.fromJson<String>(json['trackTitle']),
      trackArtist: serializer.fromJson<String>(json['trackArtist']),
      trackThumbnailPath: serializer.fromJson<String?>(
        json['trackThumbnailPath'],
      ),
      trackDurationSeconds: serializer.fromJson<int?>(
        json['trackDurationSeconds'],
      ),
      playedAt: serializer.fromJson<DateTime>(json['playedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'trackId': serializer.toJson<String>(trackId),
      'trackTitle': serializer.toJson<String>(trackTitle),
      'trackArtist': serializer.toJson<String>(trackArtist),
      'trackThumbnailPath': serializer.toJson<String?>(trackThumbnailPath),
      'trackDurationSeconds': serializer.toJson<int?>(trackDurationSeconds),
      'playedAt': serializer.toJson<DateTime>(playedAt),
    };
  }

  HistoryEntry copyWith({
    int? id,
    int? userId,
    String? trackId,
    String? trackTitle,
    String? trackArtist,
    Value<String?> trackThumbnailPath = const Value.absent(),
    Value<int?> trackDurationSeconds = const Value.absent(),
    DateTime? playedAt,
  }) => HistoryEntry(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    trackId: trackId ?? this.trackId,
    trackTitle: trackTitle ?? this.trackTitle,
    trackArtist: trackArtist ?? this.trackArtist,
    trackThumbnailPath:
        trackThumbnailPath.present
            ? trackThumbnailPath.value
            : this.trackThumbnailPath,
    trackDurationSeconds:
        trackDurationSeconds.present
            ? trackDurationSeconds.value
            : this.trackDurationSeconds,
    playedAt: playedAt ?? this.playedAt,
  );
  HistoryEntry copyWithCompanion(HistoryCompanion data) {
    return HistoryEntry(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      trackId: data.trackId.present ? data.trackId.value : this.trackId,
      trackTitle:
          data.trackTitle.present ? data.trackTitle.value : this.trackTitle,
      trackArtist:
          data.trackArtist.present ? data.trackArtist.value : this.trackArtist,
      trackThumbnailPath:
          data.trackThumbnailPath.present
              ? data.trackThumbnailPath.value
              : this.trackThumbnailPath,
      trackDurationSeconds:
          data.trackDurationSeconds.present
              ? data.trackDurationSeconds.value
              : this.trackDurationSeconds,
      playedAt: data.playedAt.present ? data.playedAt.value : this.playedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistoryEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('trackId: $trackId, ')
          ..write('trackTitle: $trackTitle, ')
          ..write('trackArtist: $trackArtist, ')
          ..write('trackThumbnailPath: $trackThumbnailPath, ')
          ..write('trackDurationSeconds: $trackDurationSeconds, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    trackId,
    trackTitle,
    trackArtist,
    trackThumbnailPath,
    trackDurationSeconds,
    playedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.trackId == this.trackId &&
          other.trackTitle == this.trackTitle &&
          other.trackArtist == this.trackArtist &&
          other.trackThumbnailPath == this.trackThumbnailPath &&
          other.trackDurationSeconds == this.trackDurationSeconds &&
          other.playedAt == this.playedAt);
}

class HistoryCompanion extends UpdateCompanion<HistoryEntry> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> trackId;
  final Value<String> trackTitle;
  final Value<String> trackArtist;
  final Value<String?> trackThumbnailPath;
  final Value<int?> trackDurationSeconds;
  final Value<DateTime> playedAt;
  const HistoryCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.trackId = const Value.absent(),
    this.trackTitle = const Value.absent(),
    this.trackArtist = const Value.absent(),
    this.trackThumbnailPath = const Value.absent(),
    this.trackDurationSeconds = const Value.absent(),
    this.playedAt = const Value.absent(),
  });
  HistoryCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String trackId,
    required String trackTitle,
    required String trackArtist,
    this.trackThumbnailPath = const Value.absent(),
    this.trackDurationSeconds = const Value.absent(),
    this.playedAt = const Value.absent(),
  }) : userId = Value(userId),
       trackId = Value(trackId),
       trackTitle = Value(trackTitle),
       trackArtist = Value(trackArtist);
  static Insertable<HistoryEntry> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? trackId,
    Expression<String>? trackTitle,
    Expression<String>? trackArtist,
    Expression<String>? trackThumbnailPath,
    Expression<int>? trackDurationSeconds,
    Expression<PgDateTime>? playedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (trackId != null) 'track_id': trackId,
      if (trackTitle != null) 'track_title': trackTitle,
      if (trackArtist != null) 'track_artist': trackArtist,
      if (trackThumbnailPath != null)
        'track_thumbnail_path': trackThumbnailPath,
      if (trackDurationSeconds != null)
        'track_duration_seconds': trackDurationSeconds,
      if (playedAt != null) 'played_at': playedAt,
    });
  }

  HistoryCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<String>? trackId,
    Value<String>? trackTitle,
    Value<String>? trackArtist,
    Value<String?>? trackThumbnailPath,
    Value<int?>? trackDurationSeconds,
    Value<DateTime>? playedAt,
  }) {
    return HistoryCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      trackId: trackId ?? this.trackId,
      trackTitle: trackTitle ?? this.trackTitle,
      trackArtist: trackArtist ?? this.trackArtist,
      trackThumbnailPath: trackThumbnailPath ?? this.trackThumbnailPath,
      trackDurationSeconds: trackDurationSeconds ?? this.trackDurationSeconds,
      playedAt: playedAt ?? this.playedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (trackId.present) {
      map['track_id'] = Variable<String>(trackId.value);
    }
    if (trackTitle.present) {
      map['track_title'] = Variable<String>(trackTitle.value);
    }
    if (trackArtist.present) {
      map['track_artist'] = Variable<String>(trackArtist.value);
    }
    if (trackThumbnailPath.present) {
      map['track_thumbnail_path'] = Variable<String>(trackThumbnailPath.value);
    }
    if (trackDurationSeconds.present) {
      map['track_duration_seconds'] = Variable<int>(trackDurationSeconds.value);
    }
    if (playedAt.present) {
      map['played_at'] = Variable<PgDateTime>(
        $HistoryTable.$converterplayedAt.toSql(playedAt.value),
        PgTypes.timestampWithTimezone,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('trackId: $trackId, ')
          ..write('trackTitle: $trackTitle, ')
          ..write('trackArtist: $trackArtist, ')
          ..write('trackThumbnailPath: $trackThumbnailPath, ')
          ..write('trackDurationSeconds: $trackDurationSeconds, ')
          ..write('playedAt: $playedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $PlaylistsTable playlists = $PlaylistsTable(this);
  late final $PlaylistItemsTable playlistItems = $PlaylistItemsTable(this);
  late final $LikedSongsTable likedSongs = $LikedSongsTable(this);
  late final $HistoryTable history = $HistoryTable(this);
  late final UserDao userDao = UserDao(this as AppDatabase);
  late final PlaylistDao playlistDao = PlaylistDao(this as AppDatabase);
  late final PlaylistItemDao playlistItemDao = PlaylistItemDao(
    this as AppDatabase,
  );
  late final LikedSongDao likedSongDao = LikedSongDao(this as AppDatabase);
  late final HistoryDao historyDao = HistoryDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    playlists,
    playlistItems,
    likedSongs,
    history,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String firstName,
      required String lastName,
      required String username,
      required String email,
      required String passwordHash,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> firstName,
      Value<String> lastName,
      Value<String> username,
      Value<String> email,
      Value<String> passwordHash,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlaylistsTable, List<Playlist>>
  _playlistsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.playlists,
    aliasName: $_aliasNameGenerator(db.users.id, db.playlists.userId),
  );

  $$PlaylistsTableProcessedTableManager get playlistsRefs {
    final manager = $$PlaylistsTableTableManager(
      $_db,
      $_db.playlists,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_playlistsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LikedSongsTable, List<LikedSong>>
  _likedSongsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.likedSongs,
    aliasName: $_aliasNameGenerator(db.users.id, db.likedSongs.userId),
  );

  $$LikedSongsTableProcessedTableManager get likedSongsRefs {
    final manager = $$LikedSongsTableTableManager(
      $_db,
      $_db.likedSongs,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_likedSongsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HistoryTable, List<HistoryEntry>>
  _historyRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.history,
    aliasName: $_aliasNameGenerator(db.users.id, db.history.userId),
  );

  $$HistoryTableProcessedTableManager get historyRefs {
    final manager = $$HistoryTableTableManager(
      $_db,
      $_db.history,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_historyRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
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

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DateTime, DateTime, PgDateTime>
  get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<DateTime, DateTime, PgDateTime>
  get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  Expression<bool> playlistsRefs(
    Expression<bool> Function($$PlaylistsTableFilterComposer f) f,
  ) {
    final $$PlaylistsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableFilterComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> likedSongsRefs(
    Expression<bool> Function($$LikedSongsTableFilterComposer f) f,
  ) {
    final $$LikedSongsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.likedSongs,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LikedSongsTableFilterComposer(
            $db: $db,
            $table: $db.likedSongs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> historyRefs(
    Expression<bool> Function($$HistoryTableFilterComposer f) f,
  ) {
    final $$HistoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.history,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HistoryTableFilterComposer(
            $db: $db,
            $table: $db.history,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
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

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<DateTime, PgDateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DateTime, PgDateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> playlistsRefs<T extends Object>(
    Expression<T> Function($$PlaylistsTableAnnotationComposer a) f,
  ) {
    final $$PlaylistsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableAnnotationComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> likedSongsRefs<T extends Object>(
    Expression<T> Function($$LikedSongsTableAnnotationComposer a) f,
  ) {
    final $$LikedSongsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.likedSongs,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LikedSongsTableAnnotationComposer(
            $db: $db,
            $table: $db.likedSongs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> historyRefs<T extends Object>(
    Expression<T> Function($$HistoryTableAnnotationComposer a) f,
  ) {
    final $$HistoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.history,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HistoryTableAnnotationComposer(
            $db: $db,
            $table: $db.history,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({
            bool playlistsRefs,
            bool likedSongsRefs,
            bool historyRefs,
          })
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                firstName: firstName,
                lastName: lastName,
                username: username,
                email: email,
                passwordHash: passwordHash,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String firstName,
                required String lastName,
                required String username,
                required String email,
                required String passwordHash,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                firstName: firstName,
                lastName: lastName,
                username: username,
                email: email,
                passwordHash: passwordHash,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$UsersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({
            playlistsRefs = false,
            likedSongsRefs = false,
            historyRefs = false,
          }) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (playlistsRefs) db.playlists,
                if (likedSongsRefs) db.likedSongs,
                if (historyRefs) db.history,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (playlistsRefs)
                    await $_getPrefetchedData<User, $UsersTable, Playlist>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences
                          ._playlistsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).playlistsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                  if (likedSongsRefs)
                    await $_getPrefetchedData<User, $UsersTable, LikedSong>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences
                          ._likedSongsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).likedSongsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                  if (historyRefs)
                    await $_getPrefetchedData<User, $UsersTable, HistoryEntry>(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences._historyRefsTable(
                        db,
                      ),
                      managerFromTypedResult:
                          (p0) =>
                              $$UsersTableReferences(db, table, p0).historyRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) =>
                              referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({
        bool playlistsRefs,
        bool likedSongsRefs,
        bool historyRefs,
      })
    >;
typedef $$PlaylistsTableCreateCompanionBuilder =
    PlaylistsCompanion Function({
      Value<int> id,
      required String name,
      required int userId,
      Value<DateTime> createdAt,
      Value<String?> thumbnail,
    });
typedef $$PlaylistsTableUpdateCompanionBuilder =
    PlaylistsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> userId,
      Value<DateTime> createdAt,
      Value<String?> thumbnail,
    });

final class $$PlaylistsTableReferences
    extends BaseReferences<_$AppDatabase, $PlaylistsTable, Playlist> {
  $$PlaylistsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.playlists.userId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PlaylistItemsTable, List<PlaylistItem>>
  _playlistItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.playlistItems,
    aliasName: $_aliasNameGenerator(
      db.playlists.id,
      db.playlistItems.playlistId,
    ),
  );

  $$PlaylistItemsTableProcessedTableManager get playlistItemsRefs {
    final manager = $$PlaylistItemsTableTableManager(
      $_db,
      $_db.playlistItems,
    ).filter((f) => f.playlistId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_playlistItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlaylistsTableFilterComposer
    extends Composer<_$AppDatabase, $PlaylistsTable> {
  $$PlaylistsTableFilterComposer({
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

  ColumnWithTypeConverterFilters<DateTime, DateTime, PgDateTime>
  get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get thumbnail => $composableBuilder(
    column: $table.thumbnail,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> playlistItemsRefs(
    Expression<bool> Function($$PlaylistItemsTableFilterComposer f) f,
  ) {
    final $$PlaylistItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlistItems,
      getReferencedColumn: (t) => t.playlistId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistItemsTableFilterComposer(
            $db: $db,
            $table: $db.playlistItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlaylistsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaylistsTable> {
  $$PlaylistsTableOrderingComposer({
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

  ColumnOrderings<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnail => $composableBuilder(
    column: $table.thumbnail,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaylistsTable> {
  $$PlaylistsTableAnnotationComposer({
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

  GeneratedColumnWithTypeConverter<DateTime, PgDateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get thumbnail =>
      $composableBuilder(column: $table.thumbnail, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> playlistItemsRefs<T extends Object>(
    Expression<T> Function($$PlaylistItemsTableAnnotationComposer a) f,
  ) {
    final $$PlaylistItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playlistItems,
      getReferencedColumn: (t) => t.playlistId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.playlistItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlaylistsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlaylistsTable,
          Playlist,
          $$PlaylistsTableFilterComposer,
          $$PlaylistsTableOrderingComposer,
          $$PlaylistsTableAnnotationComposer,
          $$PlaylistsTableCreateCompanionBuilder,
          $$PlaylistsTableUpdateCompanionBuilder,
          (Playlist, $$PlaylistsTableReferences),
          Playlist,
          PrefetchHooks Function({bool userId, bool playlistItemsRefs})
        > {
  $$PlaylistsTableTableManager(_$AppDatabase db, $PlaylistsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PlaylistsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PlaylistsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$PlaylistsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> thumbnail = const Value.absent(),
              }) => PlaylistsCompanion(
                id: id,
                name: name,
                userId: userId,
                createdAt: createdAt,
                thumbnail: thumbnail,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int userId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> thumbnail = const Value.absent(),
              }) => PlaylistsCompanion.insert(
                id: id,
                name: name,
                userId: userId,
                createdAt: createdAt,
                thumbnail: thumbnail,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$PlaylistsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({userId = false, playlistItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (playlistItemsRefs) db.playlistItems,
              ],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (userId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.userId,
                            referencedTable: $$PlaylistsTableReferences
                                ._userIdTable(db),
                            referencedColumn:
                                $$PlaylistsTableReferences._userIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (playlistItemsRefs)
                    await $_getPrefetchedData<
                      Playlist,
                      $PlaylistsTable,
                      PlaylistItem
                    >(
                      currentTable: table,
                      referencedTable: $$PlaylistsTableReferences
                          ._playlistItemsRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$PlaylistsTableReferences(
                                db,
                                table,
                                p0,
                              ).playlistItemsRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.playlistId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PlaylistsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlaylistsTable,
      Playlist,
      $$PlaylistsTableFilterComposer,
      $$PlaylistsTableOrderingComposer,
      $$PlaylistsTableAnnotationComposer,
      $$PlaylistsTableCreateCompanionBuilder,
      $$PlaylistsTableUpdateCompanionBuilder,
      (Playlist, $$PlaylistsTableReferences),
      Playlist,
      PrefetchHooks Function({bool userId, bool playlistItemsRefs})
    >;
typedef $$PlaylistItemsTableCreateCompanionBuilder =
    PlaylistItemsCompanion Function({
      Value<int> id,
      required int playlistId,
      required String trackId,
      required String trackTitle,
      required String trackArtist,
      Value<String?> trackThumbnailPath,
      Value<int?> trackDurationSeconds,
      Value<DateTime> addedAt,
    });
typedef $$PlaylistItemsTableUpdateCompanionBuilder =
    PlaylistItemsCompanion Function({
      Value<int> id,
      Value<int> playlistId,
      Value<String> trackId,
      Value<String> trackTitle,
      Value<String> trackArtist,
      Value<String?> trackThumbnailPath,
      Value<int?> trackDurationSeconds,
      Value<DateTime> addedAt,
    });

final class $$PlaylistItemsTableReferences
    extends BaseReferences<_$AppDatabase, $PlaylistItemsTable, PlaylistItem> {
  $$PlaylistItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlaylistsTable _playlistIdTable(_$AppDatabase db) =>
      db.playlists.createAlias(
        $_aliasNameGenerator(db.playlistItems.playlistId, db.playlists.id),
      );

  $$PlaylistsTableProcessedTableManager get playlistId {
    final $_column = $_itemColumn<int>('playlist_id')!;

    final manager = $$PlaylistsTableTableManager(
      $_db,
      $_db.playlists,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playlistIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PlaylistItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PlaylistItemsTable> {
  $$PlaylistItemsTableFilterComposer({
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

  ColumnFilters<String> get trackId => $composableBuilder(
    column: $table.trackId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackTitle => $composableBuilder(
    column: $table.trackTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackArtist => $composableBuilder(
    column: $table.trackArtist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackThumbnailPath => $composableBuilder(
    column: $table.trackThumbnailPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trackDurationSeconds => $composableBuilder(
    column: $table.trackDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DateTime, DateTime, PgDateTime> get addedAt =>
      $composableBuilder(
        column: $table.addedAt,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  $$PlaylistsTableFilterComposer get playlistId {
    final $$PlaylistsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playlistId,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableFilterComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaylistItemsTable> {
  $$PlaylistItemsTableOrderingComposer({
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

  ColumnOrderings<String> get trackId => $composableBuilder(
    column: $table.trackId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackTitle => $composableBuilder(
    column: $table.trackTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackArtist => $composableBuilder(
    column: $table.trackArtist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackThumbnailPath => $composableBuilder(
    column: $table.trackThumbnailPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trackDurationSeconds => $composableBuilder(
    column: $table.trackDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlaylistsTableOrderingComposer get playlistId {
    final $$PlaylistsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playlistId,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableOrderingComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaylistItemsTable> {
  $$PlaylistItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get trackId =>
      $composableBuilder(column: $table.trackId, builder: (column) => column);

  GeneratedColumn<String> get trackTitle => $composableBuilder(
    column: $table.trackTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get trackArtist => $composableBuilder(
    column: $table.trackArtist,
    builder: (column) => column,
  );

  GeneratedColumn<String> get trackThumbnailPath => $composableBuilder(
    column: $table.trackThumbnailPath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get trackDurationSeconds => $composableBuilder(
    column: $table.trackDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<DateTime, PgDateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);

  $$PlaylistsTableAnnotationComposer get playlistId {
    final $$PlaylistsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playlistId,
      referencedTable: $db.playlists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaylistsTableAnnotationComposer(
            $db: $db,
            $table: $db.playlists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaylistItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlaylistItemsTable,
          PlaylistItem,
          $$PlaylistItemsTableFilterComposer,
          $$PlaylistItemsTableOrderingComposer,
          $$PlaylistItemsTableAnnotationComposer,
          $$PlaylistItemsTableCreateCompanionBuilder,
          $$PlaylistItemsTableUpdateCompanionBuilder,
          (PlaylistItem, $$PlaylistItemsTableReferences),
          PlaylistItem,
          PrefetchHooks Function({bool playlistId})
        > {
  $$PlaylistItemsTableTableManager(_$AppDatabase db, $PlaylistItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PlaylistItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$PlaylistItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$PlaylistItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> playlistId = const Value.absent(),
                Value<String> trackId = const Value.absent(),
                Value<String> trackTitle = const Value.absent(),
                Value<String> trackArtist = const Value.absent(),
                Value<String?> trackThumbnailPath = const Value.absent(),
                Value<int?> trackDurationSeconds = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
              }) => PlaylistItemsCompanion(
                id: id,
                playlistId: playlistId,
                trackId: trackId,
                trackTitle: trackTitle,
                trackArtist: trackArtist,
                trackThumbnailPath: trackThumbnailPath,
                trackDurationSeconds: trackDurationSeconds,
                addedAt: addedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int playlistId,
                required String trackId,
                required String trackTitle,
                required String trackArtist,
                Value<String?> trackThumbnailPath = const Value.absent(),
                Value<int?> trackDurationSeconds = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
              }) => PlaylistItemsCompanion.insert(
                id: id,
                playlistId: playlistId,
                trackId: trackId,
                trackTitle: trackTitle,
                trackArtist: trackArtist,
                trackThumbnailPath: trackThumbnailPath,
                trackDurationSeconds: trackDurationSeconds,
                addedAt: addedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$PlaylistItemsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({playlistId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (playlistId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.playlistId,
                            referencedTable: $$PlaylistItemsTableReferences
                                ._playlistIdTable(db),
                            referencedColumn:
                                $$PlaylistItemsTableReferences
                                    ._playlistIdTable(db)
                                    .id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PlaylistItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlaylistItemsTable,
      PlaylistItem,
      $$PlaylistItemsTableFilterComposer,
      $$PlaylistItemsTableOrderingComposer,
      $$PlaylistItemsTableAnnotationComposer,
      $$PlaylistItemsTableCreateCompanionBuilder,
      $$PlaylistItemsTableUpdateCompanionBuilder,
      (PlaylistItem, $$PlaylistItemsTableReferences),
      PlaylistItem,
      PrefetchHooks Function({bool playlistId})
    >;
typedef $$LikedSongsTableCreateCompanionBuilder =
    LikedSongsCompanion Function({
      Value<int> id,
      required int userId,
      required String trackId,
      required String trackTitle,
      required String trackArtist,
      Value<String?> trackThumbnailPath,
      Value<int?> trackDurationSeconds,
      Value<DateTime> likedAt,
    });
typedef $$LikedSongsTableUpdateCompanionBuilder =
    LikedSongsCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<String> trackId,
      Value<String> trackTitle,
      Value<String> trackArtist,
      Value<String?> trackThumbnailPath,
      Value<int?> trackDurationSeconds,
      Value<DateTime> likedAt,
    });

final class $$LikedSongsTableReferences
    extends BaseReferences<_$AppDatabase, $LikedSongsTable, LikedSong> {
  $$LikedSongsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.likedSongs.userId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LikedSongsTableFilterComposer
    extends Composer<_$AppDatabase, $LikedSongsTable> {
  $$LikedSongsTableFilterComposer({
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

  ColumnFilters<String> get trackId => $composableBuilder(
    column: $table.trackId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackTitle => $composableBuilder(
    column: $table.trackTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackArtist => $composableBuilder(
    column: $table.trackArtist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackThumbnailPath => $composableBuilder(
    column: $table.trackThumbnailPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trackDurationSeconds => $composableBuilder(
    column: $table.trackDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DateTime, DateTime, PgDateTime> get likedAt =>
      $composableBuilder(
        column: $table.likedAt,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LikedSongsTableOrderingComposer
    extends Composer<_$AppDatabase, $LikedSongsTable> {
  $$LikedSongsTableOrderingComposer({
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

  ColumnOrderings<String> get trackId => $composableBuilder(
    column: $table.trackId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackTitle => $composableBuilder(
    column: $table.trackTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackArtist => $composableBuilder(
    column: $table.trackArtist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackThumbnailPath => $composableBuilder(
    column: $table.trackThumbnailPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trackDurationSeconds => $composableBuilder(
    column: $table.trackDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get likedAt => $composableBuilder(
    column: $table.likedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LikedSongsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LikedSongsTable> {
  $$LikedSongsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get trackId =>
      $composableBuilder(column: $table.trackId, builder: (column) => column);

  GeneratedColumn<String> get trackTitle => $composableBuilder(
    column: $table.trackTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get trackArtist => $composableBuilder(
    column: $table.trackArtist,
    builder: (column) => column,
  );

  GeneratedColumn<String> get trackThumbnailPath => $composableBuilder(
    column: $table.trackThumbnailPath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get trackDurationSeconds => $composableBuilder(
    column: $table.trackDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<DateTime, PgDateTime> get likedAt =>
      $composableBuilder(column: $table.likedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LikedSongsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LikedSongsTable,
          LikedSong,
          $$LikedSongsTableFilterComposer,
          $$LikedSongsTableOrderingComposer,
          $$LikedSongsTableAnnotationComposer,
          $$LikedSongsTableCreateCompanionBuilder,
          $$LikedSongsTableUpdateCompanionBuilder,
          (LikedSong, $$LikedSongsTableReferences),
          LikedSong,
          PrefetchHooks Function({bool userId})
        > {
  $$LikedSongsTableTableManager(_$AppDatabase db, $LikedSongsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LikedSongsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LikedSongsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$LikedSongsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> trackId = const Value.absent(),
                Value<String> trackTitle = const Value.absent(),
                Value<String> trackArtist = const Value.absent(),
                Value<String?> trackThumbnailPath = const Value.absent(),
                Value<int?> trackDurationSeconds = const Value.absent(),
                Value<DateTime> likedAt = const Value.absent(),
              }) => LikedSongsCompanion(
                id: id,
                userId: userId,
                trackId: trackId,
                trackTitle: trackTitle,
                trackArtist: trackArtist,
                trackThumbnailPath: trackThumbnailPath,
                trackDurationSeconds: trackDurationSeconds,
                likedAt: likedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required String trackId,
                required String trackTitle,
                required String trackArtist,
                Value<String?> trackThumbnailPath = const Value.absent(),
                Value<int?> trackDurationSeconds = const Value.absent(),
                Value<DateTime> likedAt = const Value.absent(),
              }) => LikedSongsCompanion.insert(
                id: id,
                userId: userId,
                trackId: trackId,
                trackTitle: trackTitle,
                trackArtist: trackArtist,
                trackThumbnailPath: trackThumbnailPath,
                trackDurationSeconds: trackDurationSeconds,
                likedAt: likedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$LikedSongsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (userId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.userId,
                            referencedTable: $$LikedSongsTableReferences
                                ._userIdTable(db),
                            referencedColumn:
                                $$LikedSongsTableReferences._userIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LikedSongsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LikedSongsTable,
      LikedSong,
      $$LikedSongsTableFilterComposer,
      $$LikedSongsTableOrderingComposer,
      $$LikedSongsTableAnnotationComposer,
      $$LikedSongsTableCreateCompanionBuilder,
      $$LikedSongsTableUpdateCompanionBuilder,
      (LikedSong, $$LikedSongsTableReferences),
      LikedSong,
      PrefetchHooks Function({bool userId})
    >;
typedef $$HistoryTableCreateCompanionBuilder =
    HistoryCompanion Function({
      Value<int> id,
      required int userId,
      required String trackId,
      required String trackTitle,
      required String trackArtist,
      Value<String?> trackThumbnailPath,
      Value<int?> trackDurationSeconds,
      Value<DateTime> playedAt,
    });
typedef $$HistoryTableUpdateCompanionBuilder =
    HistoryCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<String> trackId,
      Value<String> trackTitle,
      Value<String> trackArtist,
      Value<String?> trackThumbnailPath,
      Value<int?> trackDurationSeconds,
      Value<DateTime> playedAt,
    });

final class $$HistoryTableReferences
    extends BaseReferences<_$AppDatabase, $HistoryTable, HistoryEntry> {
  $$HistoryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
    $_aliasNameGenerator(db.history.userId, db.users.id),
  );

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HistoryTableFilterComposer
    extends Composer<_$AppDatabase, $HistoryTable> {
  $$HistoryTableFilterComposer({
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

  ColumnFilters<String> get trackId => $composableBuilder(
    column: $table.trackId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackTitle => $composableBuilder(
    column: $table.trackTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackArtist => $composableBuilder(
    column: $table.trackArtist,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackThumbnailPath => $composableBuilder(
    column: $table.trackThumbnailPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get trackDurationSeconds => $composableBuilder(
    column: $table.trackDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DateTime, DateTime, PgDateTime> get playedAt =>
      $composableBuilder(
        column: $table.playedAt,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $HistoryTable> {
  $$HistoryTableOrderingComposer({
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

  ColumnOrderings<String> get trackId => $composableBuilder(
    column: $table.trackId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackTitle => $composableBuilder(
    column: $table.trackTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackArtist => $composableBuilder(
    column: $table.trackArtist,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackThumbnailPath => $composableBuilder(
    column: $table.trackThumbnailPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get trackDurationSeconds => $composableBuilder(
    column: $table.trackDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get playedAt => $composableBuilder(
    column: $table.playedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistoryTable> {
  $$HistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get trackId =>
      $composableBuilder(column: $table.trackId, builder: (column) => column);

  GeneratedColumn<String> get trackTitle => $composableBuilder(
    column: $table.trackTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get trackArtist => $composableBuilder(
    column: $table.trackArtist,
    builder: (column) => column,
  );

  GeneratedColumn<String> get trackThumbnailPath => $composableBuilder(
    column: $table.trackThumbnailPath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get trackDurationSeconds => $composableBuilder(
    column: $table.trackDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<DateTime, PgDateTime> get playedAt =>
      $composableBuilder(column: $table.playedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HistoryTable,
          HistoryEntry,
          $$HistoryTableFilterComposer,
          $$HistoryTableOrderingComposer,
          $$HistoryTableAnnotationComposer,
          $$HistoryTableCreateCompanionBuilder,
          $$HistoryTableUpdateCompanionBuilder,
          (HistoryEntry, $$HistoryTableReferences),
          HistoryEntry,
          PrefetchHooks Function({bool userId})
        > {
  $$HistoryTableTableManager(_$AppDatabase db, $HistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$HistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$HistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$HistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> trackId = const Value.absent(),
                Value<String> trackTitle = const Value.absent(),
                Value<String> trackArtist = const Value.absent(),
                Value<String?> trackThumbnailPath = const Value.absent(),
                Value<int?> trackDurationSeconds = const Value.absent(),
                Value<DateTime> playedAt = const Value.absent(),
              }) => HistoryCompanion(
                id: id,
                userId: userId,
                trackId: trackId,
                trackTitle: trackTitle,
                trackArtist: trackArtist,
                trackThumbnailPath: trackThumbnailPath,
                trackDurationSeconds: trackDurationSeconds,
                playedAt: playedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required String trackId,
                required String trackTitle,
                required String trackArtist,
                Value<String?> trackThumbnailPath = const Value.absent(),
                Value<int?> trackDurationSeconds = const Value.absent(),
                Value<DateTime> playedAt = const Value.absent(),
              }) => HistoryCompanion.insert(
                id: id,
                userId: userId,
                trackId: trackId,
                trackTitle: trackTitle,
                trackArtist: trackArtist,
                trackThumbnailPath: trackThumbnailPath,
                trackDurationSeconds: trackDurationSeconds,
                playedAt: playedAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$HistoryTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (userId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.userId,
                            referencedTable: $$HistoryTableReferences
                                ._userIdTable(db),
                            referencedColumn:
                                $$HistoryTableReferences._userIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HistoryTable,
      HistoryEntry,
      $$HistoryTableFilterComposer,
      $$HistoryTableOrderingComposer,
      $$HistoryTableAnnotationComposer,
      $$HistoryTableCreateCompanionBuilder,
      $$HistoryTableUpdateCompanionBuilder,
      (HistoryEntry, $$HistoryTableReferences),
      HistoryEntry,
      PrefetchHooks Function({bool userId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$PlaylistsTableTableManager get playlists =>
      $$PlaylistsTableTableManager(_db, _db.playlists);
  $$PlaylistItemsTableTableManager get playlistItems =>
      $$PlaylistItemsTableTableManager(_db, _db.playlistItems);
  $$LikedSongsTableTableManager get likedSongs =>
      $$LikedSongsTableTableManager(_db, _db.likedSongs);
  $$HistoryTableTableManager get history =>
      $$HistoryTableTableManager(_db, _db.history);
}
