import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/chat/data/models/send_message_request_model.dart';
import 'package:sakeena_app/features/chat/presentation/view_model/send_message_cubit.dart';

class NoMessagesWidget extends StatelessWidget {
  const NoMessagesWidget({super.key});

  static const _suggestions = [
    'كيف أقوم بالفحص الذاتي؟',
    'ما هي علامات سرطان الثدي؟',
    'كيف أحمي نفسي من سرطان الثدي؟',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24.h),

            // Welcome bubble
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.border, width: 1.w),
                ),
                child: Text(
                  'مرحتنا بكِ! أنا سكينة مساعدتك الشخصية\nكيف يمكنني مساعدتك اليوم؟',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primary,
                    fontFamily: 'Rubik',
                    height: 1.5,
                  ),
                ),
              ),
            ),

            SizedBox(height: 8.h),

            // وقت
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                _currentTime(),
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColors.primary,
                  fontFamily: 'Rubik',
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // أسئلة شائعة label
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'أسئلة شائعة:',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ),
              ),
            ),

            SizedBox(height: 10.h),

            // الأسئلة
            ..._suggestions.map(
              (q) => GestureDetector(
                onTap: () {
                  context.read<SendMessageCubit>().sendMessage(
                    sendMessageRequestModel: SendMessageRequestModel(
                      message: q,
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.skipBg,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.border, width: 1.w),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        q,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik',
                        ),
                      ),
                      Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 14.sp,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _currentTime() {
    final now = DateTime.now();
    final h = now.hour % 12 == 0 ? 12 : now.hour % 12;
    final m = now.minute.toString().padLeft(2, '0');
    final amPm = now.hour < 12 ? 'am' : 'pm';
    return '$h:$m $amPm';
  }
}
