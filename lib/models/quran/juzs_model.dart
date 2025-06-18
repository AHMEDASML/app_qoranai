// To parse this JSON data, do
//
//     final juzsModel = juzsModelFromJson(jsonString);
//https://api.quran.com/api/v4/juzs

import 'dart:convert';

JuzsModel juzsModelFromJson(String str) => JuzsModel.fromJson(json.decode(str));

String juzsModelToJson(JuzsModel data) => json.encode(data.toJson());

class JuzsModel {
    List<Juz>? juzs;

    JuzsModel({
        this.juzs,
    });

    JuzsModel copyWith({
        List<Juz>? juzs,
    }) => 
        JuzsModel(
            juzs: juzs ?? this.juzs,
        );

    factory JuzsModel.fromJson(Map<String, dynamic> json) => JuzsModel(
        juzs: json["juzs"] == null ? [] : List<Juz>.from(json["juzs"]!.map((x) => Juz.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "juzs": juzs == null ? [] : List<dynamic>.from(juzs!.map((x) => x.toJson())),
    };
}

class Juz {
    int? id;
    int? juzNumber;
    Map<String, String>? verseMapping;
    int? firstVerseId;
    int? lastVerseId;
    int? versesCount;

    Juz({
        this.id,
        this.juzNumber,
        this.verseMapping,
        this.firstVerseId,
        this.lastVerseId,
        this.versesCount,
    });

    Juz copyWith({
        int? id,
        int? juzNumber,
        Map<String, String>? verseMapping,
        int? firstVerseId,
        int? lastVerseId,
        int? versesCount,
    }) => 
        Juz(
            id: id ?? this.id,
            juzNumber: juzNumber ?? this.juzNumber,
            verseMapping: verseMapping ?? this.verseMapping,
            firstVerseId: firstVerseId ?? this.firstVerseId,
            lastVerseId: lastVerseId ?? this.lastVerseId,
            versesCount: versesCount ?? this.versesCount,
        );

    factory Juz.fromJson(Map<String, dynamic> json) => Juz(
        id: json["id"],
        juzNumber: json["juz_number"],
        verseMapping: Map.from(json["verse_mapping"]!).map((k, v) => MapEntry<String, String>(k, v)),
        firstVerseId: json["first_verse_id"],
        lastVerseId: json["last_verse_id"],
        versesCount: json["verses_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "juz_number": juzNumber,
        "verse_mapping": Map.from(verseMapping!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "first_verse_id": firstVerseId,
        "last_verse_id": lastVerseId,
        "verses_count": versesCount,
    };
}
