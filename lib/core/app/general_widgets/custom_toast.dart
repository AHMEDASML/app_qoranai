
// import 'package:Al_Arqam/core/resources/color_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:fluttertoast/fluttertoast.dart';

// class AppConstants {
//   static FToast fToast = FToast();

//   static void showToast(
//     BuildContext context,
//     String text, {
//     Function? goToStore,
//     int?seconds,
//     bool gradient = false,
//     bool succsess = false,
//     // String iconData = 'assets/svgs/delete.svg',
//   }) {
//     fToast.init(context);
//     Widget toast = Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: GestureDetector(
//         onTap: () {
//           goToStore!();
//         },
//         child: Container(
//           width: MediaQuery.of(context).size.width / 1.1,
//           decoration: BoxDecoration(
//             color: succsess ? AppColors.primary8 : AppColors.primary5,
//             borderRadius: BorderRadius.circular(8),
//             gradient: gradient == true
//                 ? const LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                         AppColors.primary5,
//                         // ConstColor.primary7,
//                       ])
//                 : null,
//           ),
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       text,
//                       style: TextStyle(
//                           color: AppColors.black, fontSize: 12.sp),
//                     ),
//                   ),
//                   // GestureDetector(
//                   //   onTap: () {
//                   //     fToast.removeQueuedCustomToasts();
//                   //     // fToast.removeCustomToast();
//                   //   },
//                   //   child:SizedBox(
//                   //                         width:20,
//                   //                         height:20,
//                   //                         child:
                                         
//                   //                           SvgPicture.asset(iconData,color:AppColors.primary,)
//                   //                          )
//                   // )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );

//     fToast.showToast(
//         child: toast,
//         toastDuration: Duration(seconds:seconds?? 6),
//         positionedToastBuilder: (context, child,_) {
//           return Positioned(
//             // left: MediaQuery.of(context).size.width / 18,
//             top: 40.sp,
//             child: child,
//           );
//         });
//   }
// }
