class NationalityKey {
  static const String isForeign = 'isForeign';
  static const String isVietnamese = 'isVietnamese';
  static const String isNative = 'isNative';
}

class NationalityFilter {
  late String key;
  late bool isSelected;

  NationalityFilter({required this.key, required this.isSelected});
}
