// To parse this JSON data, do
//
//     final qusetionModel = qusetionModelFromJson(jsonString);

import 'dart:convert';

QusetionModel qusetionModelFromJson(String str) =>
    QusetionModel.fromJson(json.decode(str));

String qusetionModelToJson(QusetionModel data) => json.encode(data.toJson());

class QusetionModel {
  bool? success;
  String? message;
  List<InquiryElement>? inquiries;

  QusetionModel({
    this.success,
    this.message,
    this.inquiries,
  });

  QusetionModel copyWith({
    bool? success,
    String? message,
    List<InquiryElement>? inquiries,
  }) =>
      QusetionModel(
        success: success ?? this.success,
        message: message ?? this.message,
        inquiries: inquiries ?? this.inquiries,
      );

  factory QusetionModel.fromJson(Map<String, dynamic> json) => QusetionModel(
        success: json["success"],
        message: json["message"],
        inquiries: json["inquiries"] == null
            ? []
            : List<InquiryElement>.from(
                json["inquiries"]!.map((x) => InquiryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "inquiries": inquiries == null
            ? []
            : List<dynamic>.from(inquiries!.map((x) => x.toJson())),
      };
}

class InquiryElement {
  InquiryInquiry? inquiry;
  String? id;
  DateTime? updatedAt;

  InquiryElement({
    this.inquiry,
    this.id,
    this.updatedAt,
  });

  InquiryElement copyWith({
    InquiryInquiry? inquiry,
    String? id,
    DateTime? updatedAt,
  }) =>
      InquiryElement(
        inquiry: inquiry ?? this.inquiry,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory InquiryElement.fromJson(Map<String, dynamic> json) => InquiryElement(
        inquiry: json["inquiry"] == null
            ? null
            : InquiryInquiry.fromJson(json["inquiry"]),
        id: json["_id"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "inquiry": inquiry?.toJson(),
        "_id": id,
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class InquiryInquiry {
  String? answer;
  String? status;
  String? question;

  InquiryInquiry({
    this.answer,
    this.status,
    this.question,
  });

  InquiryInquiry copyWith({
    String? answer,
    String? status,
    String? question,
  }) =>
      InquiryInquiry(
        answer: answer ?? this.answer,
        status: status ?? this.status,
        question: question ?? this.question,
      );

  factory InquiryInquiry.fromJson(Map<String, dynamic> json) => InquiryInquiry(
        answer: json["answer"],
        status: json["status"],
        question: json["question"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
        "status": status,
        "question": question,
      };
}
