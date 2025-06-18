// To parse this JSON data, do
//
//     final chapterModel = chapterModelFromJson(jsonString);
//https://api.quran.com/api/v4/chapters

import 'dart:convert';

ChapterModel chapterModelFromJson(String str) => ChapterModel.fromJson(json.decode(str));

String chapterModelToJson(ChapterModel data) => json.encode(data.toJson());

class ChapterModel {
    List<Chapter>? chapters;

    ChapterModel({
        this.chapters,
    });

    ChapterModel copyWith({
        List<Chapter>? chapters,
    }) => 
        ChapterModel(
            chapters: chapters ?? this.chapters,
        );

    factory ChapterModel.fromJson(Map<String, dynamic> json) => ChapterModel(
        chapters: json["chapters"] == null ? [] : List<Chapter>.from(json["chapters"]!.map((x) => Chapter.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "chapters": chapters == null ? [] : List<dynamic>.from(chapters!.map((x) => x.toJson())),
    };
}

class Chapter {
    int? id;
    RevelationPlace? revelationPlace;
    int? revelationOrder;
    bool? bismillahPre;
    String? nameSimple;
    String? nameComplex;
    String? nameArabic;
    int? versesCount;
    List<int>? pages;
    TranslatedName? translatedName;

    Chapter({
        this.id,
        this.revelationPlace,
        this.revelationOrder,
        this.bismillahPre,
        this.nameSimple,
        this.nameComplex,
        this.nameArabic,
        this.versesCount,
        this.pages,
        this.translatedName,
    });

    Chapter copyWith({
        int? id,
        RevelationPlace? revelationPlace,
        int? revelationOrder,
        bool? bismillahPre,
        String? nameSimple,
        String? nameComplex,
        String? nameArabic,
        int? versesCount,
        List<int>? pages,
        TranslatedName? translatedName,
    }) => 
        Chapter(
            id: id ?? this.id,
            revelationPlace: revelationPlace ?? this.revelationPlace,
            revelationOrder: revelationOrder ?? this.revelationOrder,
            bismillahPre: bismillahPre ?? this.bismillahPre,
            nameSimple: nameSimple ?? this.nameSimple,
            nameComplex: nameComplex ?? this.nameComplex,
            nameArabic: nameArabic ?? this.nameArabic,
            versesCount: versesCount ?? this.versesCount,
            pages: pages ?? this.pages,
            translatedName: translatedName ?? this.translatedName,
        );

    factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        revelationPlace: revelationPlaceValues.map[json["revelation_place"]]!,
        revelationOrder: json["revelation_order"],
        bismillahPre: json["bismillah_pre"],
        nameSimple: json["name_simple"],
        nameComplex: json["name_complex"],
        nameArabic: json["name_arabic"],
        versesCount: json["verses_count"],
        pages: json["pages"] == null ? [] : List<int>.from(json["pages"]!.map((x) => x)),
        translatedName: json["translated_name"] == null ? null : TranslatedName.fromJson(json["translated_name"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "revelation_place": revelationPlaceValues.reverse[revelationPlace],
        "revelation_order": revelationOrder,
        "bismillah_pre": bismillahPre,
        "name_simple": nameSimple,
        "name_complex": nameComplex,
        "name_arabic": nameArabic,
        "verses_count": versesCount,
        "pages": pages == null ? [] : List<dynamic>.from(pages!.map((x) => x)),
        "translated_name": translatedName?.toJson(),
    };
}

enum RevelationPlace {
    MADINAH,
    MAKKAH
}

final revelationPlaceValues = EnumValues({
    "madinah": RevelationPlace.MADINAH,
    "makkah": RevelationPlace.MAKKAH
});

class TranslatedName {
    LanguageName? languageName;
    String? name;

    TranslatedName({
        this.languageName,
        this.name,
    });

    TranslatedName copyWith({
        LanguageName? languageName,
        String? name,
    }) => 
        TranslatedName(
            languageName: languageName ?? this.languageName,
            name: name ?? this.name,
        );

    factory TranslatedName.fromJson(Map<String, dynamic> json) => TranslatedName(
        languageName: languageNameValues.map[json["language_name"]]!,
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "language_name": languageNameValues.reverse[languageName],
        "name": name,
    };
}

enum LanguageName {
    ENGLISH
}

final languageNameValues = EnumValues({
    "english": LanguageName.ENGLISH
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
