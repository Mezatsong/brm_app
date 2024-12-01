import '../../domain/entities/sheep.dart';

class SheepModel extends Sheep {
  const SheepModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    super.whatsappNumber,
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
  });

  factory SheepModel.fromJson(Map<String, dynamic> json) {
    return SheepModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      whatsappNumber: json['whatsappNumber'],
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'whatsappNumber': whatsappNumber,
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
    };
  }
}