import 'package:Al_Arqam/core/app/general_widgets/custom_button.dart';
import 'package:Al_Arqam/core/app/general_widgets/custom_text_form.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/core/resources/text/text12.dart';
import 'package:Al_Arqam/core/resources/text/text14.dart';
import 'package:Al_Arqam/generated/l10n.dart';
import 'package:Al_Arqam/view/auth/widgets/custom_radio.dart';
import 'package:Al_Arqam/view/my_account/controller/my_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CustomUpdateProfile extends StatefulWidget {
  final String name;
  final String idCode;
  final String legalStatus;

  const CustomUpdateProfile({
    super.key,
    required this.name,
    required this.idCode,
    required this.legalStatus,
  });

  @override
  _CustomUpdateProfileState createState() => _CustomUpdateProfileState();
}

class _CustomUpdateProfileState extends State<CustomUpdateProfile> {
  TextEditingController? username;
  TextEditingController? idCode;
  String? legalStatus;

  @override
  void initState() {
    super.initState();
    controller.isLoadingUpdate.value=false;
    username = TextEditingController(text: widget.name);
    idCode = TextEditingController(text: widget.idCode);
    legalStatus = widget.legalStatus;
  }

  MyAccountController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: AlertDialog(
        backgroundColor: AppColors.white,
        contentPadding: EdgeInsets.only(top: 10.h),
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.only(right: 20.w, top: 20.h),
        iconPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        content: Container(
          height: 500.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
               Text12(text: 'full_name'.tr),
              SizedBox(height: 15.h),
              SizedBox(
                height: 60.h,
                child: CustomTextField(
                  textInputType: TextInputType.text,
                  controller: username,
                  hintText: '',
                  prefixIcon: Icon(
                    Iconsax.profile_circle5,
                    size: 25.h,
                  ),
                   onChanged:(_){
                    setState(() {
                      
                    });
                  },
                  validator: (value) {
                    return GlobalFunctions.valid(value ?? "", 3, 50, context);
                  },
                ),
              ),
              SizedBox(height: 15.h),
               Text12(text: S.of(context).populationNumberHint+' ('+'optional'.tr+') '),
              SizedBox(height: 15.h),
              SizedBox(
                height: 60.h,
                child: CustomTextField(
                  textInputType: TextInputType.text,
                  controller: idCode,
                  hintText:'',
                  prefixIcon: Icon(
                    Iconsax.code,
                    size: 25.h,
                  ),
                   onChanged:(_){
                    setState(() {
                      
                    });
                  },
                  validator: (value) {
                    return GlobalFunctions.valid(value ?? "", 3, 50, context);
                  },
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LegalStatusOption(
                    value: "citizen",
                    groupValue: legalStatus!,
                    onChanged: (value) {
                      setState(() {
                        legalStatus = "citizen";
                      });
                    },
                    label: S.of(context).citizen,
                    isSelected: legalStatus == "citizen",
                  ),
                  LegalStatusOption(
                    value: "resident",
                    groupValue: legalStatus!,
                    onChanged: (value) {
                      setState(() {
                        legalStatus = "resident";
                      });
                    },
                    label: S.of(context).resident,
                    isSelected: legalStatus == "resident",
                  ),
                  LegalStatusOption(
                    value: "visitor",
                    groupValue: legalStatus!,
                    onChanged: (value) {
                      setState(() {
                        legalStatus = "visitor";
                      });
                    },
                    label: S.of(context).visitor,
                    isSelected: legalStatus == "visitor",
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              GetBuilder<MyAccountController>(
                builder: (controller) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                    child: Opacity(
                      opacity:username!.text.isEmpty?0.3:1,
                      child: CustomButton(
                        height: 90.h,
                        onPressed:(username!.text.isEmpty)||controller.isLoadingUpdate.value?(){}: () {
                          controller.updateProfile(context, username!.text, idCode!.text.isEmpty?null:idCode!.text, legalStatus!);
                        },
                        borderRadius: 20.r,
                        backgroundColor: AppColors.primary,
                        child: controller.isLoadingUpdate.value
                            ? Center(child: GlobalFunctions.showLoading(AppColors.white, size: 16.sp))
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text14(
                                    text: 'update'.tr,
                                    color: AppColors.white,
                                    isBold: true,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                child: CustomButton(
                  height: 90.h,
                  onPressed: () {
                    Get.back();
                  },
                  borderRadius: 20.r,
                  borderColor: AppColors.primary,
                  isFillColor: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text14(
                        text: 'cancel'.tr,
                        color: AppColors.primary,
                        isBold: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showCustomUpdateProfile(BuildContext context, String name, String? idCode, String legalStatus) {
  showDialog(
    context: context,
    builder: (context) {
      return CustomUpdateProfile(name: name, idCode: idCode!, legalStatus: legalStatus);
    },
  );
}