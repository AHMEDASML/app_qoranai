import 'package:Al_Arqam/view/Map/map_screen.dart';
import 'package:Al_Arqam/view/about_us/about_us_screen.dart';
import 'package:Al_Arqam/view/ask_camping_mufti/ask_camping_mufti_view.dart';
import 'package:Al_Arqam/view/camping/my_camping/my_camping_view.dart';
import 'package:Al_Arqam/view/hajj_rituals/amraa_rituals_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/etiquettes_guidelines_screen.dart';
import 'package:Al_Arqam/view/hajj_rituals/hajj_rituals_screen.dart';
import 'package:Al_Arqam/view/home_view.dart';
import 'package:Al_Arqam/view/miqat/miqat_screen.dart';
import 'package:Al_Arqam/view/prohibitions/prohibition_of_ihram_screen.dart';

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:Al_Arqam/view/auth/confirm_email/confirm_email_screen.dart';
import 'package:Al_Arqam/view/auth/login/login_screen.dart';
import 'package:Al_Arqam/view/auth/reset_password/reset_password_screen.dart';
import 'package:Al_Arqam/view/auth/sign_up/sign_up_screen.dart';
import 'package:Al_Arqam/view/auth/verfication_code/verfication_code_screen.dart';

import 'package:Al_Arqam/view/compass/compass_screen.dart';
import 'package:Al_Arqam/view/crowading/crowading_screen.dart';
import 'package:Al_Arqam/view/into/intro_screen.dart';
import 'package:Al_Arqam/view/main/main_screen.dart';
import 'package:Al_Arqam/view/medicine_reminder/medicin_reminder_details.dart';
import 'package:Al_Arqam/view/medicine_reminder/medicine_reminder_screen.dart';
import 'package:Al_Arqam/view/quran/chapters_page.dart';
import 'package:Al_Arqam/view/quran/juzs_page.dart';
import 'package:Al_Arqam/view/quran/verses_page.dart';
import 'package:Al_Arqam/view/qustions/mufti_question/mufti_question_screen.dart';
import 'package:Al_Arqam/view/recorded%20_supplications/recorded_supplications_screen.dart';
import 'package:Al_Arqam/view/splash/splash_screen.dart';
import 'package:Al_Arqam/view/tawaf_count/tawaf_count_screen.dart';

import '../../view/home/home_screen.dart';
import '../../view/quran/quran_notes.dart';

class AppRoutesPath {
  // static const String splashRoute = "/";
  static const String homeRoute = "/homeRoute";
  static const String mainRoute = "/mainScreen";
  static const String loginRoute = "/login";
  static const String signUpRoute = "/signUpRoute";
  static const String verficationCodeRoute = "/verficationCodeRoute";
  static const String confirmEmailRoute = "/confirmEmailRoute";
  static const String resetPasswordRoute = "/resetPasswordRoute";
   static const String CustomGoogleMap = "/CustomGoogleMap";
  static const String introRoute = "/introRoute";
  static const String splashRoute = "/splashRoute";
  static const String compassRoute = "/compassRoute";
  static const String crowadingRoute = "/crowadingRoute";
  static const String muftiQuestionRoute = "/muftiQuestionRoute";
  static const String trackingRoute = "/trackingRoute";
  static const String quranRoute = "/quranRoute";
  static const String profileRoute = "/profileRoute";
  static const String juzsRoute = "/juzsRoute";
  static const String chaptersRoute = "/chaptersRoute";
  static const String versesRoute = "/versesRoute";
  static const String quranNotesRoute = "/quranNotesRoute";
  static const String recordedSupplicationsRoute =
      "/recordedSupplicationsRoute";
static const String miqatscreen =
      "/miqatscreen";
  static const String privacyRoute = "/privacyScreen";
  static const String aboutUsRoute = "/aboutUsScreen";
  static const String medicinereminderRoute = "/medicinereminderRoute";
  static const String medicinereminderDetailsRoute =
      "/medicinereminderDetailsRoute";
static const String AmraaRitualsScreen = "/AmraaRitualsScreen";
  static const String myCampingRoute = "/myCampingRoute";
   static const String askCampingMufti = "/askCampingMufti";
  static const String campingStepDetailsRoute = "/campingStepDetailsScreen";
  static const String Al_ArqamRitualsRoute = "/Al_ArqamRitualsScreen";
  static const String tawafCountRoute = "/tawafCountScreen";
   static const String prohibitionofihramscreen = "/prohibitionofihramscreen";
   static const String etiquettesguidelinesscreen = "/etiquettesguidelinesscreen";
}

// Update with your actual import

class AppRouter {
  static List<GetPage> getRoutes() {
    return [
      GetPage(
        name: AppRoutesPath.homeRoute,
        page: () => const HomeView(),
      ),
       GetPage(
        name: AppRoutesPath.etiquettesguidelinesscreen,
        page: () =>  EtiquettesGuidelinesScreen(),
      ),
       GetPage(
        name: AppRoutesPath.prohibitionofihramscreen,
        page: () =>  ProhibitionOfIhramScreen(),
      ),
       GetPage(
        name: AppRoutesPath.aboutUsRoute,
        page: () => const AboutUsScreen(),
      ),
      GetPage(
        name: AppRoutesPath.AmraaRitualsScreen,
        page: () =>  AmraaRitualsScreen(),
      ),
       GetPage(
        name: AppRoutesPath.miqatscreen,
        page: () =>  MiqatScreen(),
      ),
      GetPage(
        name: AppRoutesPath.CustomGoogleMap,
        page: () => const CustomGoogleMap(),
      ),
       GetPage(
        name: AppRoutesPath.askCampingMufti,
        page: () => const AskCampingMuftiView(),
      ),
      GetPage(
        name: AppRoutesPath.mainRoute,
        page: () => MainScreen(),
      ),
      GetPage(
        name: AppRoutesPath.loginRoute,
        page: () => const LoginScreen(),
      ),
      GetPage(
        name: AppRoutesPath.signUpRoute,
        page: () => const SignUpScreen(),
      ),
      GetPage(
        name: AppRoutesPath.verficationCodeRoute,
        page: () => const VerficationCodeScreen(),
      ),
      GetPage(
        name: AppRoutesPath.confirmEmailRoute,
        page: () => const ConfirmEmailScreen(),
      ),
      GetPage(
        name: AppRoutesPath.resetPasswordRoute,
        page: () => const ResetPasswordScreen(),
      ),
      GetPage(
        name: AppRoutesPath.crowadingRoute,
        page: () => const CrowadingScreen(), // Using GetPage for CrowadingScreen
      ),
      GetPage(
        name: AppRoutesPath.introRoute,
        page: () => const IntroScreen(),
      ),
      GetPage(
        name: AppRoutesPath.splashRoute,
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: AppRoutesPath.compassRoute,
        page: () => const CompassScreen(),
      ),
      GetPage(
        name: AppRoutesPath.medicinereminderRoute,
        page: () => const MedicineReminderScreen(),
      ),
      GetPage(
        name: AppRoutesPath.medicinereminderDetailsRoute,
        page: () => const MedicinReminderDetailsScreen(),
      ),
      // GetPage(
      //   name: AppRoutesPath.muftiQuestionRoute,
      //   page: () => const MuftiQuestionScreen(),
      // ),
      GetPage(
        name: AppRoutesPath.myCampingRoute,
        page: () => const MyCampingView(),
      ),
      GetPage(
        name: AppRoutesPath.recordedSupplicationsRoute,
        page: () => const RecordedSupplicationsScreen(),
      ),
      GetPage(
        name: AppRoutesPath.Al_ArqamRitualsRoute,
        page: () => const HajjRitualsScreen(),
      ),
      GetPage(
        name: AppRoutesPath.tawafCountRoute,
        page: () => const TawafCountScreen(),
      ),
      GetPage(
        name: AppRoutesPath.juzsRoute,
        page: () => const JuzsScreen(),
      ),
      GetPage(
        name: AppRoutesPath.chaptersRoute,
        page: () => const ChaptersScreen(),
      ),
      GetPage(
        name: AppRoutesPath.versesRoute,
        page: () => const VersesScreen(),
      ),
      GetPage(
        name: AppRoutesPath.quranNotesRoute,
        page: () => const QuranNotes(),
      ),
    ];
  }
}