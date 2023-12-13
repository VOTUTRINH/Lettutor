class Course {
  late String id;
  late String name;
  late String description;
  late String imageUrl;
  late String level;
  late int numberLessons;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.level,
    required this.numberLessons,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      level: json['level'],
      numberLessons: json['number_lessons'],
    );
  }
}
