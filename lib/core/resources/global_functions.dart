
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Al_Arqam/core/resources/text/text12.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../generated/l10n.dart';
import 'app_boxs_name.dart';
import 'pref_keys.dart';

class GlobalFunctions {
  GlobalFunctions._();
   static Future<void> setFirstOnce(bool isFirst) async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.put("firstOnce", isFirst);
  }
  static bool getFirstOnce()  {
     Box localBox = Hive.box(AppBox.configBox);
    return  localBox.get("firstOnce")??false;
  }
  static Future<void> setLat(double lat) async {
  Box localBox = Hive.box(AppBox.configBox);
  await localBox.put("lat", lat);
}

static double getLat() {
  Box localBox = Hive.box(AppBox.configBox);
  return localBox.get("lat") ?? 0.0;
}

static Future<void> setLng(double lng) async {
  Box localBox = Hive.box(AppBox.configBox);
  await localBox.put("lng", lng);
}

static double getLng() {
  Box localBox = Hive.box(AppBox.configBox);
  return localBox.get("lng") ?? 0.0;
}
static bool hasValidLocation() {
  double lat = getLat();
  double lng = getLng();
  return lat != 0.0 && lng != 0.0;
}
  static Future<void> setNotificationCount(int count) async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.put("notificationCount", count);
  }
  static int getNotificationCount()  {
     Box localBox = Hive.box(AppBox.configBox);
    return  localBox.get("notificationCount")??0;
  }
  static Future<void> setShowCase(bool show) async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.put("showCase", show);
  }
  static bool getShowCase()  {
     Box localBox = Hive.box(AppBox.configBox);
    return  localBox.get("showCase")??false;
  }
  static String? getLangCode() {
    Box localBox = Hive.box<String>(AppBox.localBox);
    String? langCode = localBox.get("lang");
    return langCode??'ar';
  }

  static Future<void> setLanguageCode(String langCode) async {
    Box localBox = Hive.box<String>(AppBox.localBox);
    await localBox.put("lang", langCode);
  }

  static Future<void> setVerifictionCode(String code) async {
    Box codebox = Hive.box(AppBox.configBox);
    await codebox.put("codeVerify", code.toString());
  }

  static String getVerificatonCode()  {
    Box localBox = Hive.box(AppBox.configBox);
    String? code =  localBox.get("codeVerify");
    return code!;
  }
static Future<void> removeVerfication() async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.delete("codeVerify");
  }
  static bool isAuth() {
    Box localBox = Hive.box(AppBox.configBox);
    bool isauth = localBox.containsKey(PrefKeys.token);
  
    return isauth;
  }

  // static bool isAuthToken() {
  //   Box localBox = Hive.box(AppBox.configBox);
  //   bool isauth = localBox.get(PrefKeys.token);
  //   return isauth;
  // }
  static bool isFirstOpen() {
    Box localBox = Hive.box(AppBox.configBox);
    bool isFirstOpen = localBox.containsKey(PrefKeys.firstOpen);
    return isFirstOpen;
  }

  static bool isVisitor() {
    Box localBox = Hive.box(AppBox.configBox);
    bool isVisitor = localBox.containsKey(PrefKeys.visitorUser);
    return isVisitor;
  }

  static void clear() {
    Box localBox = Hive.box(AppBox.configBox);
    localBox.clear();
  }

  static Future<void> setVisitorAuth() async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.put(PrefKeys.visitorUser, true);
  }

  static Future<void> setShowOnBoarding() async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.put(PrefKeys.firstOpen, true);
  }

  static Future<String?> getToken() async {
    Box localBox = Hive.box(AppBox.configBox);
    String? token = await localBox.get(PrefKeys.token);
    return token;
  }

  static Future<void> setToken(String token) async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.put(PrefKeys.token, token);
  }

  static Future<void> removeToken() async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.delete(PrefKeys.token);
  }
   static String getUsername()  {
    Box localBox = Hive.box(AppBox.configBox);
    return  localBox.get(PrefKeys.name);
  }

  static Future<void> setUsername(String username) async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.put(PrefKeys.name, username);
  }

  static Future<void> removeUsername() async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.delete(PrefKeys.name);
  }

  static String getEmail()  {
    Box localBox = Hive.box(AppBox.configBox);
    return  localBox.get(PrefKeys.email);
  }

  static Future<void> setEmail(String email) async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.put(PrefKeys.email, email);
  }

  static Future<void> removeEmail() async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.delete(PrefKeys.email);
  }

    static String? getIdCode()  {
    Box localBox = Hive.box(AppBox.configBox);
    return  localBox.get(PrefKeys.idcode);
  }

  static Future<void> setIdCode(String? idCode) async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.put(PrefKeys.idcode, idCode);
  }

  static Future<void> removeIdCode() async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.delete(PrefKeys.idcode);
  }

  static String getLegalStatus()  {
    Box localBox = Hive.box(AppBox.configBox);
    return  localBox.get(PrefKeys.status);
  }

  static Future<void> setLegalStatus(String legalStatus) async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.put(PrefKeys.status, legalStatus);
  }

  static Future<void> removeLegalStatus() async {
    Box localBox = Hive.box(AppBox.configBox);
    await localBox.delete(PrefKeys.status);
  }
  //TODO============================Quran Note===============

  static Future<void> deleteNote(String noteId) async {
    Box localBox = Hive.box(AppBox.quranNotesBox);
    await localBox.delete(noteId);
  }

  static Future<void> setNote(String note) async {
    Box localBox = Hive.box(AppBox.quranNotesBox);
    String key = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); // مفتاح فريد بناءً على الوقت
    await localBox.put(key, note);
  }

  static Future<List<String>> getAllNote() async {
    Box localBox = Hive.box(AppBox.quranNotesBox);
    List<MapEntry<int, String>> sortedEntries = localBox
        .toMap()
        .entries
        .map((e) => MapEntry(int.parse(e.key.toString()), e.value.toString()))
        .toList()
      ..sort(
          (a, b) => b.key.compareTo(a.key)); // ترتيب تنازلي حسب الطابع الزمني

    return sortedEntries.map((e) => e.value).toList();
  }

  static Future<List<String>> getAllNoteId() async {
    Box localBox = Hive.box(AppBox.quranNotesBox);
    List<int> sortedKeys = localBox.keys
        .map((e) => int.parse(e.toString())) // تحويل المفاتيح إلى أرقام
        .toList()
      ..sort((a, b) => b.compareTo(a)); // ترتيب تنازلي حسب الطابع الزمني

    return sortedKeys.map((e) => e.toString()).toList();
  }

  static String? validateEmail(String? value, BuildContext context) {
    const pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final regex = RegExp(pattern);

    return value == ""
        ? S.of(context).validateEmail_empty
        : !regex.hasMatch(value!)
            ? S.of(context).validateEmail_invalid
            : null;
  }

  static String? validatePassword(String? password, BuildContext context) {
    if (password == "") {
      return S.of(context).validatePassword_empty;
    }

    String errorMessage = '';
    if (password!.length < 8) {
      errorMessage += S.of(context).validatePassword_short;
    }

    return errorMessage.isNotEmpty ? errorMessage : null;
  }

  static valid(String val, int min, int max, BuildContext context) {
    if (val == "") {
      return S.of(context).valid_empty;
    }
    if (val.length < min) {
      return S.of(context).valid_tooShort.replaceAll("{min}", min.toString());
    }
    if (val.length > max) {
      return S.of(context).valid_tooLong.replaceAll("{max}", max.toString());
    }
  }

  static String? validPhoneNumber(String phoneNumber, BuildContext context) {
    if (phoneNumber == "") {
      return S.of(context).validPhoneNumber_empty;
    }
    RegExp regex =
        RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$');

    return !regex.hasMatch(phoneNumber)
        ? S.of(context).validPhoneNumber_invalid
        : null;
  }

  static String? isValidPopulationNumber(String input, BuildContext context) {
    if (input.isEmpty) {
      return S.of(context).isValidPopulationNumber_empty;
    }

    final regex = RegExp(r'^\d+$');
    if (!regex.hasMatch(input)) {
      return S.of(context).isValidPopulationNumber_invalid;
    }

    if (input.length != 9 && input.length != 12) {
      return S.of(context).isValidPopulationNumber_length;
    }

    return null;
  }

  static showLoading(Color color,{double? size}) {
    return SizedBox(
      child: SpinKitThreeBounce(
        color: color,
        size:size?? 16.0,
      ),
    );
  }

  static showError(BuildContext context,
      {String msg = "Something went wrong"}) {
    return Container(
        height: ScreenUtil().screenHeight - 180,
        alignment: Alignment.center,
        child: Text12(
          text: msg,
        ));
  }
}
