import 'package:get_it/get_it.dart';
import 'package:Al_Arqam/view/quran/bloc/quran_bloc.dart';
import 'package:Al_Arqam/view/splash/bloc/splash_bloc.dart';

import 'view/localization/bloc/localization_bloc.dart';
import 'view/qustions/bloc/questions_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async => _appDependencies();

Future<void> _appDependencies() async {
  serviceLocator
      .registerLazySingleton<LocalizationBloc>(() => LocalizationBloc());

  // serviceLocator.registerLazySingleton<HomeBloc>(() => HomeBloc());
  serviceLocator.registerFactory<QuestionsBloc>(() => QuestionsBloc()); 
  serviceLocator.registerFactory<QuranBloc>(() => QuranBloc()); 
  serviceLocator.registerFactory<SplashBloc>(
    () => SplashBloc(),
  );
}
