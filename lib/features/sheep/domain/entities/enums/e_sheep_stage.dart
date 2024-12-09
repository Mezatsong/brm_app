enum ESheepStage {
  invitation('invitation'),
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
