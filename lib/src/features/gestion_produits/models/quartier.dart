class Quartier {
  int id;
  String nomQuartier;
  DateTime? createdAt;
  DateTime? updatedAt;

  Quartier({
    required this.id,
    required this.nomQuartier,
    this.createdAt,
    this.updatedAt,
  });

  factory Quartier.fromJson(Map<String, dynamic> json) {
    return Quartier(
      id: json['id'],
      nomQuartier: json['nomQuartier'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nomQuartier'] = nomQuartier;
    data['created_at'] = createdAt?.toIso8601String();
    data['updated_at'] = updatedAt?.toIso8601String();
    return data;
  }
}
