import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpStep extends StatefulWidget {
  final List<TextEditingController> controllers;

  const OtpStep({super.key, required this.controllers});

  @override
  State<OtpStep> createState() => _OtpStepState();
}

class _OtpStepState extends State<OtpStep> {
  final int length = 5;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/forgetpass1.png', height: 200.h),
            SizedBox(height: 20.h),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                'ادخلي رمز التحقق',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(length, (index) {
                return SizedBox(
                  width: 50.w,
                  height: 60.h,
                  child: KeyboardListener(
                    focusNode: FocusNode(),
                    onKeyEvent: (event) {
                      if (event is KeyDownEvent &&
                          event.logicalKey == LogicalKeyboardKey.backspace &&
                          widget.controllers[index].text.isEmpty &&
                          index > 0) {
                        FocusScope.of(
                          context,
                        ).requestFocus(focusNodes[index - 1]);
                      }
                    },
                    child: TextField(
                      controller: widget.controllers[index],
                      focusNode: focusNodes[index],
                      textAlign: TextAlign.center,
                      // ✅ شيلنا maxLength وهنتحكم يدوياً
                      style: TextStyle(fontSize: 20.sp),
                      keyboardType: TextInputType.number,
                      textDirection: TextDirection.ltr,
                      inputFormatters: [
                        // ✅ بنسمح برقم واحد بس
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(1),
                      ],
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Colors.transparent,
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: Colors.pink),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Colors.pinkAccent,
                            width: 2.w,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < length - 1) {
                          FocusScope.of(
                            context,
                          ).requestFocus(focusNodes[index + 1]);
                        }
                        if (value.isEmpty && index > 0) {
                          FocusScope.of(
                            context,
                          ).requestFocus(focusNodes[index - 1]);
                        }
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
