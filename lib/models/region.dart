class Region {
  final String id;
  final String name_uz;
  final String name_oz;
  final String name_ru;

  Region({
    required this.id,
    required this.name_uz,
    required this.name_oz,
    required this.name_ru,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json['id'] as String,
      name_uz: json['name_uz'] as String,
      name_oz: json['name_oz'] as String,
      name_ru: json['name_ru'] as String,
    );
  }
}

class District {
  final String id;
  final String region_id;
  final String name_uz;
  final String name_oz;
  final String name_ru;

  District({
    required this.id,
    required this.region_id,
    required this.name_uz,
    required this.name_oz,
    required this.name_ru,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'] as String,
      region_id: json['region_id'] as String,
      name_uz: json['name_uz'] as String,
      name_oz: json['name_oz'] as String,
      name_ru: json['name_ru'] as String,
    );
  }
}

class Village {
  final String id;
  final String district_id;
  final String name_uz;
  final String name_oz;
  final String name_ru;

  Village({
    required this.id,
    required this.district_id,
    required this.name_uz,
    required this.name_oz,
    required this.name_ru,
  });

  factory Village.fromJson(Map<String, dynamic> json) {
    print(json);
    return Village(
      id: json['id'] as String,
      district_id: json['district_id'] as String,
      name_uz: json['name_uz'] as String,
      name_oz: json['name_oz'] as String,
      name_ru: json['name_ru'] as String,
    );
  }
}