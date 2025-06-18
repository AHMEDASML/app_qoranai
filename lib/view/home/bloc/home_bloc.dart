// import 'dart:async';
// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:Al_Arqam/controllers/home/prayer_times_controller.dart';
// import 'package:Al_Arqam/core/app/params/home/prayers_params.dart';
// import 'package:Al_Arqam/models/home/prayer_times_model.dart';
// import 'package:meta/meta.dart';

// import '../../../core/network/network_info.dart';

// part 'home_event.dart';
// part 'home_state.dart';

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   final prayerTimesController = PrayerTimesController();
//   HomeBloc() : super(HomeState()) {
//     on<HomeEvent>((event, emit) {});

//     on<GetPrayerTimes>(_getPrayerTimes);
//   }
//   FutureOr<void> _getPrayerTimes(
//       GetPrayerTimes event, Emitter<HomeState> emit) async {
//     var connection = await checkRealConnection();
//     if (connection) {
//       emit(state.copyWith(prayerTimesStatus: PrayerTimesStatus.load));
//       var result = await prayerTimesController
//           .getPrayerTimes(event.prayersParams.getParams());
//       result.fold(
//         (failure) {
//           emit(state.copyWith(
//               massegeErrorPrayerTime: failure.message,
//               prayerTimesStatus: PrayerTimesStatus.fail));
//         },
//         (response) {
//           emit(state.copyWith(
//               prayerTimesStatus: PrayerTimesStatus.succ,
//               prayerTimesModel: response));
//         },
//       );
//     } else {
//       log("No internet");
//     }
//   }
// }
