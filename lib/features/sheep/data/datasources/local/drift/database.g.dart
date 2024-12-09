// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SheepTableTable extends SheepTable
    with TableInfo<$SheepTableTable, SheepTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SheepTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isWhatsAppNumberMeta =
      const VerificationMeta('isWhatsAppNumber');
  @override
  late final GeneratedColumn<bool> isWhatsAppNumber = GeneratedColumn<bool>(
      'is_whats_app_number', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_whats_app_number" IN (0, 1))'));
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<String> age = GeneratedColumn<String>(
      'age', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _providerNameMeta =
      const VerificationMeta('providerName');
  @override
  late final GeneratedColumn<String> providerName = GeneratedColumn<String>(
      'provider_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _providerPhoneMeta =
      const VerificationMeta('providerPhone');
  @override
  late final GeneratedColumn<String> providerPhone = GeneratedColumn<String>(
      'provider_phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _relationWithProviderMeta =
      const VerificationMeta('relationWithProvider');
  @override
  late final GeneratedColumn<String> relationWithProvider =
      GeneratedColumn<String>('relation_with_provider', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _finderNameMeta =
      const VerificationMeta('finderName');
  @override
  late final GeneratedColumn<String> finderName = GeneratedColumn<String>(
      'finder_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _finderPhoneMeta =
      const VerificationMeta('finderPhone');
  @override
  late final GeneratedColumn<String> finderPhone = GeneratedColumn<String>(
      'finder_phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stageMeta = const VerificationMeta('stage');
  @override
  late final GeneratedColumn<String> stage = GeneratedColumn<String>(
      'stage', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _surveyStatusMeta =
      const VerificationMeta('surveyStatus');
  @override
  late final GeneratedColumn<String> surveyStatus = GeneratedColumn<String>(
      'survey_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _totalSessionsMeta =
      const VerificationMeta('totalSessions');
  @override
  late final GeneratedColumn<int> totalSessions = GeneratedColumn<int>(
      'total_sessions', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sessionsDoneMeta =
      const VerificationMeta('sessionsDone');
  @override
  late final GeneratedColumn<int> sessionsDone = GeneratedColumn<int>(
      'sessions_done', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _wateringSessionsDoneMeta =
      const VerificationMeta('wateringSessionsDone');
  @override
  late final GeneratedColumn<int> wateringSessionsDone = GeneratedColumn<int>(
      'watering_sessions_done', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _abandonReasonMeta =
      const VerificationMeta('abandonReason');
  @override
  late final GeneratedColumn<String> abandonReason = GeneratedColumn<String>(
      'abandon_reason', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _abandonDetailsMeta =
      const VerificationMeta('abandonDetails');
  @override
  late final GeneratedColumn<String> abandonDetails = GeneratedColumn<String>(
      'abandon_details', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        phoneNumber,
        isWhatsAppNumber,
        age,
        address,
        providerName,
        providerPhone,
        relationWithProvider,
        finderName,
        finderPhone,
        createdAt,
        status,
        stage,
        surveyStatus,
        totalSessions,
        sessionsDone,
        wateringSessionsDone,
        abandonReason,
        abandonDetails
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sheep_table';
  @override
  VerificationContext validateIntegrity(Insertable<SheepTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('is_whats_app_number')) {
      context.handle(
          _isWhatsAppNumberMeta,
          isWhatsAppNumber.isAcceptableOrUnknown(
              data['is_whats_app_number']!, _isWhatsAppNumberMeta));
    } else if (isInserting) {
      context.missing(_isWhatsAppNumberMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('provider_name')) {
      context.handle(
          _providerNameMeta,
          providerName.isAcceptableOrUnknown(
              data['provider_name']!, _providerNameMeta));
    } else if (isInserting) {
      context.missing(_providerNameMeta);
    }
    if (data.containsKey('provider_phone')) {
      context.handle(
          _providerPhoneMeta,
          providerPhone.isAcceptableOrUnknown(
              data['provider_phone']!, _providerPhoneMeta));
    } else if (isInserting) {
      context.missing(_providerPhoneMeta);
    }
    if (data.containsKey('relation_with_provider')) {
      context.handle(
          _relationWithProviderMeta,
          relationWithProvider.isAcceptableOrUnknown(
              data['relation_with_provider']!, _relationWithProviderMeta));
    } else if (isInserting) {
      context.missing(_relationWithProviderMeta);
    }
    if (data.containsKey('finder_name')) {
      context.handle(
          _finderNameMeta,
          finderName.isAcceptableOrUnknown(
              data['finder_name']!, _finderNameMeta));
    } else if (isInserting) {
      context.missing(_finderNameMeta);
    }
    if (data.containsKey('finder_phone')) {
      context.handle(
          _finderPhoneMeta,
          finderPhone.isAcceptableOrUnknown(
              data['finder_phone']!, _finderPhoneMeta));
    } else if (isInserting) {
      context.missing(_finderPhoneMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('stage')) {
      context.handle(
          _stageMeta, stage.isAcceptableOrUnknown(data['stage']!, _stageMeta));
    } else if (isInserting) {
      context.missing(_stageMeta);
    }
    if (data.containsKey('survey_status')) {
      context.handle(
          _surveyStatusMeta,
          surveyStatus.isAcceptableOrUnknown(
              data['survey_status']!, _surveyStatusMeta));
    } else if (isInserting) {
      context.missing(_surveyStatusMeta);
    }
    if (data.containsKey('total_sessions')) {
      context.handle(
          _totalSessionsMeta,
          totalSessions.isAcceptableOrUnknown(
              data['total_sessions']!, _totalSessionsMeta));
    } else if (isInserting) {
      context.missing(_totalSessionsMeta);
    }
    if (data.containsKey('sessions_done')) {
      context.handle(
          _sessionsDoneMeta,
          sessionsDone.isAcceptableOrUnknown(
              data['sessions_done']!, _sessionsDoneMeta));
    } else if (isInserting) {
      context.missing(_sessionsDoneMeta);
    }
    if (data.containsKey('watering_sessions_done')) {
      context.handle(
          _wateringSessionsDoneMeta,
          wateringSessionsDone.isAcceptableOrUnknown(
              data['watering_sessions_done']!, _wateringSessionsDoneMeta));
    } else if (isInserting) {
      context.missing(_wateringSessionsDoneMeta);
    }
    if (data.containsKey('abandon_reason')) {
      context.handle(
          _abandonReasonMeta,
          abandonReason.isAcceptableOrUnknown(
              data['abandon_reason']!, _abandonReasonMeta));
    }
    if (data.containsKey('abandon_details')) {
      context.handle(
          _abandonDetailsMeta,
          abandonDetails.isAcceptableOrUnknown(
              data['abandon_details']!, _abandonDetailsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {name, phoneNumber},
      ];
  @override
  SheepTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SheepTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number'])!,
      isWhatsAppNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_whats_app_number'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}age'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      providerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}provider_name'])!,
      providerPhone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}provider_phone'])!,
      relationWithProvider: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}relation_with_provider'])!,
      finderName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}finder_name'])!,
      finderPhone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}finder_phone'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      stage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stage'])!,
      surveyStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}survey_status'])!,
      totalSessions: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_sessions'])!,
      sessionsDone: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sessions_done'])!,
      wateringSessionsDone: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}watering_sessions_done'])!,
      abandonReason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}abandon_reason']),
      abandonDetails: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}abandon_details']),
    );
  }

  @override
  $SheepTableTable createAlias(String alias) {
    return $SheepTableTable(attachedDatabase, alias);
  }
}

class SheepTableData extends DataClass implements Insertable<SheepTableData> {
  final int id;
  final String name;
  final String phoneNumber;
  final bool isWhatsAppNumber;
  final String age;
  final String address;
  final String providerName;
  final String providerPhone;
  final String relationWithProvider;
  final String finderName;
  final String finderPhone;
  final DateTime createdAt;
  final String status;
  final String stage;
  final String surveyStatus;
  final int totalSessions;
  final int sessionsDone;
  final int wateringSessionsDone;
  final String? abandonReason;
  final String? abandonDetails;
  const SheepTableData(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.isWhatsAppNumber,
      required this.age,
      required this.address,
      required this.providerName,
      required this.providerPhone,
      required this.relationWithProvider,
      required this.finderName,
      required this.finderPhone,
      required this.createdAt,
      required this.status,
      required this.stage,
      required this.surveyStatus,
      required this.totalSessions,
      required this.sessionsDone,
      required this.wateringSessionsDone,
      this.abandonReason,
      this.abandonDetails});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['is_whats_app_number'] = Variable<bool>(isWhatsAppNumber);
    map['age'] = Variable<String>(age);
    map['address'] = Variable<String>(address);
    map['provider_name'] = Variable<String>(providerName);
    map['provider_phone'] = Variable<String>(providerPhone);
    map['relation_with_provider'] = Variable<String>(relationWithProvider);
    map['finder_name'] = Variable<String>(finderName);
    map['finder_phone'] = Variable<String>(finderPhone);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['status'] = Variable<String>(status);
    map['stage'] = Variable<String>(stage);
    map['survey_status'] = Variable<String>(surveyStatus);
    map['total_sessions'] = Variable<int>(totalSessions);
    map['sessions_done'] = Variable<int>(sessionsDone);
    map['watering_sessions_done'] = Variable<int>(wateringSessionsDone);
    if (!nullToAbsent || abandonReason != null) {
      map['abandon_reason'] = Variable<String>(abandonReason);
    }
    if (!nullToAbsent || abandonDetails != null) {
      map['abandon_details'] = Variable<String>(abandonDetails);
    }
    return map;
  }

  SheepTableCompanion toCompanion(bool nullToAbsent) {
    return SheepTableCompanion(
      id: Value(id),
      name: Value(name),
      phoneNumber: Value(phoneNumber),
      isWhatsAppNumber: Value(isWhatsAppNumber),
      age: Value(age),
      address: Value(address),
      providerName: Value(providerName),
      providerPhone: Value(providerPhone),
      relationWithProvider: Value(relationWithProvider),
      finderName: Value(finderName),
      finderPhone: Value(finderPhone),
      createdAt: Value(createdAt),
      status: Value(status),
      stage: Value(stage),
      surveyStatus: Value(surveyStatus),
      totalSessions: Value(totalSessions),
      sessionsDone: Value(sessionsDone),
      wateringSessionsDone: Value(wateringSessionsDone),
      abandonReason: abandonReason == null && nullToAbsent
          ? const Value.absent()
          : Value(abandonReason),
      abandonDetails: abandonDetails == null && nullToAbsent
          ? const Value.absent()
          : Value(abandonDetails),
    );
  }

  factory SheepTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SheepTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      isWhatsAppNumber: serializer.fromJson<bool>(json['isWhatsAppNumber']),
      age: serializer.fromJson<String>(json['age']),
      address: serializer.fromJson<String>(json['address']),
      providerName: serializer.fromJson<String>(json['providerName']),
      providerPhone: serializer.fromJson<String>(json['providerPhone']),
      relationWithProvider:
          serializer.fromJson<String>(json['relationWithProvider']),
      finderName: serializer.fromJson<String>(json['finderName']),
      finderPhone: serializer.fromJson<String>(json['finderPhone']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      status: serializer.fromJson<String>(json['status']),
      stage: serializer.fromJson<String>(json['stage']),
      surveyStatus: serializer.fromJson<String>(json['surveyStatus']),
      totalSessions: serializer.fromJson<int>(json['totalSessions']),
      sessionsDone: serializer.fromJson<int>(json['sessionsDone']),
      wateringSessionsDone:
          serializer.fromJson<int>(json['wateringSessionsDone']),
      abandonReason: serializer.fromJson<String?>(json['abandonReason']),
      abandonDetails: serializer.fromJson<String?>(json['abandonDetails']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'isWhatsAppNumber': serializer.toJson<bool>(isWhatsAppNumber),
      'age': serializer.toJson<String>(age),
      'address': serializer.toJson<String>(address),
      'providerName': serializer.toJson<String>(providerName),
      'providerPhone': serializer.toJson<String>(providerPhone),
      'relationWithProvider': serializer.toJson<String>(relationWithProvider),
      'finderName': serializer.toJson<String>(finderName),
      'finderPhone': serializer.toJson<String>(finderPhone),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'status': serializer.toJson<String>(status),
      'stage': serializer.toJson<String>(stage),
      'surveyStatus': serializer.toJson<String>(surveyStatus),
      'totalSessions': serializer.toJson<int>(totalSessions),
      'sessionsDone': serializer.toJson<int>(sessionsDone),
      'wateringSessionsDone': serializer.toJson<int>(wateringSessionsDone),
      'abandonReason': serializer.toJson<String?>(abandonReason),
      'abandonDetails': serializer.toJson<String?>(abandonDetails),
    };
  }

  SheepTableData copyWith(
          {int? id,
          String? name,
          String? phoneNumber,
          bool? isWhatsAppNumber,
          String? age,
          String? address,
          String? providerName,
          String? providerPhone,
          String? relationWithProvider,
          String? finderName,
          String? finderPhone,
          DateTime? createdAt,
          String? status,
          String? stage,
          String? surveyStatus,
          int? totalSessions,
          int? sessionsDone,
          int? wateringSessionsDone,
          Value<String?> abandonReason = const Value.absent(),
          Value<String?> abandonDetails = const Value.absent()}) =>
      SheepTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        isWhatsAppNumber: isWhatsAppNumber ?? this.isWhatsAppNumber,
        age: age ?? this.age,
        address: address ?? this.address,
        providerName: providerName ?? this.providerName,
        providerPhone: providerPhone ?? this.providerPhone,
        relationWithProvider: relationWithProvider ?? this.relationWithProvider,
        finderName: finderName ?? this.finderName,
        finderPhone: finderPhone ?? this.finderPhone,
        createdAt: createdAt ?? this.createdAt,
        status: status ?? this.status,
        stage: stage ?? this.stage,
        surveyStatus: surveyStatus ?? this.surveyStatus,
        totalSessions: totalSessions ?? this.totalSessions,
        sessionsDone: sessionsDone ?? this.sessionsDone,
        wateringSessionsDone: wateringSessionsDone ?? this.wateringSessionsDone,
        abandonReason:
            abandonReason.present ? abandonReason.value : this.abandonReason,
        abandonDetails:
            abandonDetails.present ? abandonDetails.value : this.abandonDetails,
      );
  SheepTableData copyWithCompanion(SheepTableCompanion data) {
    return SheepTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      isWhatsAppNumber: data.isWhatsAppNumber.present
          ? data.isWhatsAppNumber.value
          : this.isWhatsAppNumber,
      age: data.age.present ? data.age.value : this.age,
      address: data.address.present ? data.address.value : this.address,
      providerName: data.providerName.present
          ? data.providerName.value
          : this.providerName,
      providerPhone: data.providerPhone.present
          ? data.providerPhone.value
          : this.providerPhone,
      relationWithProvider: data.relationWithProvider.present
          ? data.relationWithProvider.value
          : this.relationWithProvider,
      finderName:
          data.finderName.present ? data.finderName.value : this.finderName,
      finderPhone:
          data.finderPhone.present ? data.finderPhone.value : this.finderPhone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      status: data.status.present ? data.status.value : this.status,
      stage: data.stage.present ? data.stage.value : this.stage,
      surveyStatus: data.surveyStatus.present
          ? data.surveyStatus.value
          : this.surveyStatus,
      totalSessions: data.totalSessions.present
          ? data.totalSessions.value
          : this.totalSessions,
      sessionsDone: data.sessionsDone.present
          ? data.sessionsDone.value
          : this.sessionsDone,
      wateringSessionsDone: data.wateringSessionsDone.present
          ? data.wateringSessionsDone.value
          : this.wateringSessionsDone,
      abandonReason: data.abandonReason.present
          ? data.abandonReason.value
          : this.abandonReason,
      abandonDetails: data.abandonDetails.present
          ? data.abandonDetails.value
          : this.abandonDetails,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SheepTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('isWhatsAppNumber: $isWhatsAppNumber, ')
          ..write('age: $age, ')
          ..write('address: $address, ')
          ..write('providerName: $providerName, ')
          ..write('providerPhone: $providerPhone, ')
          ..write('relationWithProvider: $relationWithProvider, ')
          ..write('finderName: $finderName, ')
          ..write('finderPhone: $finderPhone, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('stage: $stage, ')
          ..write('surveyStatus: $surveyStatus, ')
          ..write('totalSessions: $totalSessions, ')
          ..write('sessionsDone: $sessionsDone, ')
          ..write('wateringSessionsDone: $wateringSessionsDone, ')
          ..write('abandonReason: $abandonReason, ')
          ..write('abandonDetails: $abandonDetails')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      phoneNumber,
      isWhatsAppNumber,
      age,
      address,
      providerName,
      providerPhone,
      relationWithProvider,
      finderName,
      finderPhone,
      createdAt,
      status,
      stage,
      surveyStatus,
      totalSessions,
      sessionsDone,
      wateringSessionsDone,
      abandonReason,
      abandonDetails);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SheepTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.phoneNumber == this.phoneNumber &&
          other.isWhatsAppNumber == this.isWhatsAppNumber &&
          other.age == this.age &&
          other.address == this.address &&
          other.providerName == this.providerName &&
          other.providerPhone == this.providerPhone &&
          other.relationWithProvider == this.relationWithProvider &&
          other.finderName == this.finderName &&
          other.finderPhone == this.finderPhone &&
          other.createdAt == this.createdAt &&
          other.status == this.status &&
          other.stage == this.stage &&
          other.surveyStatus == this.surveyStatus &&
          other.totalSessions == this.totalSessions &&
          other.sessionsDone == this.sessionsDone &&
          other.wateringSessionsDone == this.wateringSessionsDone &&
          other.abandonReason == this.abandonReason &&
          other.abandonDetails == this.abandonDetails);
}

class SheepTableCompanion extends UpdateCompanion<SheepTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> phoneNumber;
  final Value<bool> isWhatsAppNumber;
  final Value<String> age;
  final Value<String> address;
  final Value<String> providerName;
  final Value<String> providerPhone;
  final Value<String> relationWithProvider;
  final Value<String> finderName;
  final Value<String> finderPhone;
  final Value<DateTime> createdAt;
  final Value<String> status;
  final Value<String> stage;
  final Value<String> surveyStatus;
  final Value<int> totalSessions;
  final Value<int> sessionsDone;
  final Value<int> wateringSessionsDone;
  final Value<String?> abandonReason;
  final Value<String?> abandonDetails;
  const SheepTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.isWhatsAppNumber = const Value.absent(),
    this.age = const Value.absent(),
    this.address = const Value.absent(),
    this.providerName = const Value.absent(),
    this.providerPhone = const Value.absent(),
    this.relationWithProvider = const Value.absent(),
    this.finderName = const Value.absent(),
    this.finderPhone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.status = const Value.absent(),
    this.stage = const Value.absent(),
    this.surveyStatus = const Value.absent(),
    this.totalSessions = const Value.absent(),
    this.sessionsDone = const Value.absent(),
    this.wateringSessionsDone = const Value.absent(),
    this.abandonReason = const Value.absent(),
    this.abandonDetails = const Value.absent(),
  });
  SheepTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String phoneNumber,
    required bool isWhatsAppNumber,
    required String age,
    required String address,
    required String providerName,
    required String providerPhone,
    required String relationWithProvider,
    required String finderName,
    required String finderPhone,
    required DateTime createdAt,
    required String status,
    required String stage,
    required String surveyStatus,
    required int totalSessions,
    required int sessionsDone,
    required int wateringSessionsDone,
    this.abandonReason = const Value.absent(),
    this.abandonDetails = const Value.absent(),
  })  : name = Value(name),
        phoneNumber = Value(phoneNumber),
        isWhatsAppNumber = Value(isWhatsAppNumber),
        age = Value(age),
        address = Value(address),
        providerName = Value(providerName),
        providerPhone = Value(providerPhone),
        relationWithProvider = Value(relationWithProvider),
        finderName = Value(finderName),
        finderPhone = Value(finderPhone),
        createdAt = Value(createdAt),
        status = Value(status),
        stage = Value(stage),
        surveyStatus = Value(surveyStatus),
        totalSessions = Value(totalSessions),
        sessionsDone = Value(sessionsDone),
        wateringSessionsDone = Value(wateringSessionsDone);
  static Insertable<SheepTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phoneNumber,
    Expression<bool>? isWhatsAppNumber,
    Expression<int>? age,
    Expression<String>? address,
    Expression<String>? providerName,
    Expression<String>? providerPhone,
    Expression<String>? relationWithProvider,
    Expression<String>? finderName,
    Expression<String>? finderPhone,
    Expression<DateTime>? createdAt,
    Expression<String>? status,
    Expression<String>? stage,
    Expression<String>? surveyStatus,
    Expression<int>? totalSessions,
    Expression<int>? sessionsDone,
    Expression<int>? wateringSessionsDone,
    Expression<String>? abandonReason,
    Expression<String>? abandonDetails,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (isWhatsAppNumber != null) 'is_whats_app_number': isWhatsAppNumber,
      if (age != null) 'age': age,
      if (address != null) 'address': address,
      if (providerName != null) 'provider_name': providerName,
      if (providerPhone != null) 'provider_phone': providerPhone,
      if (relationWithProvider != null)
        'relation_with_provider': relationWithProvider,
      if (finderName != null) 'finder_name': finderName,
      if (finderPhone != null) 'finder_phone': finderPhone,
      if (createdAt != null) 'created_at': createdAt,
      if (status != null) 'status': status,
      if (stage != null) 'stage': stage,
      if (surveyStatus != null) 'survey_status': surveyStatus,
      if (totalSessions != null) 'total_sessions': totalSessions,
      if (sessionsDone != null) 'sessions_done': sessionsDone,
      if (wateringSessionsDone != null)
        'watering_sessions_done': wateringSessionsDone,
      if (abandonReason != null) 'abandon_reason': abandonReason,
      if (abandonDetails != null) 'abandon_details': abandonDetails,
    });
  }

  SheepTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? phoneNumber,
      Value<bool>? isWhatsAppNumber,
      Value<String>? age,
      Value<String>? address,
      Value<String>? providerName,
      Value<String>? providerPhone,
      Value<String>? relationWithProvider,
      Value<String>? finderName,
      Value<String>? finderPhone,
      Value<DateTime>? createdAt,
      Value<String>? status,
      Value<String>? stage,
      Value<String>? surveyStatus,
      Value<int>? totalSessions,
      Value<int>? sessionsDone,
      Value<int>? wateringSessionsDone,
      Value<String?>? abandonReason,
      Value<String?>? abandonDetails}) {
    return SheepTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isWhatsAppNumber: isWhatsAppNumber ?? this.isWhatsAppNumber,
      age: age ?? this.age,
      address: address ?? this.address,
      providerName: providerName ?? this.providerName,
      providerPhone: providerPhone ?? this.providerPhone,
      relationWithProvider: relationWithProvider ?? this.relationWithProvider,
      finderName: finderName ?? this.finderName,
      finderPhone: finderPhone ?? this.finderPhone,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      stage: stage ?? this.stage,
      surveyStatus: surveyStatus ?? this.surveyStatus,
      totalSessions: totalSessions ?? this.totalSessions,
      sessionsDone: sessionsDone ?? this.sessionsDone,
      wateringSessionsDone: wateringSessionsDone ?? this.wateringSessionsDone,
      abandonReason: abandonReason ?? this.abandonReason,
      abandonDetails: abandonDetails ?? this.abandonDetails,
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
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (isWhatsAppNumber.present) {
      map['is_whats_app_number'] = Variable<bool>(isWhatsAppNumber.value);
    }
    if (age.present) {
      map['age'] = Variable<String>(age.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (providerName.present) {
      map['provider_name'] = Variable<String>(providerName.value);
    }
    if (providerPhone.present) {
      map['provider_phone'] = Variable<String>(providerPhone.value);
    }
    if (relationWithProvider.present) {
      map['relation_with_provider'] =
          Variable<String>(relationWithProvider.value);
    }
    if (finderName.present) {
      map['finder_name'] = Variable<String>(finderName.value);
    }
    if (finderPhone.present) {
      map['finder_phone'] = Variable<String>(finderPhone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (stage.present) {
      map['stage'] = Variable<String>(stage.value);
    }
    if (surveyStatus.present) {
      map['survey_status'] = Variable<String>(surveyStatus.value);
    }
    if (totalSessions.present) {
      map['total_sessions'] = Variable<int>(totalSessions.value);
    }
    if (sessionsDone.present) {
      map['sessions_done'] = Variable<int>(sessionsDone.value);
    }
    if (wateringSessionsDone.present) {
      map['watering_sessions_done'] = Variable<int>(wateringSessionsDone.value);
    }
    if (abandonReason.present) {
      map['abandon_reason'] = Variable<String>(abandonReason.value);
    }
    if (abandonDetails.present) {
      map['abandon_details'] = Variable<String>(abandonDetails.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SheepTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('isWhatsAppNumber: $isWhatsAppNumber, ')
          ..write('age: $age, ')
          ..write('address: $address, ')
          ..write('providerName: $providerName, ')
          ..write('providerPhone: $providerPhone, ')
          ..write('relationWithProvider: $relationWithProvider, ')
          ..write('finderName: $finderName, ')
          ..write('finderPhone: $finderPhone, ')
          ..write('createdAt: $createdAt, ')
          ..write('status: $status, ')
          ..write('stage: $stage, ')
          ..write('surveyStatus: $surveyStatus, ')
          ..write('totalSessions: $totalSessions, ')
          ..write('sessionsDone: $sessionsDone, ')
          ..write('wateringSessionsDone: $wateringSessionsDone, ')
          ..write('abandonReason: $abandonReason, ')
          ..write('abandonDetails: $abandonDetails')
          ..write(')'))
        .toString();
  }
}

class $SessionTableTable extends SessionTable
    with TableInfo<$SessionTableTable, SessionTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sheepIdMeta =
      const VerificationMeta('sheepId');
  @override
  late final GeneratedColumn<int> sheepId = GeneratedColumn<int>(
      'sheep_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _appointmentDateMeta =
      const VerificationMeta('appointmentDate');
  @override
  late final GeneratedColumn<DateTime> appointmentDate =
      GeneratedColumn<DateTime>('appointment_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sessionNumberMeta =
      const VerificationMeta('sessionNumber');
  @override
  late final GeneratedColumn<int> sessionNumber = GeneratedColumn<int>(
      'session_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'));
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sheepId,
        appointmentDate,
        type,
        sessionNumber,
        notes,
        completed,
        completedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_table';
  @override
  VerificationContext validateIntegrity(Insertable<SessionTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sheep_id')) {
      context.handle(_sheepIdMeta,
          sheepId.isAcceptableOrUnknown(data['sheep_id']!, _sheepIdMeta));
    } else if (isInserting) {
      context.missing(_sheepIdMeta);
    }
    if (data.containsKey('appointment_date')) {
      context.handle(
          _appointmentDateMeta,
          appointmentDate.isAcceptableOrUnknown(
              data['appointment_date']!, _appointmentDateMeta));
    } else if (isInserting) {
      context.missing(_appointmentDateMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('session_number')) {
      context.handle(
          _sessionNumberMeta,
          sessionNumber.isAcceptableOrUnknown(
              data['session_number']!, _sessionNumberMeta));
    } else if (isInserting) {
      context.missing(_sessionNumberMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sheepId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sheep_id'])!,
      appointmentDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}appointment_date'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      sessionNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}session_number'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
    );
  }

  @override
  $SessionTableTable createAlias(String alias) {
    return $SessionTableTable(attachedDatabase, alias);
  }
}

class SessionTableData extends DataClass
    implements Insertable<SessionTableData> {
  final int id;
  final int sheepId;
  final DateTime appointmentDate;
  final String type;
  final int sessionNumber;
  final String? notes;
  final bool completed;
  final DateTime? completedAt;
  const SessionTableData(
      {required this.id,
      required this.sheepId,
      required this.appointmentDate,
      required this.type,
      required this.sessionNumber,
      this.notes,
      required this.completed,
      this.completedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sheep_id'] = Variable<int>(sheepId);
    map['appointment_date'] = Variable<DateTime>(appointmentDate);
    map['type'] = Variable<String>(type);
    map['session_number'] = Variable<int>(sessionNumber);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  SessionTableCompanion toCompanion(bool nullToAbsent) {
    return SessionTableCompanion(
      id: Value(id),
      sheepId: Value(sheepId),
      appointmentDate: Value(appointmentDate),
      type: Value(type),
      sessionNumber: Value(sessionNumber),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      completed: Value(completed),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory SessionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionTableData(
      id: serializer.fromJson<int>(json['id']),
      sheepId: serializer.fromJson<int>(json['sheepId']),
      appointmentDate: serializer.fromJson<DateTime>(json['appointmentDate']),
      type: serializer.fromJson<String>(json['type']),
      sessionNumber: serializer.fromJson<int>(json['sessionNumber']),
      notes: serializer.fromJson<String?>(json['notes']),
      completed: serializer.fromJson<bool>(json['completed']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sheepId': serializer.toJson<int>(sheepId),
      'appointmentDate': serializer.toJson<DateTime>(appointmentDate),
      'type': serializer.toJson<String>(type),
      'sessionNumber': serializer.toJson<int>(sessionNumber),
      'notes': serializer.toJson<String?>(notes),
      'completed': serializer.toJson<bool>(completed),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  SessionTableData copyWith(
          {int? id,
          int? sheepId,
          DateTime? appointmentDate,
          String? type,
          int? sessionNumber,
          Value<String?> notes = const Value.absent(),
          bool? completed,
          Value<DateTime?> completedAt = const Value.absent()}) =>
      SessionTableData(
        id: id ?? this.id,
        sheepId: sheepId ?? this.sheepId,
        appointmentDate: appointmentDate ?? this.appointmentDate,
        type: type ?? this.type,
        sessionNumber: sessionNumber ?? this.sessionNumber,
        notes: notes.present ? notes.value : this.notes,
        completed: completed ?? this.completed,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
      );
  SessionTableData copyWithCompanion(SessionTableCompanion data) {
    return SessionTableData(
      id: data.id.present ? data.id.value : this.id,
      sheepId: data.sheepId.present ? data.sheepId.value : this.sheepId,
      appointmentDate: data.appointmentDate.present
          ? data.appointmentDate.value
          : this.appointmentDate,
      type: data.type.present ? data.type.value : this.type,
      sessionNumber: data.sessionNumber.present
          ? data.sessionNumber.value
          : this.sessionNumber,
      notes: data.notes.present ? data.notes.value : this.notes,
      completed: data.completed.present ? data.completed.value : this.completed,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionTableData(')
          ..write('id: $id, ')
          ..write('sheepId: $sheepId, ')
          ..write('appointmentDate: $appointmentDate, ')
          ..write('type: $type, ')
          ..write('sessionNumber: $sessionNumber, ')
          ..write('notes: $notes, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sheepId, appointmentDate, type,
      sessionNumber, notes, completed, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionTableData &&
          other.id == this.id &&
          other.sheepId == this.sheepId &&
          other.appointmentDate == this.appointmentDate &&
          other.type == this.type &&
          other.sessionNumber == this.sessionNumber &&
          other.notes == this.notes &&
          other.completed == this.completed &&
          other.completedAt == this.completedAt);
}

class SessionTableCompanion extends UpdateCompanion<SessionTableData> {
  final Value<int> id;
  final Value<int> sheepId;
  final Value<DateTime> appointmentDate;
  final Value<String> type;
  final Value<int> sessionNumber;
  final Value<String?> notes;
  final Value<bool> completed;
  final Value<DateTime?> completedAt;
  const SessionTableCompanion({
    this.id = const Value.absent(),
    this.sheepId = const Value.absent(),
    this.appointmentDate = const Value.absent(),
    this.type = const Value.absent(),
    this.sessionNumber = const Value.absent(),
    this.notes = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  SessionTableCompanion.insert({
    this.id = const Value.absent(),
    required int sheepId,
    required DateTime appointmentDate,
    required String type,
    required int sessionNumber,
    this.notes = const Value.absent(),
    required bool completed,
    this.completedAt = const Value.absent(),
  })  : sheepId = Value(sheepId),
        appointmentDate = Value(appointmentDate),
        type = Value(type),
        sessionNumber = Value(sessionNumber),
        completed = Value(completed);
  static Insertable<SessionTableData> custom({
    Expression<int>? id,
    Expression<int>? sheepId,
    Expression<DateTime>? appointmentDate,
    Expression<String>? type,
    Expression<int>? sessionNumber,
    Expression<String>? notes,
    Expression<bool>? completed,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sheepId != null) 'sheep_id': sheepId,
      if (appointmentDate != null) 'appointment_date': appointmentDate,
      if (type != null) 'type': type,
      if (sessionNumber != null) 'session_number': sessionNumber,
      if (notes != null) 'notes': notes,
      if (completed != null) 'completed': completed,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  SessionTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? sheepId,
      Value<DateTime>? appointmentDate,
      Value<String>? type,
      Value<int>? sessionNumber,
      Value<String?>? notes,
      Value<bool>? completed,
      Value<DateTime?>? completedAt}) {
    return SessionTableCompanion(
      id: id ?? this.id,
      sheepId: sheepId ?? this.sheepId,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      type: type ?? this.type,
      sessionNumber: sessionNumber ?? this.sessionNumber,
      notes: notes ?? this.notes,
      completed: completed ?? this.completed,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sheepId.present) {
      map['sheep_id'] = Variable<int>(sheepId.value);
    }
    if (appointmentDate.present) {
      map['appointment_date'] = Variable<DateTime>(appointmentDate.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (sessionNumber.present) {
      map['session_number'] = Variable<int>(sessionNumber.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionTableCompanion(')
          ..write('id: $id, ')
          ..write('sheepId: $sheepId, ')
          ..write('appointmentDate: $appointmentDate, ')
          ..write('type: $type, ')
          ..write('sessionNumber: $sessionNumber, ')
          ..write('notes: $notes, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  $MyDatabaseManager get managers => $MyDatabaseManager(this);
  late final $SheepTableTable sheepTable = $SheepTableTable(this);
  late final $SessionTableTable sessionTable = $SessionTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [sheepTable, sessionTable];
}

typedef $$SheepTableTableCreateCompanionBuilder = SheepTableCompanion Function({
  Value<int> id,
  required String name,
  required String phoneNumber,
  required bool isWhatsAppNumber,
  required String age,
  required String address,
  required String providerName,
  required String providerPhone,
  required String relationWithProvider,
  required String finderName,
  required String finderPhone,
  required DateTime createdAt,
  required String status,
  required String stage,
  required String surveyStatus,
  required int totalSessions,
  required int sessionsDone,
  required int wateringSessionsDone,
  Value<String?> abandonReason,
  Value<String?> abandonDetails,
});
typedef $$SheepTableTableUpdateCompanionBuilder = SheepTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> phoneNumber,
  Value<bool> isWhatsAppNumber,
  Value<String> age,
  Value<String> address,
  Value<String> providerName,
  Value<String> providerPhone,
  Value<String> relationWithProvider,
  Value<String> finderName,
  Value<String> finderPhone,
  Value<DateTime> createdAt,
  Value<String> status,
  Value<String> stage,
  Value<String> surveyStatus,
  Value<int> totalSessions,
  Value<int> sessionsDone,
  Value<int> wateringSessionsDone,
  Value<String?> abandonReason,
  Value<String?> abandonDetails,
});

class $$SheepTableTableFilterComposer
    extends Composer<_$MyDatabase, $SheepTableTable> {
  $$SheepTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isWhatsAppNumber => $composableBuilder(
      column: $table.isWhatsAppNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get providerName => $composableBuilder(
      column: $table.providerName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get providerPhone => $composableBuilder(
      column: $table.providerPhone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relationWithProvider => $composableBuilder(
      column: $table.relationWithProvider,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get finderName => $composableBuilder(
      column: $table.finderName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get finderPhone => $composableBuilder(
      column: $table.finderPhone, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stage => $composableBuilder(
      column: $table.stage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get surveyStatus => $composableBuilder(
      column: $table.surveyStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalSessions => $composableBuilder(
      column: $table.totalSessions, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sessionsDone => $composableBuilder(
      column: $table.sessionsDone, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get wateringSessionsDone => $composableBuilder(
      column: $table.wateringSessionsDone,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get abandonReason => $composableBuilder(
      column: $table.abandonReason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get abandonDetails => $composableBuilder(
      column: $table.abandonDetails,
      builder: (column) => ColumnFilters(column));
}

class $$SheepTableTableOrderingComposer
    extends Composer<_$MyDatabase, $SheepTableTable> {
  $$SheepTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isWhatsAppNumber => $composableBuilder(
      column: $table.isWhatsAppNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get providerName => $composableBuilder(
      column: $table.providerName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get providerPhone => $composableBuilder(
      column: $table.providerPhone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relationWithProvider => $composableBuilder(
      column: $table.relationWithProvider,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get finderName => $composableBuilder(
      column: $table.finderName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get finderPhone => $composableBuilder(
      column: $table.finderPhone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stage => $composableBuilder(
      column: $table.stage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get surveyStatus => $composableBuilder(
      column: $table.surveyStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalSessions => $composableBuilder(
      column: $table.totalSessions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sessionsDone => $composableBuilder(
      column: $table.sessionsDone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get wateringSessionsDone => $composableBuilder(
      column: $table.wateringSessionsDone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get abandonReason => $composableBuilder(
      column: $table.abandonReason,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get abandonDetails => $composableBuilder(
      column: $table.abandonDetails,
      builder: (column) => ColumnOrderings(column));
}

class $$SheepTableTableAnnotationComposer
    extends Composer<_$MyDatabase, $SheepTableTable> {
  $$SheepTableTableAnnotationComposer({
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

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => column);

  GeneratedColumn<bool> get isWhatsAppNumber => $composableBuilder(
      column: $table.isWhatsAppNumber, builder: (column) => column);

  GeneratedColumn<String> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get providerName => $composableBuilder(
      column: $table.providerName, builder: (column) => column);

  GeneratedColumn<String> get providerPhone => $composableBuilder(
      column: $table.providerPhone, builder: (column) => column);

  GeneratedColumn<String> get relationWithProvider => $composableBuilder(
      column: $table.relationWithProvider, builder: (column) => column);

  GeneratedColumn<String> get finderName => $composableBuilder(
      column: $table.finderName, builder: (column) => column);

  GeneratedColumn<String> get finderPhone => $composableBuilder(
      column: $table.finderPhone, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumn<String> get surveyStatus => $composableBuilder(
      column: $table.surveyStatus, builder: (column) => column);

  GeneratedColumn<int> get totalSessions => $composableBuilder(
      column: $table.totalSessions, builder: (column) => column);

  GeneratedColumn<int> get sessionsDone => $composableBuilder(
      column: $table.sessionsDone, builder: (column) => column);

  GeneratedColumn<int> get wateringSessionsDone => $composableBuilder(
      column: $table.wateringSessionsDone, builder: (column) => column);

  GeneratedColumn<String> get abandonReason => $composableBuilder(
      column: $table.abandonReason, builder: (column) => column);

  GeneratedColumn<String> get abandonDetails => $composableBuilder(
      column: $table.abandonDetails, builder: (column) => column);
}

class $$SheepTableTableTableManager extends RootTableManager<
    _$MyDatabase,
    $SheepTableTable,
    SheepTableData,
    $$SheepTableTableFilterComposer,
    $$SheepTableTableOrderingComposer,
    $$SheepTableTableAnnotationComposer,
    $$SheepTableTableCreateCompanionBuilder,
    $$SheepTableTableUpdateCompanionBuilder,
    (
      SheepTableData,
      BaseReferences<_$MyDatabase, $SheepTableTable, SheepTableData>
    ),
    SheepTableData,
    PrefetchHooks Function()> {
  $$SheepTableTableTableManager(_$MyDatabase db, $SheepTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SheepTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SheepTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SheepTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> phoneNumber = const Value.absent(),
            Value<bool> isWhatsAppNumber = const Value.absent(),
            Value<String> age = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<String> providerName = const Value.absent(),
            Value<String> providerPhone = const Value.absent(),
            Value<String> relationWithProvider = const Value.absent(),
            Value<String> finderName = const Value.absent(),
            Value<String> finderPhone = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> stage = const Value.absent(),
            Value<String> surveyStatus = const Value.absent(),
            Value<int> totalSessions = const Value.absent(),
            Value<int> sessionsDone = const Value.absent(),
            Value<int> wateringSessionsDone = const Value.absent(),
            Value<String?> abandonReason = const Value.absent(),
            Value<String?> abandonDetails = const Value.absent(),
          }) =>
              SheepTableCompanion(
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            isWhatsAppNumber: isWhatsAppNumber,
            age: age,
            address: address,
            providerName: providerName,
            providerPhone: providerPhone,
            relationWithProvider: relationWithProvider,
            finderName: finderName,
            finderPhone: finderPhone,
            createdAt: createdAt,
            status: status,
            stage: stage,
            surveyStatus: surveyStatus,
            totalSessions: totalSessions,
            sessionsDone: sessionsDone,
            wateringSessionsDone: wateringSessionsDone,
            abandonReason: abandonReason,
            abandonDetails: abandonDetails,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String phoneNumber,
            required bool isWhatsAppNumber,
            required String age,
            required String address,
            required String providerName,
            required String providerPhone,
            required String relationWithProvider,
            required String finderName,
            required String finderPhone,
            required DateTime createdAt,
            required String status,
            required String stage,
            required String surveyStatus,
            required int totalSessions,
            required int sessionsDone,
            required int wateringSessionsDone,
            Value<String?> abandonReason = const Value.absent(),
            Value<String?> abandonDetails = const Value.absent(),
          }) =>
              SheepTableCompanion.insert(
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            isWhatsAppNumber: isWhatsAppNumber,
            age: age,
            address: address,
            providerName: providerName,
            providerPhone: providerPhone,
            relationWithProvider: relationWithProvider,
            finderName: finderName,
            finderPhone: finderPhone,
            createdAt: createdAt,
            status: status,
            stage: stage,
            surveyStatus: surveyStatus,
            totalSessions: totalSessions,
            sessionsDone: sessionsDone,
            wateringSessionsDone: wateringSessionsDone,
            abandonReason: abandonReason,
            abandonDetails: abandonDetails,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SheepTableTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $SheepTableTable,
    SheepTableData,
    $$SheepTableTableFilterComposer,
    $$SheepTableTableOrderingComposer,
    $$SheepTableTableAnnotationComposer,
    $$SheepTableTableCreateCompanionBuilder,
    $$SheepTableTableUpdateCompanionBuilder,
    (
      SheepTableData,
      BaseReferences<_$MyDatabase, $SheepTableTable, SheepTableData>
    ),
    SheepTableData,
    PrefetchHooks Function()>;
typedef $$SessionTableTableCreateCompanionBuilder = SessionTableCompanion
    Function({
  Value<int> id,
  required int sheepId,
  required DateTime appointmentDate,
  required String type,
  required int sessionNumber,
  Value<String?> notes,
  required bool completed,
  Value<DateTime?> completedAt,
});
typedef $$SessionTableTableUpdateCompanionBuilder = SessionTableCompanion
    Function({
  Value<int> id,
  Value<int> sheepId,
  Value<DateTime> appointmentDate,
  Value<String> type,
  Value<int> sessionNumber,
  Value<String?> notes,
  Value<bool> completed,
  Value<DateTime?> completedAt,
});

class $$SessionTableTableFilterComposer
    extends Composer<_$MyDatabase, $SessionTableTable> {
  $$SessionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sheepId => $composableBuilder(
      column: $table.sheepId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get appointmentDate => $composableBuilder(
      column: $table.appointmentDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sessionNumber => $composableBuilder(
      column: $table.sessionNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));
}

class $$SessionTableTableOrderingComposer
    extends Composer<_$MyDatabase, $SessionTableTable> {
  $$SessionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sheepId => $composableBuilder(
      column: $table.sheepId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get appointmentDate => $composableBuilder(
      column: $table.appointmentDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sessionNumber => $composableBuilder(
      column: $table.sessionNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));
}

class $$SessionTableTableAnnotationComposer
    extends Composer<_$MyDatabase, $SessionTableTable> {
  $$SessionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sheepId =>
      $composableBuilder(column: $table.sheepId, builder: (column) => column);

  GeneratedColumn<DateTime> get appointmentDate => $composableBuilder(
      column: $table.appointmentDate, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get sessionNumber => $composableBuilder(
      column: $table.sessionNumber, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);
}

class $$SessionTableTableTableManager extends RootTableManager<
    _$MyDatabase,
    $SessionTableTable,
    SessionTableData,
    $$SessionTableTableFilterComposer,
    $$SessionTableTableOrderingComposer,
    $$SessionTableTableAnnotationComposer,
    $$SessionTableTableCreateCompanionBuilder,
    $$SessionTableTableUpdateCompanionBuilder,
    (
      SessionTableData,
      BaseReferences<_$MyDatabase, $SessionTableTable, SessionTableData>
    ),
    SessionTableData,
    PrefetchHooks Function()> {
  $$SessionTableTableTableManager(_$MyDatabase db, $SessionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> sheepId = const Value.absent(),
            Value<DateTime> appointmentDate = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> sessionNumber = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> completed = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
          }) =>
              SessionTableCompanion(
            id: id,
            sheepId: sheepId,
            appointmentDate: appointmentDate,
            type: type,
            sessionNumber: sessionNumber,
            notes: notes,
            completed: completed,
            completedAt: completedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int sheepId,
            required DateTime appointmentDate,
            required String type,
            required int sessionNumber,
            Value<String?> notes = const Value.absent(),
            required bool completed,
            Value<DateTime?> completedAt = const Value.absent(),
          }) =>
              SessionTableCompanion.insert(
            id: id,
            sheepId: sheepId,
            appointmentDate: appointmentDate,
            type: type,
            sessionNumber: sessionNumber,
            notes: notes,
            completed: completed,
            completedAt: completedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SessionTableTableProcessedTableManager = ProcessedTableManager<
    _$MyDatabase,
    $SessionTableTable,
    SessionTableData,
    $$SessionTableTableFilterComposer,
    $$SessionTableTableOrderingComposer,
    $$SessionTableTableAnnotationComposer,
    $$SessionTableTableCreateCompanionBuilder,
    $$SessionTableTableUpdateCompanionBuilder,
    (
      SessionTableData,
      BaseReferences<_$MyDatabase, $SessionTableTable, SessionTableData>
    ),
    SessionTableData,
    PrefetchHooks Function()>;

class $MyDatabaseManager {
  final _$MyDatabase _db;
  $MyDatabaseManager(this._db);
  $$SheepTableTableTableManager get sheepTable =>
      $$SheepTableTableTableManager(_db, _db.sheepTable);
  $$SessionTableTableTableManager get sessionTable =>
      $$SessionTableTableTableManager(_db, _db.sessionTable);
}
