import 'dart:convert';

// Model for individual inquiry
class Inquiry {
  final String? id;
  final String? question;
  final String? answer;

  Inquiry({this.id, this.question, this.answer});

  factory Inquiry.fromJson(Map<String, dynamic> json) {
    return Inquiry(
      id: json['id'] as String?,
      question: json['question'] as String?,
      answer: json['answer'] as String?,
    );
  }
}

// Model for the response containing inquiries
class InquiriesResponse {
  final bool success;
  final String message;
  final List<Inquiry> inquiries;

  InquiriesResponse({
    required this.success,
    required this.message,
    required this.inquiries,
  });

  factory InquiriesResponse.fromJson(Map<String, dynamic> json) {
    var inquiriesList = json['inquiries'] as List;
    List<Inquiry> inquiries = inquiriesList.map((i) => Inquiry.fromJson(i)).toList();

    return InquiriesResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      inquiries: inquiries,
    );
  }
}

// Function to parse JSON response
InquiriesResponse parseInquiriesResponse(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return InquiriesResponse.fromJson(parsed);
}