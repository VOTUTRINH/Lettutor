class TestPreparation {
  final int id;
  final String key;
  final String name;

  TestPreparation({
    required this.id,
    required this.key,
    required this.name,
  });

  factory TestPreparation.fromJson(Map<String, dynamic> json) {
    return TestPreparation(
      id: json['id'],
      key: json['key'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['key'] = key;
    data['name'] = name;
    return data;
  }
}
