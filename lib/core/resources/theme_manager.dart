import 'package:flutter/material.dart';


abstract class MainThemeApp {
  late ThemeData themeData;
}

// class LightModeTheme implements MainThemeApp {
  // @override
//   ThemeData themeData = ThemeData(
//     primaryColor: AppColors.colorPrimaryLight,
//     cardColor: AppColors.colorCardLight,
//     scaffoldBackgroundColor: AppColors.colorBackgroundLight,
//     disabledColor: AppColors.grey1,
//     splashColor: AppColors.colorSplash,

//     // Text color
//     primaryColorLight: AppColors.colorFontPrimaryLight,
//     primaryColorDark: AppColors.colorFontSecondaryLight,

//     hintColor: AppColors.colorPlaceHolderLight,

//     shadowColor: AppColors.colorBackgroundDark,

//     fontFamily: FontConstants.fontDMSans,

//     bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       backgroundColor: AppColors.colorBackgroundLight,
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: AppColors.colorPrimaryLight,
//       unselectedItemColor: AppColors.black,
//     ),

//     appBarTheme: AppBarTheme(
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         iconTheme: IconThemeData(
//             color: AppColors.colorFontPrimaryLight, size: AppSize.s20),
//         titleTextStyle: getMediumStyle(
//             fontSize: FontSize.s18, color: AppColors.colorFontPrimaryLight)),

//     // input decoration theme (text form field)
//     inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: AppColors.colorTextFieldLight,
//         contentPadding: const EdgeInsets.symmetric(
//             horizontal: AppPadding.p16, vertical: AppPadding.p20),
//         // hint style
//         hintStyle: getRegularStyle(color: AppColors.colorPlaceHolderLight),
//         labelStyle: getMediumStyle(color: AppColors.colorFontPrimaryLight),
//         errorStyle: getRegularStyle(color: AppColors.error),

//         // enabled border style
//         enabledBorder: const OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: Colors.transparent, width: AppSize.s1_5),
//             borderRadius: BorderRadius.all(Radius.circular(AppSize.s10))),

//         // focused border style
//         focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//                 color: AppColors.colorPrimaryLight, width: AppSize.s1_5),
//             borderRadius: const BorderRadius.all(Radius.circular(AppSize.s10))),

//         // error border style
//         errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppColors.error, width: AppSize.s1_5),
//             borderRadius: const BorderRadius.all(Radius.circular(AppSize.s10))),
//         // focused border style
//         focusedErrorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//                 color: AppColors.colorPrimaryLight, width: AppSize.s1_5),
//             borderRadius:
//                 const BorderRadius.all(Radius.circular(AppSize.s10)))),
//   );
// }

// class DarkModeTheme implements MainThemeApp {
//   @override
//   ThemeData themeData = ThemeData(
//     primaryColor: AppColors.colorPrimaryDark,
//     cardColor: AppColors.colorCardDark,
//     scaffoldBackgroundColor: AppColors.colorBackgroundDark,
//     disabledColor: AppColors.grey1,

    // input decoration theme (text form field)
    // inputDecorationTheme: InputDecorationTheme(
    //   // content padding
    //     contentPadding: const EdgeInsets.all(AppPadding.p8),
    //     // hint style
    //     hintStyle: getRegularStyle(
    //         color: AppColors.colorPlaceHolderLight, fontSize: FontSize.s14),
    //     labelStyle:
    //     getMediumStyle(color: AppColors.grey, fontSize: FontSize.s14),
    //     errorStyle: getRegularStyle(color: AppColors.error),
    //
    //     // enabled border style
    //     enabledBorder: OutlineInputBorder(
    //         borderSide:
    //         BorderSide(color: AppColors.colorGrey2, width: AppSize.s1_5),
    //         borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
    //
    //     // focused border style
    //     focusedBorder: OutlineInputBorder(
    //         borderSide:
    //         BorderSide(
    //             color: AppColors.colorPrimaryLight, width: AppSize.s1_5),
    //         borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
    //
    //     // error border style
    //     errorBorder: OutlineInputBorder(
    //         borderSide:
    //         BorderSide(color: AppColors.colorError, width: AppSize.s1_5),
    //         borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
    //     // focused border style
    //     focusedErrorBorder: OutlineInputBorder(
    //         borderSide:
    //         BorderSide(
    //             color: AppColors.colorPrimaryLight, width: AppSize.s1_5),
    //         borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)))),
//   );
// }

// ThemeData getApplicationTheme() {
//   return ThemeData(
//     // main colors
//     primaryColor: AppColors.primary,
//     primaryColorLight: AppColors.lightPrimary,
//     primaryColorDark: AppColors.darkPrimary,
//     disabledColor: AppColors.grey1,
//     splashColor: AppColors.lightPrimary,
//     // fontFamily: FontConstants.fontFamily,
//
//     // cardView theme
//     cardTheme: CardTheme(
//         color: AppColors.white,
//         shadowColor: AppColors.grey,
//         elevation: AppSize.s4),
//
//     // appBar theme
//     appBarTheme: AppBarTheme(
//         centerTitle: true,
//         color: AppColors.primary,
//         elevation: AppSize.s4,
//         shadowColor: AppColors.lightPrimary,
//         titleTextStyle: getRegularStyle(fontSize: FontSize.s16, color: AppColors.white)),
//
//     // button theme
//     buttonTheme: ButtonThemeData(
//         shape: const StadiumBorder(),
//         disabledColor: AppColors.grey1,
//         buttonColor: AppColors.primary,
//         splashColor: AppColors.lightPrimary),
//
//     // elevated button them
//     elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//             textStyle: getRegularStyle(color: AppColors.white, fontSize: FontSize.s17),
//             primary: AppColors.primary,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(AppSize.s12)))),
//
//     // text button them
//     textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(
//             textStyle: getMediumStyle(color: AppColors.primary, fontSize: FontSize.s16),
//             primary: AppColors.primary,
//             // splashFactory: NoSplash.splashFactory
//         )
//     ),
//
//     // text theme
//     textTheme: TextTheme(
//         displayLarge: getSemiBoldStyle(color: AppColors.darkGrey, fontSize: FontSize.s16),
//         headlineLarge: getSemiBoldStyle(color: AppColors.darkGrey, fontSize: FontSize.s16),
//         headlineMedium: getRegularStyle(color: AppColors.darkGrey, fontSize: FontSize.s14),
//         titleMedium: getMediumStyle(color: AppColors.primary, fontSize: FontSize.s16),
//         titleSmall: getRegularStyle(color: AppColors.white, fontSize: FontSize.s16),
//         bodyLarge: getRegularStyle(color: AppColors.grey1),
//         bodySmall: getRegularStyle(color: AppColors.grey),
//         bodyMedium: getRegularStyle(color: AppColors.grey2, fontSize: FontSize.s12),
//         labelSmall: getBoldStyle(color: AppColors.primary, fontSize: FontSize.s12)),
//
//     // input decoration theme (text form field)
//     inputDecorationTheme: InputDecorationTheme(
//         // content padding
//         contentPadding: const EdgeInsets.all(AppPadding.p8),
//         // hint style
//         hintStyle: getRegularStyle(color: AppColors.grey, fontSize: FontSize.s14),
//         labelStyle:
//             getMediumStyle(color: AppColors.grey, fontSize: FontSize.s14),
//         errorStyle: getRegularStyle(color: AppColors.error),
//
//         // enabled border style
//         enabledBorder: OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: AppColors.grey, width: AppSize.s1_5),
//             borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
//
//         // focused border style
//         focusedBorder: OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: AppColors.primary, width: AppSize.s1_5),
//             borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
//
//         // error border style
//         errorBorder: OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: AppColors.error, width: AppSize.s1_5),
//             borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
//         // focused border style
//         focusedErrorBorder: OutlineInputBorder(
//             borderSide:
//                 BorderSide(color: AppColors.primary, width: AppSize.s1_5),
//             borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)))),
//     // label style
//   );
// }
//

// enum AppTheme {
//   Light,
//   Dark
//   // GreenLight,
//   // GreenDark,
//   // BlueLight,
//   // BlueDark,
// }
