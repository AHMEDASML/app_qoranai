// To parse this JSON data, do
//
//     final versesModel = versesModelFromJson(jsonString);
//https://api.quran.com/api/v4/quran/verses/uthmani?juz_number=1&chapter_number=1
import 'dart:convert';

VersesModel versesModelFromJson(String str) => VersesModel.fromJson(json.decode(str));

String versesModelToJson(VersesModel data) => json.encode(data.toJson());

class VersesModel {
    List<Verse>? verses;
    Meta? meta;

    VersesModel({
        this.verses,
        this.meta,
    });

    VersesModel copyWith({
        List<Verse>? verses,
        Meta? meta,
    }) => 
        VersesModel(
            verses: verses ?? this.verses,
            meta: meta ?? this.meta,
        );

    factory VersesModel.fromJson(Map<String, dynamic> json) => VersesModel(
        verses: json["verses"] == null ? [] : List<Verse>.from(json["verses"]!.map((x) => Verse.fromJson(x))),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "verses": verses == null ? [] : List<dynamic>.from(verses!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
    };
}

class Meta {
    Filters? filters;

    Meta({
        this.filters,
    });

    Meta copyWith({
        Filters? filters,
    }) => 
        Meta(
            filters: filters ?? this.filters,
        );

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        filters: json["filters"] == null ? null : Filters.fromJson(json["filters"]),
    );

    Map<String, dynamic> toJson() => {
        "filters": filters?.toJson(),
    };
}

class Filters {
    String? juzNumber;
    String? chapterNumber;

    Filters({
        this.juzNumber,
        this.chapterNumber,
    });

    Filters copyWith({
        String? juzNumber,
        String? chapterNumber,
    }) => 
        Filters(
            juzNumber: juzNumber ?? this.juzNumber,
            chapterNumber: chapterNumber ?? this.chapterNumber,
        );

    factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        juzNumber: json["juz_number"],
        chapterNumber: json["chapter_number"],
    );

    Map<String, dynamic> toJson() => {
        "juz_number": juzNumber,
        "chapter_number": chapterNumber,
    };
}

class Verse {
    int? id;
    String? verseKey;
    String? textUthmani;

    Verse({
        this.id,
        this.verseKey,
        this.textUthmani,
    });

    Verse copyWith({
        int? id,
        String? verseKey,
        String? textUthmani,
    }) => 
        Verse(
            id: id ?? this.id,
            verseKey: verseKey ?? this.verseKey,
            textUthmani: textUthmani ?? this.textUthmani,
        );

    factory Verse.fromJson(Map<String, dynamic> json) => Verse(
        id: json["id"],
        verseKey: json["verse_key"],
        textUthmani: json["text_uthmani"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "verse_key": verseKey,
        "text_uthmani": textUthmani,
    };
}
