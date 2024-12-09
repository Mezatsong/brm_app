import 'package:brm/core/utils/strings.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_constants.dart';
import 'enums/e_sheep_stage.dart';
import 'enums/e_sheep_status.dart';
import 'enums/e_sheep_survey_status.dart';
import 'session.dart';

class Sheep extends Equatable {
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
  final ESheepStatus status; // active, abandoned
  final ESheepStage
      stage; // invitation, survey, witnessing, transfer, watering, won
  final ESheepSurveyStatus surveyStatus; // none, pending, ok, rejected
  final int totalSessions;
  final int sessionsDone;
  final int wateringSessionsDone;
  final String? abandonReason;
  final String? abandonDetails;
  final Session? lastSession;

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
    this.lastSession,
  });

  String get stateSummary {
    var text = '${stage.value.capitalize()} (';
    switch (stage) {
      case ESheepStage.survey:
        text += surveyStatus.value.replaceAll('_', '');
        break;
      case ESheepStage.witnessing:
        text += '$sessionsDone / $totalSessions';
        break;
      case ESheepStage.watering:
        text += '$wateringSessionsDone / ${AppConstants.wateringtotalSessions}';
        break;
      default:
        text = text.replaceAll('(', '');
    }

    return text;
  }

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
        lastSession
      ];
}
