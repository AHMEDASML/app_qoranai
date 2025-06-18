// To parse this JSON data, do
//
//     final allMedicinsModel = allMedicinsModelFromJson(jsonString);

import 'dart:convert';

AllMedicinsModel allMedicinsModelFromJson(String str) => AllMedicinsModel.fromJson(json.decode(str));

String allMedicinsModelToJson(AllMedicinsModel data) => json.encode(data.toJson());

class AllMedicinsModel {
    bool? success;
    String? message;
    List<MedicineElement>? medicines;

    AllMedicinsModel({
        this.success,
        this.message,
        this.medicines,
    });

    AllMedicinsModel copyWith({
        bool? success,
        String? message,
        List<MedicineElement>? medicines,
    }) => 
        AllMedicinsModel(
            success: success ?? this.success,
            message: message ?? this.message,
            medicines: medicines ?? this.medicines,
        );

    factory AllMedicinsModel.fromJson(Map<String, dynamic> json) => AllMedicinsModel(
        success: json["success"],
        message: json["message"],
        medicines: json["medicines"] == null ? [] : List<MedicineElement>.from(json["medicines"]!.map((x) => MedicineElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "medicines": medicines == null ? [] : List<dynamic>.from(medicines!.map((x) => x.toJson())),
    };
}

class MedicineElement {
    MedicineMedicine? medicine;
    String? id;
    DateTime? updatedAt;

    MedicineElement({
        this.medicine,
        this.id,
        this.updatedAt,
    });

    MedicineElement copyWith({
        MedicineMedicine? medicine,
        String? id,
        DateTime? updatedAt,
    }) => 
        MedicineElement(
            medicine: medicine ?? this.medicine,
            id: id ?? this.id,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory MedicineElement.fromJson(Map<String, dynamic> json) => MedicineElement(
        medicine: json["medicine"] == null ? null : MedicineMedicine.fromJson(json["medicine"]),
        id: json["_id"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "medicine": medicine?.toJson(),
        "_id": id,
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class MedicineMedicine {
    Dosage? dosage;
    Schedule? schedule;
    String? name;
    String? instructions;
    bool? isActive;

    MedicineMedicine({
        this.dosage,
        this.schedule,
        this.name,
        this.instructions,
        this.isActive,
    });

    MedicineMedicine copyWith({
        Dosage? dosage,
        Schedule? schedule,
        String? name,
        String? instructions,
        bool? isActive,
    }) => 
        MedicineMedicine(
            dosage: dosage ?? this.dosage,
            schedule: schedule ?? this.schedule,
            name: name ?? this.name,
            instructions: instructions ?? this.instructions,
            isActive: isActive ?? this.isActive,
        );

    factory MedicineMedicine.fromJson(Map<String, dynamic> json) => MedicineMedicine(
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
