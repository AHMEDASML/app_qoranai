import 'dart:convert';

class CampaignApi {
  final bool success;
  final String message;
  final CampaignResponse? campaign;

  CampaignApi({
    required this.success,
    required this.message,
    this.campaign,
  });

  factory CampaignApi.fromJson(Map<String, dynamic> json) {
    final dynamic campaignJson = json['campaign'];

    CampaignResponse? campaignData;
    if (campaignJson is Map<String, dynamic>) {
      campaignData = CampaignResponse.fromJson(campaignJson);
    } else {
      campaignData = CampaignResponse(guide: [],id:"",program: []); // Handles case where campaign is [] (a List)
    }

    return CampaignApi(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      campaign: campaignData,
    );
  }
}

class CampaignResponse {
  final String id;
  final List<Guide> guide;
  final List<ProgramCamping> program;

  CampaignResponse({
    required this.id,
    required this.guide,
    required this.program,
  });

  factory CampaignResponse.fromJson(Map<String, dynamic> json) {
    var guideList = json['guide'] as List<dynamic>? ?? [];
    var programList = json['program'] as List<dynamic>? ?? [];

    return CampaignResponse(
      id: json['id'] ?? '',
      guide: guideList.map((i) => Guide.fromJson(i)).toList(),
      program: programList.map((i) => ProgramCamping.fromJson(i)).toList(),
    );
  }
}

class Guide {
  final String title;
  final Mobile? mobile;
  final LocationApi? location;
  final String id;

  Guide({
    required this.title,
    this.mobile,
    this.location,
    required this.id,
  });

  factory Guide.fromJson(Map<String, dynamic> json) {
    return Guide(
      title: json['title'] ?? '',
      mobile: json['mobile'] != null ? Mobile.fromJson(json['mobile']) : null,
      location: json['location'] != null ? LocationApi.fromJson(json['location']) : null,
      id: json['_id'] ?? '',
    );
  }
}

class Mobile {
  final String? prefix;
  final String? number;

  Mobile({
    this.prefix,
    this.number,
  });

  factory Mobile.fromJson(Map<String, dynamic> json) {
    return Mobile(
      prefix: json['prefix'],
      number: json['number'],
    );
  }
}

class LocationApi {
  final String? type;
  final List<double>? coordinates;

  LocationApi({
    this.type,
    this.coordinates,
  });

  factory LocationApi.fromJson(Map<String, dynamic> json) {
    return LocationApi(
      type: json['type'],
      coordinates: json['coordinates'] != null
          ? List<double>.from(json['coordinates'].map((e) => e.toDouble()))
          : null,
    );
  }
}

class ProgramCamping {
  final String title;
  final DateTime? date;
  final String? time;
  final LocationApi? location;
  final String details;
  final String id;

  ProgramCamping({
    required this.title,
    this.date,
    this.time,
    this.location,
    required this.details,
    required this.id,
  });

  factory ProgramCamping.fromJson(Map<String, dynamic> json) {
    return ProgramCamping(
      title: json['title'] ?? '',
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      time: json['time'],
      location: json['location'] != null ? LocationApi.fromJson(json['location']) : null,
      details: json['details'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}
