
class CrowdingResponse {
  final bool success;
  final String? message; // Make message nullable
  final List<Crowding>? crowding; // Make crowding nullable

  CrowdingResponse({
    required this.success,
    this.message,
    this.crowding,
  });

  factory CrowdingResponse.fromJson(Map<String, dynamic> json) {
    return CrowdingResponse(
      success: json['success'] ?? false, // Default to false if null
      message: json['message'] as String?, // Nullable
      crowding: json['crowding'] != null
          ? Crowding.listFromJson(json['crowding'])
          : null, // Handle potential null
    );
  }
}

class Crowding {
  final String id;
  final Jamrat jamrat;
  final Saai saai;
  final Tawaf tawaf;
  final DateTime updatedAt;

  Crowding({
    required this.id,
    required this.jamrat,
    required this.saai,
    required this.tawaf,
    required this.updatedAt,
  });

  factory Crowding.fromJson(Map<String, dynamic> json) {
    return Crowding(
      id: json['_id'] ?? '', // Default to empty string if null
      jamrat: Jamrat.fromJson(json['jamrat'] ?? {}), // Handle null with empty object
      saai: Saai.fromJson(json['saai'] ?? {}), // Handle null with empty object
      tawaf: Tawaf.fromJson(json['tawaf'] ?? {}), // Handle null with empty object
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(), // Use current date if null
    );
  }

  static List<Crowding> listFromJson(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList.map((json) => Crowding.fromJson(json)).toList();
  }
}

class Jamrat {
  final String groundFloor;
  final String firstFloor;
  final String secondFloor;
  final String thirdFloor;
  final String fourthFloor;

  Jamrat({
    required this.groundFloor,
    required this.firstFloor,
    required this.secondFloor,
    required this.thirdFloor,
    required this.fourthFloor,
  });

  factory Jamrat.fromJson(Map<String, dynamic>? json) {
    return Jamrat(
      groundFloor: json?['ground_floor'] ?? '0%', // Default to '0%' if null
      firstFloor: json?['first_floor'] ?? '0%',
      secondFloor: json?['second_floor'] ?? '0%',
      thirdFloor: json?['third_floor'] ?? '0%',
      fourthFloor: json?['fourth_floor'] ?? '0%',
    );
  }
}

class Saai {
  final String basement;
  final String mezanen;
  final String groundFloor;
  final String firstFloor;
  final String sahen;

  Saai({
    required this.basement,
    required this.mezanen,
    required this.groundFloor,
    required this.firstFloor,
    required this.sahen,
  });

  factory Saai.fromJson(Map<String, dynamic>? json) {
    return Saai(
      basement: json?['basement'] ?? '0%', // Default to '0%' if null
      mezanen: json?['mezanen'] ?? '0%',
      groundFloor: json?['ground_floor'] ?? '0%',
      firstFloor: json?['first_floor'] ?? '0%',
      sahen: json?['sahen'] ?? '0%',
    );
  }
}

class Tawaf {
  final String surface;
  final String mezanen;
  final String groundFloor;
  final String firstFloor;
  final String sahen;

  Tawaf({
    required this.surface,
    required this.mezanen,
    required this.groundFloor,
    required this.firstFloor,
    required this.sahen,
  });

  factory Tawaf.fromJson(Map<String, dynamic>? json) {
    return Tawaf(
      surface: json?['surface'] ?? '0%', // Default to '0%' if null
      mezanen: json?['mezanen'] ?? '0%',
      groundFloor: json?['ground_floor'] ?? '0%',
      firstFloor: json?['first_floor'] ?? '0%',
      sahen: json?['sahen'] ?? '0%',
    );
  }
}