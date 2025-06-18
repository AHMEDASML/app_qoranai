// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
// import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
// import 'package:Al_Arqam/core/app/general_widgets/custom_text_form.dart';
// import 'package:Al_Arqam/core/app/general_widgets/custom_type.dart';
// import 'package:Al_Arqam/core/app/params/inquiries/add_inquiry_body.dart';
// import 'package:Al_Arqam/core/app/params/inquiries/inquiries_params.dart';
// import 'package:Al_Arqam/core/app/params/inquiries/update_inquiry_body.dart';
// import 'package:Al_Arqam/core/resources/color_manager.dart';
// import 'package:Al_Arqam/core/resources/global_functions.dart';
// import 'package:Al_Arqam/core/resources/routes_manager.dart';
// import 'package:Al_Arqam/core/resources/text/text12.dart';
// import 'package:Al_Arqam/core/resources/text/text14.dart';
// import 'package:Al_Arqam/core/resources/toast.dart';
// import 'package:Al_Arqam/injection.dart';
// import 'package:Al_Arqam/models/questions/data_source/questions_data_source.dart';
// import 'package:Al_Arqam/view/qustions/bloc/questions_bloc.dart';
// import 'package:Al_Arqam/core/app/general_widgets/custom_tile.dart';

// import '../../../generated/l10n.dart';

// class MuftiQuestionScreen extends StatefulWidget {
//   final String? type;
//   const MuftiQuestionScreen({super.key, this.type = "public"});

//   @override
//   State<MuftiQuestionScreen> createState() => _MuftiQuestionScreenState();
// }

// class _MuftiQuestionScreenState extends State<MuftiQuestionScreen> {
//   late QuestionsBloc questionsBloc;
//   late TextEditingController searchController;
//   late TextEditingController questionController;
//   late TextEditingController updateQuestionController;
//   late bool isAuth;
//   late String type;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> addKey = GlobalKey<FormState>();
//   final GlobalKey<FormState> updateKey = GlobalKey<FormState>();
//   QuestionsDataSource questionsDataSource = QuestionsDataSource();

//   @override
//   void initState() {
//     super.initState();
//     searchController = TextEditingController();
//     questionController = TextEditingController();
//     updateQuestionController = TextEditingController();
//     type = widget.type!;
//     questionsBloc = serviceLocator<QuestionsBloc>()
//       ..add(GetQuestionsEvent(
//           inquiriesParams: InquiriesParams(type: type, searchTerm: "")));
//     isAuth = GlobalFunctions.isAuth();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => questionsBloc,
//       child: BlocBuilder<QuestionsBloc, QuestionsState>(
//         builder: (context, state) {
//           print("-------------------------");
//           print(state.message);
//           return Scaffold(
//             appBar: CustomAppBar(title: S.of(context).askingMufti),
//             body: Padding(
//               padding: EdgeInsets.only(top: 25.h, left: 16.w, right: 16.w),
//               child: RefreshIndicator(
//                 onRefresh: () async {
//                   questionsBloc.add(QuestionsTypeEvent(type: state.type));
//                   questionsBloc.add(GetQuestionsEvent(
//                       inquiriesParams: InquiriesParams(
//                           type: state.type,
//                           searchTerm: searchController.text)));
//                 },
//                 child: Column(
//                   children: [
//                     isAuth
//                         ? Container(
//                             height: 65.h,
//                             decoration: BoxDecoration(
//                                 color: AppColors.containerGrey,
//                                 borderRadius: BorderRadius.circular(25.r)),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 CustomTap(
//                                     color: state.type == "public"
//                                         ? AppColors.primary
//                                         : AppColors.containerGrey,
//                                     text: S.of(context).fatwas,
//                                     textColor: state.type == "public"
//                                         ? AppColors.white
//                                         : AppColors.textSecoundary,
//                                     onTap: () {
//                                       type = "public";
//                                       questionsBloc.add(
//                                           QuestionsTypeEvent(type: "public"));
//                                       questionsBloc.add(GetQuestionsEvent(
//                                           inquiriesParams: InquiriesParams(
//                                               type: "public", searchTerm: "")));
//                                     }),
//                                 CustomTap(
//                                     color: state.type == "private"
//                                         ? AppColors.primary
//                                         : AppColors.containerGrey,
//                                     text: S.of(context).myQuestions,
//                                     textColor: state.type == "private"
//                                         ? AppColors.white
//                                         : AppColors.textSecoundary,
//                                     onTap: () {
//                                       type = "private";
//                                       questionsBloc.add(
//                                           QuestionsTypeEvent(type: "private"));
//                                       questionsBloc.add(GetQuestionsEvent(
//                                           inquiriesParams: InquiriesParams(
//                                               type: "private",
//                                               searchTerm: "")));
//                                     }),
//                               ],
//                             ),
//                           )
//                         : const SizedBox(),
//                     SizedBox(
//                       height: 25.h,
//                     ),
//                     CustomTextField(
//                       controller: searchController,
//                       onChanged: (value) {
//                         questionsBloc.add(QuestionsTypeEvent(type: type));
//                         questionsBloc.add(GetQuestionsEvent(
//                             inquiriesParams: InquiriesParams(
//                                 type: type, searchTerm: value)));
//                       },
//                       hintText: S.of(context).enterTextToSearch,
//                       prefixIcon: const Icon(Icons.search),
//                       borderRaduis: 20.r,
//                     ),
//                     state.getQuestionsStatus == GetQuestionsStatus.fail &&
//                             state.message == "No Internet"
//                         ? Expanded(
//                             child: Center(
//                             child: Text14(
//                               text: state.message,
//                               isBold: true,
//                               color: AppColors.primary,
//                             ),
//                           ))
//                         : state.getQuestionsStatus == GetQuestionsStatus.load ||
//                                 state.getQuestionsStatus ==
//                                     GetQuestionsStatus.init
//                             ? Expanded(
//                                 child: GlobalFunctions.showLoading(
//                                     AppColors.primary))
//                             : state.getQuestionsStatus ==
//                                     GetQuestionsStatus.fail
//                                 ? Expanded(
//                                     child: GlobalFunctions.showError(context))
//                                 : state.getQuestionsStatus ==
//                                             GetQuestionsStatus.succ &&
//                                         state.inquiryList.isEmpty
//                                     ? Expanded(
//                                         child: Center(
//                                           child: Text14(
//                                             text: S.of(context).noData,
//                                             color: AppColors.primary,
//                                             isBold: true,
//                                           ),
//                                         ),
//                                       )
//                                     : Expanded(
//                                         child: ListView.builder(
//                                             shrinkWrap: true,
//                                             itemCount:
//                                                 state.inquiryList.length +
//                                                     (state.isEndpage ? 0 : 1),
//                                             itemBuilder: (context, index) {
//                                               if (state.inquiryList.length ==
//                                                   index) {
//                                                 questionsBloc.add(GetQuestionsEvent(
//                                                     inquiriesParams:
//                                                         InquiriesParams(
//                                                             type: type,
//                                                             searchTerm:
//                                                                 searchController
//                                                                     .text)));
//                                               }
//                                               return Padding(
//                                                 padding: EdgeInsets.symmetric(
//                                                     vertical: 20.h),
//                                                 child: Container(
//                                                     decoration: BoxDecoration(
//                                                       color: AppColors
//                                                           .secoundaryBackground,
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               20.r),
//                                                     ),
//                                                     child: CustomTile(
//                                                       title: state
//                                                           .inquiryList[index]
//                                                           .inquiry!
//                                                           .question!,
//                                                       answer: state
//                                                           .inquiryList[index]
//                                                           .inquiry!
//                                                           .answer,
//                                                       leading: state
//                                                                   .inquiryList[
//                                                                       index]
//                                                                   .inquiry!
//                                                                   .answer ==
//                                                               null
//                                                           ? BlocListener<
//                                                               QuestionsBloc,
//                                                               QuestionsState>(
//                                                               listener:
//                                                                   (context,
//                                                                       state) {
//                                                                 if (state.deleteQuestionsStatus ==
//                                                                         DeleteQuestionsStatus
//                                                                             .fail &&
//                                                                     state.message ==
//                                                                         "No Internet") {
//                                                                   Toast.showText(
//                                                                       text: state
//                                                                           .message);
//                                                                 } else if (state
//                                                                         .deleteQuestionsStatus ==
//                                                                     DeleteQuestionsStatus
//                                                                         .load) {
//                                                                   // Toast
//                                                                   //     .showLoading();
//                                                                 } else if (state
//                                                                         .deleteQuestionsStatus ==
//                                                                     DeleteQuestionsStatus
//                                                                         .succ) {
//                                                                   // Toast
//                                                                   //     .closeAllLoading();
//                                                                   Toast.showText(
//                                                                       text: S
//                                                                           .of(context)
//                                                                           .deleteQuestion);
//                                                                 } else if (state
//                                                                         .deleteQuestionsStatus ==
//                                                                     DeleteQuestionsStatus
//                                                                         .fail) {
//                                                                   // Toast
//                                                                   //     .closeAllLoading();
//                                                                   Toast.showText(
//                                                                       text: state
//                                                                           .message);
//                                                                 }
//                                                               },
//                                                               child:
//                                                                   PopupMenuButton(
//                                                                 onSelected:
//                                                                     (value) {
//                                                                   if (value ==
//                                                                       "update") {
//                                                                     String
//                                                                         inquiryId =
//                                                                         state
//                                                                             .inquiryList[index]
//                                                                             .id!;
//                                                                     updateQuestionController.text = state
//                                                                         .inquiryList[
//                                                                             index]
//                                                                         .inquiry!
//                                                                         .question!;
//                                                                     showDialog(
//                                                                         context:
//                                                                             context,
//                                                                         builder:
//                                                                             (context) {
//                                                                           QuestionsBloc
//                                                                               updateDialogBloc =
//                                                                               serviceLocator<QuestionsBloc>();
//                                                                           return AlertDialog(
//                                                                             backgroundColor:
//                                                                                 AppColors.white,
//                                                                             content:
//                                                                                 SizedBox(
//                                                                               height: 375.h,
//                                                                               child: BlocProvider(
//                                                                                 create: (context) => updateDialogBloc,
//                                                                                 child: BlocConsumer<QuestionsBloc, QuestionsState>(
//                                                                                   listener: (context, state) {
//                                                                                     if (state.updateQuestionsStatus == UpdateQuestionsStatus.fail && state.message == "No Internet") {
//                                                                                       Toast.showText(text: state.message);
//                                                                                     } else if (state.updateQuestionsStatus == UpdateQuestionsStatus.succ) {
//                                                                                       Toast.showText(text: S.of(context).updateQuestion);

//                                                                                       Navigator.of(context).pop();
//                                                                                       Navigator.of(context).pop();
//                                                                                       Navigator.of(context).push(MaterialPageRoute(
//                                                                                           builder: (_) => MuftiQuestionScreen(
//                                                                                                 type: type,
//                                                                                               )));
//                                                                                     } else if (state.updateQuestionsStatus == UpdateQuestionsStatus.fail) {
//                                                                                       GlobalFunctions.showError(context);
//                                                                                     }
//                                                                                   },
//                                                                                   builder: (context, state) {
//                                                                                     return Form(
//                                                                                       key: updateKey,
//                                                                                       child: Column(
//                                                                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                                                         children: [
//                                                                                           CustomTextField(
//                                                                                             prefixIcon: null,
//                                                                                             controller: updateQuestionController,
//                                                                                             validator: (value) {
//                                                                                               if (value == null || value.isEmpty) {
//                                                                                                 return S.of(context).valid_empty;
//                                                                                               }
//                                                                                               return null;
//                                                                                             },
//                                                                                             borderRaduis: 20.r,
//                                                                                             maxLines: 4,
//                                                                                             hintText: S.of(context).writeQuestion,
//                                                                                           ),
//                                                                                           CustomButton(
//                                                                                               borderRadius: 20.r,
//                                                                                               width: 300.w,
//                                                                                               child: state.addQuestionsStatus == AddQuestionsStatus.load
//                                                                                                   ? GlobalFunctions.showLoading(AppColors.white)
//                                                                                                   : Text14(
//                                                                                                       text: S.of(context).update,
//                                                                                                       color: AppColors.white,
//                                                                                                     ),
//                                                                                               onPressed: () {
//                                                                                                 if (updateKey.currentState!.validate()) {
//                                                                                                   updateDialogBloc.add(UpdateQuestionEvent(updateInquiryBody: UpdateInquiryBody(question: updateQuestionController.text), inquiryId: inquiryId));
//                                                                                                 }
//                                                                                               }),
//                                                                                           CustomButton(
//                                                                                               borderRadius: 20.r,
//                                                                                               width: 300.w,
//                                                                                               isFillColor: false,
//                                                                                               borderColor: AppColors.primary,
//                                                                                               child: Text14(
//                                                                                                 text: S.of(context).cancel,
//                                                                                                 color: AppColors.primary,
//                                                                                               ),
//                                                                                               onPressed: () {
//                                                                                                 Navigator.pop(context);
//                                                                                               }),
//                                                                                         ],
//                                                                                       ),
//                                                                                     );
//                                                                                   },
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           );
//                                                                         });
//                                                                   } else if (value ==
//                                                                       "delete") {
//                                                                     questionsBloc.add(DeleteQuestionEvent(
//                                                                         iquiryId: state
//                                                                             .inquiryList[
//                                                                                 index]
//                                                                             .id!,
//                                                                         index:
//                                                                             index));
//                                                                   }
//                                                                 },
//                                                                 itemBuilder:
//                                                                     (context) {
//                                                                   return [
//                                                                     PopupMenuItem(
//                                                                       value:
//                                                                           "update",
//                                                                       child:
//                                                                           Row(
//                                                                         mainAxisAlignment:
//                                                                             MainAxisAlignment.spaceAround,
//                                                                         children: [
//                                                                           Icon(
//                                                                             Icons.edit,
//                                                                             color:
//                                                                                 AppColors.textSecoundary,
//                                                                           ),
//                                                                           Text14(
//                                                                             text:
//                                                                                 S.of(context).update,
//                                                                             isBold:
//                                                                                 true,
//                                                                             color:
//                                                                                 AppColors.textSecoundary,
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                     PopupMenuItem(
//                                                                       value:
//                                                                           "delete",
//                                                                       child:
//                                                                           Row(
//                                                                         mainAxisAlignment:
//                                                                             MainAxisAlignment.spaceAround,
//                                                                         children: [
//                                                                           Icon(
//                                                                             Icons.delete,
//                                                                             color:
//                                                                                 AppColors.textSecoundary,
//                                                                           ),
//                                                                           Text14(
//                                                                             text:
//                                                                                 S.of(context).delete,
//                                                                             isBold:
//                                                                                 true,
//                                                                             color:
//                                                                                 AppColors.textSecoundary,
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ];
//                                                                 },
//                                                                 icon: const Icon(
//                                                                     Icons
//                                                                         .more_vert),
//                                                               ),
//                                                             )
//                                                           : null,
//                                                     )),
//                                               );
//                                             }),
//                                       ),
//                     CustomButton(
//                         borderRadius: 20.r,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.question_mark,
//                               color: AppColors.white,
//                             ),
//                             Text14(
//                               text: S.of(context).askQuestion,
//                               color: AppColors.white,
//                               isBold: true,
//                             ),
//                           ],
//                         ),
//                         onPressed: () {
//                           isAuth
//                               ? showDialog(
//                                   context: context,
//                                   barrierDismissible: false,
//                                   builder: (context) {
//                                     QuestionsBloc questionsDialogBloc =
//                                         serviceLocator<QuestionsBloc>();
//                                     return AlertDialog(
//                                       backgroundColor: AppColors.white,
//                                       content: SizedBox(
//                                         height: 375.h,
//                                         child: BlocProvider(
//                                           create: (context) =>
//                                               questionsDialogBloc,
//                                           child: BlocConsumer<QuestionsBloc,
//                                               QuestionsState>(
//                                             listener: (context, state) {
//                                               if (state.addQuestionsStatus ==
//                                                       AddQuestionsStatus.fail &&
//                                                   state.message ==
//                                                       "No Internet") {
//                                                 Toast.showText(
//                                                     text: state.message);
//                                               } else if (state
//                                                       .addQuestionsStatus ==
//                                                   AddQuestionsStatus.succ) {
//                                                 Toast.showText(
//                                                     text: S
//                                                         .of(context)
//                                                         .questionAddedSucc);
//                                                 questionController.clear();
//                                                 Navigator.of(context).pop();
//                                                 Navigator.of(context).pop();
//                                                 Navigator.of(context).push(
//                                                     MaterialPageRoute(
//                                                         builder: (_) =>
//                                                             MuftiQuestionScreen(
//                                                               type: type,
//                                                             )));
//                                               } else if (state
//                                                       .addQuestionsStatus ==
//                                                   AddQuestionsStatus.fail) {
//                                                 GlobalFunctions.showError(
//                                                     context);
//                                               }
//                                             },
//                                             builder: (context, state) {
//                                               return Form(
//                                                 key: addKey,
//                                                 child: Column(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceAround,
//                                                   children: [
//                                                     CustomTextField(
//                                                       prefixIcon: null,
//                                                       controller:
//                                                           questionController,
//                                                       validator: (value) {
//                                                         if (value == null ||
//                                                             value.isEmpty) {
//                                                           return S
//                                                               .of(context)
//                                                               .valid_empty;
//                                                         }
//                                                         return null;
//                                                       },
//                                                       borderRaduis: 20.r,
//                                                       maxLines: 4,
//                                                       hintText: S
//                                                           .of(context)
//                                                           .writeQuestion,
//                                                     ),
//                                                     CustomButton(
//                                                         borderRadius: 20.r,
//                                                         width: 300.w,
//                                                         child: state.addQuestionsStatus ==
//                                                                 AddQuestionsStatus
//                                                                     .load
//                                                             ? GlobalFunctions
//                                                                 .showLoading(
//                                                                     AppColors
//                                                                         .white)
//                                                             : Text14(
//                                                                 text: S
//                                                                     .of(context)
//                                                                     .sendToMufti,
//                                                                 color: AppColors
//                                                                     .white,
//                                                               ),
//                                                         onPressed: () {
//                                                           if (addKey
//                                                               .currentState!
//                                                               .validate()) {
//                                                             questionsDialogBloc.add(
//                                                                 AddQuestionEvent(
//                                                                     addInquiryBody:
//                                                                         AddInquiryBody(
//                                                                             question:
//                                                                                 questionController.text)));
//                                                           }
//                                                         }),
//                                                     CustomButton(
//                                                         borderRadius: 20.r,
//                                                         width: 300.w,
//                                                         isFillColor: false,
//                                                         borderColor:
//                                                             AppColors.primary,
//                                                         child: Text14(
//                                                           text: S
//                                                               .of(context)
//                                                               .cancel,
//                                                           color:
//                                                               AppColors.primary,
//                                                         ),
//                                                         onPressed: () {
//                                                           Navigator.pop(
//                                                               context);
//                                                           questionController
//                                                               .clear();
//                                                         }),
//                                                   ],
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   })
//                               : showDialog(
//                                   context: context,
//                                   barrierDismissible: false,
//                                   builder: (context) {
//                                     return AlertDialog(
//                                       backgroundColor: AppColors.white,
//                                       content: SizedBox(
//                                         height: 250.h,
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceAround,
//                                           children: [
//                                             Text12(
//                                                 text: S.of(context).sorry,
//                                                 isBold: true),
//                                             CustomButton(
//                                                 borderRadius: 20.r,
//                                                 width: 300.w,
//                                                 borderColor: AppColors.primary,
//                                                 child: Text14(
//                                                   text: S
//                                                       .of(context)
//                                                       .createAccount,
//                                                   color: AppColors.white,
//                                                 ),
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                   Navigator.pushNamed(
//                                                       context,
//                                                       AppRoutesPath
//                                                           .signUpRoute);
//                                                 }),
//                                             CustomButton(
//                                                 borderRadius: 20.r,
//                                                 width: 300.w,
//                                                 isFillColor: false,
//                                                 borderColor: AppColors.primary,
//                                                 child: Text14(
//                                                   text: S.of(context).login,
//                                                   color: AppColors.primary,
//                                                 ),
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                   Navigator.pushNamed(context,
//                                                       AppRoutesPath.loginRoute);
//                                                 }),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   });
//                         }),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
