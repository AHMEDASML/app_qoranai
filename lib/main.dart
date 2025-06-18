import 'dart:developer';

import 'package:Al_Arqam/controllers/language/language_controller.dart';
import 'package:Al_Arqam/translations/messages_ar.dart';
import 'package:Al_Arqam/translations/messages_en.dart';
import 'package:Al_Arqam/view/hajj_rituals/controller/hajj_rituals_controller.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:devicelocale/devicelocale.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:Al_Arqam/core/config/flutter_local_notification_config.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/view/main_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/resources/app_boxs_name.dart';
import 'core/resources/color_manager.dart';
import 'core/resources/routes_manager.dart';
import 'core/resources/values_manager.dart';
import 'generated/l10n.dart';
import 'injection.dart' as di;
import 'injection.dart';
import 'view/home/bloc/home_bloc.dart';
import 'view/localization/bloc/localization_bloc.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  try {
    // التأكد من تهيئة Flutter
    WidgetsFlutterBinding.ensureInitialized();

    // تهيئة Hive
    await Hive.initFlutter();

    // تهيئة الإشعارات مع معالجة للأخطاء
    try {
      await NotificationService().init();
      log('Notifications initialized successfully');
    } catch (e) {
      log('Failed to initialize notifications: $e');
      // التطبيق سيعمل بدون إشعارات
    }

    // تهيئة dependency injection
    await di.init();

    // فتح صناديق Hive
    await Hive.openBox<String>(AppBox.localBox);
    await Hive.openBox(AppBox.configBox);
    await Hive.openBox(AppBox.notificationBox);
    await Hive.openBox(AppBox.quranNotesBox);

    // الحصول على التوكن
    var token = await GlobalFunctions.getToken();
    log(token ?? "No token found");

    // الحصول على اللغة الحالية للجهاز
    Locale? lang = await Devicelocale.currentAsLocale;

    // تهيئة الكنترولرز
    Get.put(LanguageController());
    Get.put(MainController());
    Get.put(HajjRitualsController());

    // تشغيل التطبيق
    runApp(MyApp(
      lang: lang ?? const Locale('en', 'US'), // fallback locale
    ));

    // تعيين اتجاه الشاشة
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

  } catch (e) {
    log('Error in main: $e');
    // في حالة فشل التهيئة، تشغيل تطبيق بسيط مع رسالة خطأ
    runApp(const ErrorApp());
  }
}

class MyApp extends StatefulWidget {
  final Locale lang;
  const MyApp({super.key, required this.lang});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late LocalizationBloc blocLocal;

  @override
  void initState() {
    super.initState();

    try {
      blocLocal = serviceLocator<LocalizationBloc>()
        ..add(InitializeLanguageEvent());

      // تعيين شريط الحالة
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
    } catch (e) {
      log('Error initializing app: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => blocLocal,
        ),
      ],
      child: ScreenUtilInit(
        designSize: kDesignSize,
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        child: BlocBuilder<LocalizationBloc, LocalizationState>(
          builder: (context, state) {
            return GetMaterialApp(
              translationsKeys: {'en': en, 'ar': ar},
              locale: Get.find<LanguageController>().locale,
              fallbackLocale: const Locale('en', 'US'),
              navigatorKey: navigatorKey,
              title: 'Al Arqam',
              theme: ThemeData(
                fontFamily: 'NotoKufiArabic',
                scaffoldBackgroundColor: AppColors.whiteBackground,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
              ),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              builder: BotToastInit(),
              supportedLocales: S.delegate.supportedLocales,
              initialRoute: AppRoutesPath.splashRoute,
              getPages: AppRouter.getRoutes(),
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}

// تطبيق بسيط لعرض رسالة خطأ في حالة فشل التهيئة
class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                'حدث خطأ في تهيئة التطبيق',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                'يرجى إعادة تشغيل التطبيق',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}