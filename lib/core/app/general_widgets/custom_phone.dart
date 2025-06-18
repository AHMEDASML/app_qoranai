import 'package:Al_Arqam/core/app/general_widgets/custom_text_form.dart';
import 'package:Al_Arqam/view/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class InputPhoneNumberWidget extends StatefulWidget {
  final TextEditingController? controller;
  final bool? isEmail;
  final TextEditingController? code;
  final TextEditingController? countreyCode;
  final String? countreyCodeAr;
  final bool? isEnabled;
  final void Function()? onTap;

  const InputPhoneNumberWidget({
    Key? key,
    required this.controller,
    this.code,
    this.isEmail,
    this.countreyCodeAr,
    this.countreyCode,
    this.isEnabled,
    this.onTap,
  }) : super(key: key);

  @override
  State<InputPhoneNumberWidget> createState() => _InputPhoneNumberWidgetState();
}

class _InputPhoneNumberWidgetState extends State<InputPhoneNumberWidget> {
  final FocusNode focusNode = FocusNode();
  bool isVlaidated = false;
    late AuthBloc authBloc;
  @override
  void initState() {
    super.initState();
    if (widget.controller!.text.isEmpty || widget.controller!.text == 'null') {
      widget.controller!.clear();
    }
    widget.countreyCode?.text = "+973";
    widget.code?.text = "BH";
       authBloc = AuthBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: [
          Container(
            height: 70.h,
            width: 65.w,
            margin: EdgeInsets.only(bottom: !isVlaidated ? 0.h : 30.h),
            decoration: BoxDecoration(
              color: AppColors.secoundaryBackground,
              borderRadius: BorderRadius.circular(50.sp),
              // border: Border.all(color: Colors.grey.shade300, width: 1.5),
            ),
            child: Center(
              child: Text(
                "+973",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.textSecoundary,
                  fontFamily: "NotoKufiArabic",
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Directionality(
              textDirection:GlobalFunctions.getLangCode()=="ar"?TextDirection.rtl:TextDirection.ltr,
              child: CustomTextField(
                hintText: "phone_number".tr,
              
                controller: widget.controller,
                textInputType: TextInputType.number,
                onTap: widget.onTap,
                isSelctedField: widget.isEnabled,
              
                // contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                validator: (value) {
                  if(widget.isEmail!){
                    return null;
                  }
                  if (value == null || !RegExp(r'^3\d{7}$').hasMatch(value)) {
                    setState(() {
                      isVlaidated = true;
                    });
                    return "invalid_bahraini_phone".tr;
                  }
                  setState(() {
                    isVlaidated = false;
                  });
                  return null;
                },
                prefixIcon: Icon(
                  Iconsax.call5,
                  size: 25.h,
                ),
                onChanged: (val) {
                  // Optional handling
                },
              
                inputFormatters: [
                  LengthLimitingTextInputFormatter(8),
                  FilteringTextInputFormatter.digitsOnly,
                  NoLeadingZeroInputFormatter(),
                ],
                isFilled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoLeadingZeroInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;
    if (newText.isEmpty) return newValue;
    if (newText.length == 1 && newText.startsWith('0')) return oldValue;
    if (!RegExp(r'^\d*$').hasMatch(newText)) return oldValue;
    return newValue;
  }
}
