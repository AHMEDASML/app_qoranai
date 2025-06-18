import 'package:Al_Arqam/core/app/general_widgets/custom_empty.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_reload.dart';
import 'package:Al_Arqam/view/auth/nesseccary_login_screen.dart';
import 'package:Al_Arqam/view/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_app_bar.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/view/medicine_reminder/bloc/medicin_reminder_bloc.dart';
import 'package:Al_Arqam/view/medicine_reminder/medicin_reminder_details.dart';
import 'package:get/get.dart';
import '../../core/resources/color_manager.dart';
import 'widgets/medicin_cards.dart';

class MedicineReminderScreen extends StatefulWidget {
  const MedicineReminderScreen({super.key});

  @override
  State<MedicineReminderScreen> createState() => _MedicineReminderScreenState();
}

class _MedicineReminderScreenState extends State<MedicineReminderScreen> {
  late MedicinReminderBloc bloc;

  @override
  void initState() {
    bloc = MedicinReminderBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(GetAllMedicins()),
      child: !GlobalFunctions.isAuth()
          ? NesseccaryLoginScreen(namePage: 'use_health_service'.tr)
          : PopScope(
             canPop: false,
            onPopInvoked: (_) async {
        // Replace pushNamed with pushAndRemoveUntil
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false, // This clears the back stack
        );
        // return false; // Prevent default pop behavior
      },
            child: Scaffold(
                appBar: CustomAppBar(
                  title: 'health_record'.tr,
                  hasBackButton: true,
                  onTap:(){
                   Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false, // This clears the back stack
        );
                  },
                  backgroundColor: AppColors.white,
                ),
                body: Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 25.h),
                  child: BlocBuilder<MedicinReminderBloc, MedicinReminderState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          CustomButton(
                            width: double.infinity,
                            backgroundColor: AppColors.primary,
                            borderRadius: 25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 15.h,
                                  backgroundColor: AppColors.secoundaryBackground,
                                  child: Icon(
                                    Icons.add,
                                    size: 20.h,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text14(
                                  text: 'add_new_reminder'.tr,
                                  color: AppColors.secoundaryBackground,
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const MedicinReminderDetailsScreen(
                                  isAddAction: true,
                                ),
                              ));
                            },
                          ),
                          SizedBox(height: 20.h),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal:state.allMedicinsStatus == AllMedicinsStatus.fail?0.w: 10.w),
                                decoration: BoxDecoration(
                                  color: AppColors.containerGrey,
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                                ),
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    bloc.add(GetAllMedicins());
                                  },
                                  child: state.allMedicinsStatus == AllMedicinsStatus.load
                                      ? Center(child: GlobalFunctions.showLoading(AppColors.primary))
                                      : state.allMedicinsStatus == AllMedicinsStatus.fail
                                          ? Center(child:  Padding(
                                       padding:  EdgeInsets.only(top:150.h),
                                       child: ErrorReloadWidget(onRetry:(){
                                          bloc.add(GetAllMedicins());
                                       },),
                                     ))
                                          : state.allMedicinsStatus == AllMedicinsStatus.succ && state.medicinsList.isEmpty
                                              ?  Center(child: Padding(
                                      padding:  EdgeInsets.only(top:150.h),
                                      child: EmptyLottieWidget(),
                                    ))
                                              : state.allMedicinsStatus == AllMedicinsStatus.succ
                                                  ? ListView.separated(
                                                      padding: EdgeInsets.symmetric(vertical: 15.h),
                                                      itemCount: state.medicinsList.length,
                                                      separatorBuilder: (context, index) => SizedBox(height: 15.h),
                                                      itemBuilder: (context, index) => Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(30),
                                                          color: AppColors.white,
                                                        ),
                                                        child: CustomMedicationCard(
                                                          onTap: () {
                                                            Navigator.of(context).push(MaterialPageRoute(
                                                              builder: (context) => MedicinReminderDetailsScreen(
                                                                medicinId: state.medicinsList[index].id,
                                                                amount: state.medicinsList[index].medicine?.dosage?.amount,
                                                                date: state.medicinsList[index].medicine?.schedule?.date,
                                                                instructions: state.medicinsList[index].medicine?.instructions,
                                                                name: state.medicinsList[index].medicine?.name,
                                                                times: state.medicinsList[index].medicine?.schedule?.times?[0],
                                                              ),
                                                            ));
                                                          },
                                                          title: state.medicinsList[index].medicine?.name ?? "",
                                                          time: "${state.medicinsList[index].medicine?.schedule?.times?[0]} ${state.medicinsList[index].medicine?.schedule?.date}",
                                                          description: state.medicinsList[index].medicine?.instructions,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
          ),
    );
  }
}