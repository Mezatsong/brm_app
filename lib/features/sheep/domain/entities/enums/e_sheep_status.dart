enum ESheepStatus {
  active('active'),
  abandoned('abandonee'),
  won('gagne');

  final String value;
  const ESheepStatus(this.value);

  static ESheepStatus? tryParse(String value) {
    return values.where((e) => e.value == value.toLowerCase()).firstOrNull;
  }
}
