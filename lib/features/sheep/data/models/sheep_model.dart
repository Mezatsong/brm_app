import '../../domain/entities/sheep.dart';
import 'session_model.dart';

class SheepModel extends Sheep {
  final SessionModel? lastSessionModel;

  const SheepModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.isWhatsAppNumber,
    required super.age,
    required super.address,
    required super.providerName,
    required super.providerPhone,
    required super.relationWithProvider,
    required super.finderName,
    required super.finderPhone,
    required super.createdAt,
    required super.status,
    required super.stage,
    required super.surveyStatus,
    required super.totalSessions,
    required super.sessionsDone,
    required super.wateringSessionsDone,
    super.abandonReason,
    super.abandonDetails,
    this.lastSessionModel,
  });

  factory SheepModel.fromSheep(Sheep sheep) {
    return SheepModel(
      id: sheep.id,
      name: sheep.name,
      phoneNumber: sheep.phoneNumber,
      isWhatsAppNumber: sheep.isWhatsAppNumber,
      age: sheep.age,
      address: sheep.address,
      providerName: sheep.providerName,
      providerPhone: sheep.providerPhone,
      relationWithProvider: sheep.relationWithProvider,
      finderName: sheep.finderName,
      finderPhone: sheep.finderPhone,
      createdAt: sheep.createdAt,
      status: sheep.status,
      stage: sheep.stage,
      surveyStatus: sheep.surveyStatus,
      totalSessions: sheep.totalSessions,
      sessionsDone: sheep.sessionsDone,
      wateringSessionsDone: sheep.wateringSessionsDone,
      abandonReason: sheep.abandonReason,
      abandonDetails: sheep.abandonDetails,
      lastSessionModel: sheep.lastSession == null
          ? null
          : SessionModel.fromSession(sheep.lastSession!),
    );
  }

  Sheep toSheep() {
    return Sheep(
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
      lastSession: lastSessionModel?.toSession(),
    );
  }

  factory SheepModel.fromJson(Map<String, dynamic> json) {
    return SheepModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      isWhatsAppNumber: json['isWhatsAppNumber'],
      age: json['age'],
      address: json['address'],
      providerName: json['providerName'],
      providerPhone: json['providerPhone'],
      relationWithProvider: json['relationWithProvider'],
      finderName: json['finderName'],
      finderPhone: json['finderPhone'],
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
      stage: json['stage'],
      surveyStatus: json['surveyStatus'],
      totalSessions: json['totalSessions'],
      sessionsDone: json['sessionsDone'],
      wateringSessionsDone: json['wateringSessionsDone'],
      abandonReason: json['abandonReason'],
      abandonDetails: json['abandonDetails'],
      lastSessionModel: json['lastSession'] == null
          ? null
          : SessionModel.fromJson(json['lastSession']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'isWhatsAppNumber': isWhatsAppNumber,
      'age': age,
      'address': address,
      'providerName': providerName,
      'providerPhone': providerPhone,
      'relationWithProvider': relationWithProvider,
      'finderName': finderName,
      'finderPhone': finderPhone,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'stage': stage,
      'surveyStatus': surveyStatus,
      'totalSessions': totalSessions,
      'sessionsDone': sessionsDone,
      'wateringSessionsDone': wateringSessionsDone,
      'abandonReason': abandonReason,
      'abandonDetails': abandonDetails,
      'lastSession': lastSessionModel?.toJson(),
    };
  }
}
