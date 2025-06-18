import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/resources/text/text16.dart';
import 'package:Al_Arqam/injection.dart';
import 'package:Al_Arqam/view/quran/bloc/quran_bloc.dart';
import 'package:get/get.dart';
import '../../core/app/general_widgets/custom_button.dart';
import '../../core/app/general_widgets/custom_no_internet.dart';
import '../../core/app/general_widgets/custom_text_form.dart';
import '../../core/resources/color_manager.dart';
import '../../core/resources/global_functions.dart';
import '../../core/resources/text/text14.dart';
import '../../generated/l10n.dart';

class QuranNotes extends StatefulWidget {
  const QuranNotes({super.key});

  @override
  State<QuranNotes> createState() => _QuranNotesState();
}

class _QuranNotesState extends State<QuranNotes> {
  late TextEditingController notesController;
  late QuranBloc bloc;
  GlobalKey<FormState> addKey = GlobalKey<FormState>();

  @override
  void initState() {
    bloc = serviceLocator<QuranBloc>();
    notesController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(GetAllQuranNote()),
      child: Scaffold(
        backgroundColor: AppColors.quranColor1,
        appBar: CustomAppBar(
          
          title: 'notes'.tr,
          backgroundColor: AppColors.quranColor1,
          triling: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: CustomButton(
                 height: 60.h,
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    QuranBloc quranBloc = serviceLocator<QuranBloc>();
                    return AlertDialog(
                      backgroundColor: AppColors.white,
                      content: SizedBox(
                        height: 375.h,
                        child: BlocProvider(
                          create: (context) => quranBloc,
                          child: BlocConsumer<QuranBloc, QuranState>(
                            listener: (context, state) {
                              // Handle states if needed
                            },
                            builder: (context, state) {
                              return Form(
                                key: addKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomTextField(
                                      prefixIcon: null,
                                      controller: notesController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return S.of(context).valid_empty;
                                        }
                                        return null;
                                      },
                                      borderRaduis: 20.r,
                                      maxLines: 4,
                                      hintText: 'write_your_note'.tr,
                                    ),
                                    CustomButton(
                                      borderRadius: 20.r,
                                      width: 300.w,
                                      child: Text14(
                                        text: 'save'.tr,
                                        color: AppColors.white,
                                      ),
                                      onPressed: () {
                                        if (addKey.currentState!.validate()) {
                                          quranBloc.add(AddQuranNote(note: notesController.text));
                                          Future.delayed(const Duration(milliseconds: 500), () {
                                            bloc.add(GetAllQuranNote());
                                          });
                                          notesController.clear();
                                          Navigator.pop(context);
                                        }
                                      },
                                    ),
                                    CustomButton(
                                      borderRadius: 20.r,
                                      width: 300.w,
                                      isFillColor: false,
                                      borderColor: AppColors.primary,
                                      child: Text14(
                                        text: 'cancel'.tr,
                                        color: AppColors.primary,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        notesController.clear();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: AppColors.white,
                  ),
                  SizedBox(width: 3.w),
                  Text14(
                    text: 'add_note'.tr,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: BlocBuilder<QuranBloc, QuranState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                // bloc.add(GetAllChapters());
              },
              child: Center(
                child: state.notesList.isNotEmpty
                    ? ListView(children: [
                        ...List.generate(
                          state.notesList.length,
                          (index) => Container(
                            alignment: AlignmentDirectional.centerStart,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: index % 2 == 0 ? AppColors.quranColor1 : AppColors.quranColor2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: AutoSizeText(
                                      state.notesList[index],
                                      style: TextStyle(fontSize: 16.sp),
                                      maxLines: 7,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    bloc.add(DeleteQuranNote(noteId: state.notesIdList[index]));
                                  },
                                  icon: Icon(
                                    Icons.delete_outline,
                                    size: 25.h,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ])
                    : Center(child: Text16(text: 'no_notes'.tr)),
              ),
            );
          },
        ),
      ),
    );
  }
}