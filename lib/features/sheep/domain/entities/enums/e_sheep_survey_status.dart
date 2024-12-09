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
