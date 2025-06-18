// To parse this JSON data, do
//
//     final medicinDetailsModel = medicinDetailsModelFromJson(jsonString);

import 'dart:convert';

MedicinDetailsModel medicinDetailsModelFromJson(String str) => MedicinDetailsModel.fromJson(json.decode(str));

String medicinDetailsModelToJson(MedicinDetailsModel data) => json.encode(data.toJson());

class MedicinDetailsModel {
    bool? success;
    String? message;
    SavedMedicine? savedMedicine;

    MedicinDetailsModel({
        this.success,
        this.message,
        this.savedMedicine,
    });

    MedicinDetailsModel copyWith({
        bool? success,
        String? message,
        SavedMedicine? savedMedicine,
    }) => 
        MedicinDetailsModel(
            success: success ?? this.success,
            message: message ?? this.message,
            savedMedicine: savedMedicine ?? this.savedMedicine,
        );

    factory MedicinDetailsModel.fromJson(Map<String, dynamic> json) => MedicinDetailsModel(
        success: json["success"],
        message: json["message"],
        savedMedicine: json["savedMedicine"] == null ? null : SavedMedicine.fromJson(json["savedMedicine"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "savedMedicine": savedMedicine?.toJson(),
    };
}

class SavedMedicine {
    Medicine? medicine;
    String? id;
    DateTime? updatedAt;

    SavedMedicine({
        this.medicine,
        this.id,
        this.updatedAt,
    });

    SavedMedicine copyWith({
        Medicine? medicine,
        String? id,
        DateTime? updatedAt,
    }) => 
        SavedMedicine(
            medicine: medicine ?? this.medicine,
            id: id ?? this.id,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory SavedMedicine.fromJson(Map<String, dynamic> json) => SavedMedicine(
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
    String? name;
    Dosage? dosage;
    Schedule? schedule;
    String? instructions;
    bool? isActive;

    Medicine({
        this.name,
        this.dosage,
        this.schedule,
        this.instructions,
        this.isActive,
    });

    Medicine copyWith({
        String? name,
        Dosage? dosage,
        Schedule? schedule,
        String? instructions,
        bool? isActive,
    }) => 
        Medicine(
            name: name ?? this.name,
            dosage: dosage ?? this.dosage,
            schedule: schedule ?? this.schedule,
            instructions: instructions ?? this.instructions,
            isActive: isActive ?? this.isActive,
        );

    factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        name: json["name"],
        dosage: json["dosage"] == null ? null : Dosage.fromJson(json["dosage"]),
        schedule: json["schedule"] == null ? null : Schedule.fromJson(json["schedule"]),
        instructions: json["instructions"],
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "dosage": dosage?.toJson(),
        "schedule": schedule?.toJson(),
        "instructions": instructions,
        "isActive": isActive,
    };
}

class Dosage {
    String? amount;
    String? unit;

    Dosage({
        this.amount,
        this.unit,
    });

    Dosage copyWith({
        String? amount,
        String? unit,
    }) => 
        Dosage(
            amount: amount ?? this.amount,
            unit: unit ?? this.unit,
        );

    factory Dosage.fromJson(Map<String, dynamic> json) => Dosage(
        amount: json["amount"],
        unit: json["unit"],
    );

    Map<String, dynamic> toJson() => {
        "amount": amount,
        "unit": unit,
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
