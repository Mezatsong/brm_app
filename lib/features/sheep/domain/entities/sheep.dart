import 'package:equatable/equatable.dart';

class Sheep extends Equatable {
  final String id;
  final String name;
  final String phoneNumber;
  final String? whatsappNumber;
  final int age;
  final String address;
  final String providerName;
  final String providerPhone;
  final String relationWithProvider;
  final String finderName;
  final String finderPhone;
  final DateTime createdAt;
  final String status; // active, abandoned
  final String stage; // survey, witnessing, transfer, watering, won
  final String surveyStatus; // pending, ok, rejected
  final int totalSessions;
  final int sessionsDone;
  final int wateringSessionsDone;
  final String? abandonReason;
  final String? abandonDetails;

  const Sheep({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.whatsappNumber,
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
    whatsappNumber,
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