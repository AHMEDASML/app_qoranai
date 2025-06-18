class Supplication {
  final String? title;
  final String? text;
  final String? id;
  final String? audio;
  final String? classification;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Supplication({
    this.title,
    this.text,
    this.id,
    this.audio,
    this.classification,
    this.createdAt,
    this.updatedAt,
  });

  factory Supplication.fromJson(Map<String, dynamic> json) {
    return Supplication(
      title: json['title'] as String?,
      text: json['text'] as String?,
      id: json['_id'] as String?,
      audio: json['audio'] as String?,
      classification: json['classification'] as String?,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}