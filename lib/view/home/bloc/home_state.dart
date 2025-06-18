// // ignore_for_file: public_member_api_docs, sort_constructors_first
// part of 'home_bloc.dart';

// enum PrayerTimesStatus { succ, load, fail, init }

// class HomeState {
//   final PrayerTimesStatus prayerTimesStatus;
//   final PrayerTimesModel? prayerTimesModel;
//   final String massegeErrorPrayerTime;
//   HomeState(
//       {this.prayerTimesModel,
//       this.massegeErrorPrayerTime = "",
//       this.prayerTimesStatus = PrayerTimesStatus.init});

//   HomeState copyWith({
//     PrayerTimesStatus? prayerTimesStatus,
//     String? massegeErrorPrayerTime,
//     PrayerTimesModel? prayerTimesModel,
//   }) {
//     return HomeState(
//       prayerTimesStatus: prayerTimesStatus ?? this.prayerTimesStatus,
//       massegeErrorPrayerTime:
//           massegeErrorPrayerTime ?? this.massegeErrorPrayerTime,
//       prayerTimesModel: prayerTimesModel ?? this.prayerTimesModel,
//     );
//   }
// }
