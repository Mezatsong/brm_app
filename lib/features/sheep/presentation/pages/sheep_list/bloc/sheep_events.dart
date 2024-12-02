part of '../sheep_list_page.dart';

abstract class _SheepEvent {}

class _LoadSheepEvent extends _SheepEvent {}

class _SearchSheepEvent extends _SheepEvent {
  final String query;
  final ESheepStatus? status;
  final ESheepStage? stage;
  final ESheepSurveyStatus? surveyStatus;

  _SearchSheepEvent({
    this.query = '',
    this.status,
    this.stage,
    this.surveyStatus,
  });
}

class _LoadMoreSheepEvent extends _SheepEvent {
  final String query;
  final ESheepStatus? status;
  final ESheepStage? stage;
  final ESheepSurveyStatus? surveyStatus;

  _LoadMoreSheepEvent({
    this.query = '',
    this.status,
    this.stage,
    this.surveyStatus,
  });
}
