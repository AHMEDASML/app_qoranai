import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';

class CustomVerificationCode extends StatefulWidget {
  final int length;
  final ValueChanged<String> onCompleted;

  const CustomVerificationCode({
    super.key,
    required this.length,
    required this.onCompleted,
  });

  @override
  State<CustomVerificationCode> createState() => _CustomVerificationCodeState();
}

class _CustomVerificationCodeState extends State<CustomVerificationCode> {
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];
  String code = "";

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.length; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _updateCode() {
    String newCode = "";
    for (var controller in _controllers) {
      if (controller.text.isNotEmpty) {

        if (RegExp(r'^[0-9]$').hasMatch(controller.text)) {
          newCode += controller.text;
        }
      }
    }
    code = newCode;
    print("🔢 Current verification code: '$code' (length: ${code.length})");


    widget.onCompleted(code);

    if (code.length == widget.length) {
      print("✅ Code completed: '$code'");
    }
  }

  // إضافة دالة لتنظيف الحقول
  void _clearFields() {
    for (var controller in _controllers) {
      controller.clear();
    }
    code = "";
    widget.onCompleted(code);
    if (_focusNodes.isNotEmpty) {
      FocusScope.of(context).requestFocus(_focusNodes[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.length, (index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              alignment: Alignment.center,
              width: 35.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: AppColors.greyVerfication,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.sp, color: Colors.black),
                maxLength: 1,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                ),
                onChanged: (value) {
                  print("📝 Input at position $index: '$value'");

                  // التأكد من أن المدخل رقم فقط
                  if (value.isNotEmpty && !RegExp(r'^[0-9]$').hasMatch(value)) {
                    _controllers[index].clear();
                    return;
                  }

                  if (value.isNotEmpty) {
                    if (index < widget.length - 1) {
                      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                    } else {
                      _focusNodes[index].unfocus();
                    }
                  } else {
                    if (index > 0) {
                      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                    }
                  }

                  _updateCode();
                },
                onTap: () {
                  _controllers[index].selection = TextSelection.fromPosition(
                    TextPosition(offset: _controllers[index].text.length),
                  );
                },
              ),
            );
          }),
        ),
        // إضافة زر مسح الحقول للتجربة
        SizedBox(height: 10.h),
        TextButton(
          onPressed: _clearFields,
          child: Text(
            "مسح الحقول",
            style: TextStyle(color: AppColors.primary, fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}