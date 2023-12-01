class Topic {
  final String? id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final String? videoUrl;
  final String? pdfUrl;
  final String? audioUrl;
  final String? createdAt;
  final String? updatedAt;

  Topic({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.videoUrl,
    this.pdfUrl,
    this.audioUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      pdfUrl: json['pdfUrl'],
      audioUrl: json['audioUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
