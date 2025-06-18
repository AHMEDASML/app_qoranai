import 'dart:developer';

import 'package:Al_Arqam/view/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_text_form.dart';
import 'package:Al_Arqam/core/app/params/medicins_reminder/update_medicin_body.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/core/resources/routes_manager.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/core/resources/text/text16.dart';
import 'package:Al_Arqam/core/resources/toast.dart';
import 'package:Al_Arqam/view/main/main_screen.dart';
import 'package:Al_Arqam/view/medicine_reminder/bloc/medicin_reminder_bloc.dart';
import 'package:Al_Arqam/view/medicine_reminder/medicine_reminder_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/resources/color_manager.dart';

class MedicinReminderDetailsScreen extends StatefulWidget {
  final String? name;
  final String? amount;
  final String? times;
  final String? date;
  final String? instructions;
  final bool? isAddAction;
  final String? medicinId;

  const MedicinReminderDetailsScreen({
    super.key,
    this.name,
    this.amount,
    this.times,
    this.date,
    this.instructions,
    this.isAddAction = false,
    this.medicinId,
  });

  @override
  State<MedicinReminderDetailsScreen> createState() =>
      _MedicinReminderDetailsScreenState();
}

class _MedicinReminderDetailsScreenState
    extends State<MedicinReminderDetailsScreen> {
  late TextEditingController nameController;
  late TextEditingController descController;
  late TextEditingController quantityController;
  Map<String, dynamic>? result;
  String? name;
  String? amount;
  String? times;
  String? date;
  String? instructions;
  late MedicinReminderBloc bloc;
  DateTime? dateTime;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
 
  @override
  void initState() {
    name = widget.name;
    amount = widget.amount;
    times = widget.times;
    instructions = widget.instructions;
    date = widget.date;
    nameController = TextEditingController();
    descController = TextEditingController();
    quantityController = TextEditingController();
    nameController.text = name ?? "";
    descController.text = instructions ?? "";
    quantityController.text = amount ?? "";
    if (date != null && times != null) {
      result = {
        "time": times,
        "date": date,
      };
    }
    bloc = MedicinReminderBloc();
    super.initState();
  }
MainController controller=Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<MedicinReminderBloc, MedicinReminderState>(
        listener: (context, state) {
          if (state.addMedicinStatus == AddMedicinStatus.fail) {
            Toast.showText(text: state.messageErrorAddmedicin);
          }
          if (state.addMedicinStatus == AddMedicinStatus.succ) {
            Toast.showText(text: 'success_add_medicine'.tr);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MainScreen(
                  currentPage: AppRoutesPath.medicinereminderRoute,
                ),
              ),
              (val) => false,
            );
          }
          if (state.deleteMedicinStatus == DeleteMedicinStatus.fail) {
            Toast.showText(text: state.messageErrorDeletemedicin);
          }
          if (state.deleteMedicinStatus == DeleteMedicinStatus.succ) {
            Toast.showText(text: 'success_delete_medicine'.tr);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MainScreen(
                  currentPage: AppRoutesPath.medicinereminderRoute,
                ),
              ),
              (val) => false,
            );
          }
          if (state.updateMedicinStatus == UpdateMedicinStatus.fail) {
            Toast.showText(text: state.messageErrorUpdatemedicin);
          }
          if (state.updateMedicinStatus == UpdateMedicinStatus.succ) {
            Toast.showText(text: 'success_update_medicine'.tr);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MainScreen(
                  currentPage: AppRoutesPath.medicinereminderRoute,
                ),
              ),
              (val) => false,
            );
          }
        },
        builder: (context, state) {
          return GetBuilder<MainController>(
            builder: (controller) {
              return Scaffold(
                appBar: CustomAppBar(
                  backgroundColor: AppColors.white,
                  title: widget.isAddAction! ? 'add_new_reminder'.tr : 'reminder_details'.tr,
                ),
                bottomNavigationBar: Padding(
                  padding: EdgeInsets.only(bottom: 20.h, left: 16.w, right: 16.w),
                  child: Row(
                    children: [
                      if (!widget.isAddAction!)
                        Expanded(
                          child: CustomButton(
                            borderRadius: 20,
                            borderColor: AppColors.error,
                            isFillColor: false,
                            child: state.deleteMedicinStatus == DeleteMedicinStatus.load
                                ? GlobalFunctions.showLoading(AppColors.error)
                                : Text16(text: 'delete'.tr, color: AppColors.error),
                            onPressed: () {
                              if (widget.medicinId != null) {
                                bloc.add(DeleteMedicin(medicinId: widget.medicinId!));
                                   Future.delayed(const Duration(seconds: 5), () {
 controller.fetchMedicins();
});
                              }
                            },
                          ),
                        ),
                      SizedBox(width: 10.w),
                      BlocBuilder<MedicinReminderBloc, MedicinReminderState>(
                        builder: (context, state) {
                          return Expanded(
                            child: CustomButton(
                              borderRadius: 20,
                              
                              child: state.addMedicinStatus == AddMedicinStatus.load ||
                                      state.updateMedicinStatus == UpdateMedicinStatus.load
                                  ? GlobalFunctions.showLoading(AppColors.white)
                                  : Text16(
                                      text: widget.isAddAction! ? 'save'.tr : 'edit'.tr,
                                      color: AppColors.whiteBackground,
                                    ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (result == null || result == {}) {
                                    Toast.showText(text: 'please_enter_time'.tr);
                                  } else {
                                    //  print(';;;;;;;;;;;;;;;;;;');
                                    if (widget.isAddAction!) {
                                       
                                      
                                      bloc.add(AddMedicin(
                                        dateTime: dateTime ?? DateTime(2025),
                                        body: UpdateMedicinBody(
                                          amount: quantityController.text,
                                          date: result!["date"],
                                          instructions: descController.text,
                                          name: nameController.text,
                                          times: result!["time"],
                                        ),
                                      ));
                                                                   } else {
                                      if (name == widget.name &&
                                          amount == widget.amount &&
                                          times == widget.times &&
                                          instructions == widget.instructions &&
                                          date == widget.date) {
                                        Toast.showText(text: 'no_data'.tr);
                                      } else {
                                        bloc.add(UpdateMedicin(
                                          medicinId: widget.medicinId!,
                                          dateTime: dateTime ?? DateTime(2025),
                                          body: UpdateMedicinBody(
                                            amount: quantityController.text,
                                            date: result!["date"],
                                            instructions: descController.text,
                                            name: nameController.text,
                                            times: result!["time"],
                                          ),
                                        ));
                                      }
                                    }
                                  }
                                }
                                  Future.delayed(const Duration(seconds: 5), () {
 controller.fetchMedicins();
});
    
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                body: Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 25.h),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text14(
                              text: 'medicine_name'.tr,
                              color: AppColors.black,
                              isBold: true,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              borderRaduis: 20,
                              isFilled: false,
                              controller: nameController,
                              hintText: "",
                              prefixIcon: null,
                              validator: (val) => GlobalFunctions.valid(val ?? "", 2, 600, context),
                              onChanged: (val) {
                                name = val;
                              },
                            ),
                            SizedBox(height: 20.h),
                            Text14(
                              text: 'dose'.tr,
                              color: AppColors.black,
                              isBold: true,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              borderRaduis: 20,
                              isFilled: false,
                              controller: quantityController,
                              hintText: "",
                              prefixIcon: null,
                              validator: (val) => GlobalFunctions.valid(val ?? "", 1, 600, context),
                              onChanged: (val) {
                                amount = val;
                              },
                            ),
                            SizedBox(height: 20.h),
                            Text14(
                              text: 'details'.tr,
                              color: AppColors.black,
                              isBold: true,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              maxLines: 6,
                              isFilled: false,
                              borderRaduis: 20,
                              controller: descController,
                              hintText: "",
                              prefixIcon: null,
                              onChanged: (val) {
                                instructions = val;
                              },
                            ),
                            SizedBox(height: 20.h),
                            Text14(
                              text: 'daily_schedule'.tr,
                              color: AppColors.black,
                              isBold: true,
                            ),
                            SizedBox(height: 20.h),
                            InkWell(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  locale: Locale('en'),
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100),
                                );
              
                                if (pickedDate != null) {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    builder: (BuildContext context, Widget? child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          timePickerTheme: TimePickerThemeData(
                                            dayPeriodTextColor: WidgetStateColor.resolveWith(
                                                (states) => states.contains(WidgetState.selected) ? Colors.white : AppColors.primary),
                                            dayPeriodColor: WidgetStateColor.resolveWith(
                                                (states) => states.contains(WidgetState.selected) ? AppColors.primary : AppColors.white),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
              
                                  if (pickedTime != null) {
                                    String formattedTime =
                                        "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
              
                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    dateTime = pickedDate.add(Duration(hours: pickedTime.hour, minutes: pickedTime.minute));
                                    setState(() {
                                      result = {
                                        "time": formattedTime,
                                        "date": formattedDate,
                                      };
                                      times = formattedTime;
                                      date = formattedDate;
                                      dateTime = pickedDate.add(Duration(hours: pickedTime.hour, minutes: pickedTime.minute));
                                    });
                                  }
                                }
                                log("=====================${dateTime.toString()}");
                              },
                              child: result == null || result == {}
                                  ? Container(
                                      height: 70.h,
                                      width: 80.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.containerGrey,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: AppColors.textSecoundary,
                                      ),
                                    )
                                  : Container(
                                      height: 70.h,
                                      width: 160.w,
                                      alignment: AlignmentDirectional.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.containerGrey,
                                      ),
                                      child: Text14(
                                          text: "${result!["time"]} ${result!["date"]}"),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          );
        },
      ),
    );
  }
}