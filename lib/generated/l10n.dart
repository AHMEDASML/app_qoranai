// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Do you already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Do you already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Citizen`
  String get citizen {
    return Intl.message(
      'Citizen',
      name: 'citizen',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the full verification code`
  String get completeCode {
    return Intl.message(
      'Please enter the full verification code',
      name: 'completeCode',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get confirmButton {
    return Intl.message(
      'Reset',
      name: 'confirmButton',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get Continue {
    return Intl.message(
      'Continue',
      name: 'Continue',
      desc: '',
      args: [],
    );
  }

  /// `How would you prefer to use the app?`
  String get chooseUsagePreference {
    return Intl.message(
      'How would you prefer to use the app?',
      name: 'chooseUsagePreference',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordHint {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Continue as Guest`
  String get continueAsGuest {
    return Intl.message(
      'Continue as Guest',
      name: 'continueAsGuest',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailHint {
    return Intl.message(
      'Email',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Email or Phone Number`
  String get emailOrPhoneHint {
    return Intl.message(
      'Email or Phone Number',
      name: 'emailOrPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email or phone number`
  String get emailOrPhoneValidation {
    return Intl.message(
      'Please enter your email or phone number',
      name: 'emailOrPhoneValidation',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code sent to your email`
  String get enterCodeEmail {
    return Intl.message(
      'Enter the code sent to your email',
      name: 'enterCodeEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code sent to your phone`
  String get enterCodePhone {
    return Intl.message(
      'Enter the code sent to your phone',
      name: 'enterCodePhone',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullNameHint {
    return Intl.message(
      'Full Name',
      name: 'fullNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get invalidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get invalidPhone {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'invalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Legal Status`
  String get legalStatus {
    return Intl.message(
      'Legal Status',
      name: 'legalStatus',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login was successful`
  String get loginSuccess {
    return Intl.message(
      'Login was successful',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPasswordHint {
    return Intl.message(
      'New Password',
      name: 'newPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get noAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get orText {
    return Intl.message(
      'Or',
      name: 'orText',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordHint {
    return Intl.message(
      'Password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Please make sure the passwords match`
  String get passwordMismatchError {
    return Intl.message(
      'Please make sure the passwords match',
      name: 'passwordMismatchError',
      desc: '',
      args: [],
    );
  }

  /// `973+  |  Phone Number`
  String get phoneHint {
    return Intl.message(
      '973+  |  Phone Number',
      name: 'phoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Population Number`
  String get populationNumberHint {
    return Intl.message(
      'Population Number',
      name: 'populationNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message(
      'Resend Code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while resending the code`
  String get resendCodeFailure {
    return Intl.message(
      'An error occurred while resending the code',
      name: 'resendCodeFailure',
      desc: '',
      args: [],
    );
  }

  /// `The code was sent successfully`
  String get resendCodeSuccess {
    return Intl.message(
      'The code was sent successfully',
      name: 'resendCodeSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Password reset was successful`
  String get resetPasswordSuccess {
    return Intl.message(
      'Password reset was successful',
      name: 'resetPasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Resident`
  String get resident {
    return Intl.message(
      'Resident',
      name: 'resident',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `The operation was successful`
  String get successMessage {
    return Intl.message(
      'The operation was successful',
      name: 'successMessage',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred during verification`
  String get verificationFailure {
    return Intl.message(
      'An error occurred during verification',
      name: 'verificationFailure',
      desc: '',
      args: [],
    );
  }

  /// `Verification was successful`
  String get verificationSuccess {
    return Intl.message(
      'Verification was successful',
      name: 'verificationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Verification`
  String get verificationTitle {
    return Intl.message(
      'Verification',
      name: 'verificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Visitor`
  String get visitor {
    return Intl.message(
      'Visitor',
      name: 'visitor',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address or phone number`
  String get validEmailOrPhone {
    return Intl.message(
      'Please enter a valid email address or phone number',
      name: 'validEmailOrPhone',
      desc: '',
      args: [],
    );
  }

  /// `The field is empty! Please enter a value..`
  String get validateEmail_empty {
    return Intl.message(
      'The field is empty! Please enter a value..',
      name: 'validateEmail_empty',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get validateEmail_invalid {
    return Intl.message(
      'Enter a valid email address',
      name: 'validateEmail_invalid',
      desc: '',
      args: [],
    );
  }

  /// `The field is empty! Please enter a value..`
  String get validatePassword_empty {
    return Intl.message(
      'The field is empty! Please enter a value..',
      name: 'validatePassword_empty',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long.`
  String get validatePassword_short {
    return Intl.message(
      'Password must be at least 8 characters long.',
      name: 'validatePassword_short',
      desc: '',
      args: [],
    );
  }

  /// `The field is empty! Please enter a value..`
  String get valid_empty {
    return Intl.message(
      'The field is empty! Please enter a value..',
      name: 'valid_empty',
      desc: '',
      args: [],
    );
  }

  /// `Characters cannot be smaller than `
  String get valid_tooShort {
    return Intl.message(
      'Characters cannot be smaller than ',
      name: 'valid_tooShort',
      desc: '',
      args: [],
    );
  }

  /// `Characters cannot be greater than `
  String get valid_tooLong {
    return Intl.message(
      'Characters cannot be greater than ',
      name: 'valid_tooLong',
      desc: '',
      args: [],
    );
  }

  /// `The field is empty! Please enter a value..`
  String get validPhoneNumber_empty {
    return Intl.message(
      'The field is empty! Please enter a value..',
      name: 'validPhoneNumber_empty',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid phone number`
  String get validPhoneNumber_invalid {
    return Intl.message(
      'Enter a valid phone number',
      name: 'validPhoneNumber_invalid',
      desc: '',
      args: [],
    );
  }

  /// `The field is empty! Please enter a value..`
  String get isValidPopulationNumber_empty {
    return Intl.message(
      'The field is empty! Please enter a value..',
      name: 'isValidPopulationNumber_empty',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid number`
  String get isValidPopulationNumber_invalid {
    return Intl.message(
      'Enter a valid number',
      name: 'isValidPopulationNumber_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid number`
  String get isValidPopulationNumber_length {
    return Intl.message(
      'Enter a valid number',
      name: 'isValidPopulationNumber_length',
      desc: '',
      args: [],
    );
  }

  /// `Ask the campaign mufti`
  String get askingMufti {
    return Intl.message(
      'Ask the campaign mufti',
      name: 'askingMufti',
      desc: '',
      args: [],
    );
  }

  /// `Fatwas`
  String get fatwas {
    return Intl.message(
      'Fatwas',
      name: 'fatwas',
      desc: '',
      args: [],
    );
  }

  /// `My questions`
  String get myQuestions {
    return Intl.message(
      'My questions',
      name: 'myQuestions',
      desc: '',
      args: [],
    );
  }

  /// `Enter text to search`
  String get enterTextToSearch {
    return Intl.message(
      'Enter text to search',
      name: 'enterTextToSearch',
      desc: '',
      args: [],
    );
  }

  /// `Ask a question`
  String get askQuestion {
    return Intl.message(
      'Ask a question',
      name: 'askQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Write your question here`
  String get writeQuestion {
    return Intl.message(
      'Write your question here',
      name: 'writeQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Send to the campaign mufti`
  String get sendToMufti {
    return Intl.message(
      'Send to the campaign mufti',
      name: 'sendToMufti',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `ok`
  String get ok {
    return Intl.message(
      'ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `No Data`
  String get noData {
    return Intl.message(
      'No Data',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Question has been deleted`
  String get deleteQuestion {
    return Intl.message(
      'Question has been deleted',
      name: 'deleteQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Modified successfully`
  String get updateQuestion {
    return Intl.message(
      'Modified successfully',
      name: 'updateQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Question added successfully`
  String get questionAddedSucc {
    return Intl.message(
      'Question added successfully',
      name: 'questionAddedSucc',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, but this feature is only available to people who already have an account.`
  String get sorry {
    return Intl.message(
      'Sorry, but this feature is only available to people who already have an account.',
      name: 'sorry',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
