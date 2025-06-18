// To parse this JSON data, do
//
//     final updateMedicinModel = updateMedicinModelFromJson(jsonString);

import 'dart:convert';

UpdateMedicinModel updateMedicinModelFromJson(String str) => UpdateMedicinModel.fromJson(json.decode(str));

String updateMedicinModelToJson(UpdateMedicinModel data) => json.encode(data.toJson());

class UpdateMedicinModel {
    bool? success;
    String? message;
    UpdatedMedicine? updatedMedicine;

    UpdateMedicinModel({
        this.success,
        this.message,
        this.updatedMedicine,
    });

    UpdateMedicinModel copyWith({
        bool? success,
        String? message,
        UpdatedMedicine? updatedMedicine,
    }) => 
        UpdateMedicinModel(
            success: success ?? this.success,
            message: message ?? this.message,
            updatedMedicine: updatedMedicine ?? this.updatedMedicine,
        );

    factory UpdateMedicinModel.fromJson(Map<String, dynamic> json) => UpdateMedicinModel(
        success: json["success"],
        message: json["message"],
        updatedMedicine: json["updatedMedicine"] == null ? null : UpdatedMedicine.fromJson(json["updatedMedicine"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "updatedMedicine": updatedMedicine?.toJson(),
    };
}

class UpdatedMedicine {
    Medicine? medicine;
    String? id;
    DateTime? updatedAt;

    UpdatedMedicine({
        this.medicine,
        this.id,
        this.updatedAt,
    });

    UpdatedMedicine copyWith({
        Medicine? medicine,
        String? id,
        DateTime? updatedAt,
    }) => 
        UpdatedMedicine(
            medicine: medicine ?? this.medicine,
            id: id ?? this.id,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory UpdatedMedicine.fromJson(Map<String, dynamic> json) => UpdatedMedicine(
        medicine: json["medicine"] == null ? null : Medicine.fromJson(json["medicine"]),
        id: json["_id"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "medicine": medicine?.toJson(),
        "_id": id,
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class Medicine {
    Dosage? dosage;
    Schedule? schedule;
    String? name;
    String? instructions;
    bool? isActive;

    Medicine({
        this.dosage,
        this.schedule,
        this.name,
        this.instructions,
        this.isActive,
    });

    Medicine copyWith({
        Dosage? dosage,
        Schedule? schedule,
        String? name,
        String? instructions,
        bool? isActive,
    }) => 
        Medicine(
            dosage: dosage ?? this.dosage,
            schedule: schedule ?? this.schedule,
            name: name ?? this.name,
            instructions: instructions ?? this.instructions,
            isActive: isActive ?? this.isActive,
        );

    factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        dosage: json["dosage"] == null ? null : Dosage.fromJson(json["dosage"]),
        schedule: json["schedule"] == null ? null : Schedule.fromJson(json["schedule"]),
        name: json["name"],
        instructions: json["instructions"],
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "dosage": dosage?.toJson(),
        "schedule": schedule?.toJson(),
        "name": name,
        "instructions": instructions,
        "isActive": isActive,
    };
}

class Dosage {
    String? unit;
    String? amount;

    Dosage({
        this.unit,
        this.amount,
    });

    Dosage copyWith({
        String? unit,
        String? amount,
    }) => 
        Dosage(
            unit: unit ?? this.unit,
            amount: amount ?? this.amount,
        );

    factory Dosage.fromJson(Map<String, dynamic> json) => Dosage(
        unit: json["unit"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "unit": unit,
        "amount": amount,
    };
}

class Schedule {
    List<String>? times;
    String? date;

    Schedule({
        this.times,
        this.date,
    });

    Schedule copyWith({
        List<String>? times,
        String? date,
    }) => 
        Schedule(
            times: times ?? this.times,
            date: date ?? this.date,
        );

    factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        times: json["times"] == null ? [] : List<String>.from(json["times"]!.map((x) => x)),
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "times": times == null ? [] : List<dynamic>.from(times!.map((x) => x)),
        "date": date,
    };
}
