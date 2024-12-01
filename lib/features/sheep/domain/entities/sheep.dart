import 'package:equatable/equatable.dart';

class Sheep extends Equatable {
  final int id;
  final String name;
  final String phoneNumber;
  final bool isWhatsAppNumber;
  final int age;
  final String address;
  final String providerName;
  final String providerPhone;
  final String relationWithProvider;
  final String finderName;
  final String finderPhone;
  final DateTime createdAt;
  final ESheepStatus status; // active, abandoned
  final ESheepStage stage; // survey, witnessing, transfer, watering, won
  final ESheepSurveyStatus surveyStatus; // none, pending, ok, rejected
  final int totalSessions;
  final int sessionsDone;
  final int wateringSessionsDone;
  final String? abandonReason;
  final String? abandonDetails;

  const Sheep({
    required this.id,
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
    this.abandonDetails,
  });

  @override
  List<Object?> get props => [
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
        abandonDetails,
      ];
}

enum ESheepStatus {
  active('active'),
  abandoned('abandonee');

  final String value;
  const ESheepStatus(this.value);

  static ESheepStatus? tryParse(String value) {
    return values.where((e) => e.value == value.toLowerCase()).firstOrNull;
  }
}

enum ESheepStage {
  survey('sondage'),
  witnessing('temoingnage'),
  transfer('transfert'),
  watering('arrosage'),
  won('gagne');

  final String value;
  const ESheepStage(this.value);

  static ESheepStage? tryParse(String value) {
    return values.where((e) => e.value == value.toLowerCase()).firstOrNull;
  }
}

enum ESheepSurveyStatus {
  none('aucun'),
  pending('en_attente'),
  ok('ok'),
  rejected('rejete');

  final String value;
  const ESheepSurveyStatus(this.value);

  static ESheepSurveyStatus? tryParse(String value) {
    return values.where((e) => e.value == value.toLowerCase()).firstOrNull;
  }
}
