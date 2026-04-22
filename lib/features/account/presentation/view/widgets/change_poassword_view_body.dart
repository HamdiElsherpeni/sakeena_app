import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:sakeena_app/core/widgets/snack_bar_helper.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_cubit.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_state.dart';
import 'package:sakeena_app/features/account/presentation/view/widgets/profile_forms/change_password_form.dart';

import 'change_password_header.dart';

class ChangePasswordViewBody extends StatefulWidget {
  ChangePasswordViewBody({super.key});

  @override
  State<ChangePasswordViewBody> createState() => _ChangePasswordViewBodyState();
}

class _ChangePasswordViewBodyState extends State<ChangePasswordViewBody> {
  String currentPassword = '';
  String newPassword = '';
  bool isValid = false;

  void _onChanged(String current, String newPass, String confirm, bool valid) {
    setState(() {
      currentPassword = current;
      newPassword = newPass;
      isValid = valid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state is PasswordChanged) {
          SnackBarHelper.showSuccess(
            context,
            message: 'تم تغيير كلمة المرور بنجاح',
          );
          Navigator.pop(context);
        } else if (state is AccountError) {
          SnackBarHelper.showError(context, message: state.message);
        }
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChangePasswordHeader(),
            SizedBox(height: 10.h),
            Text(
              'يرجى إدخال كلمة المرور الحالية وكلمة المرور الجديدة\nلضمان حماية حسابك.',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 15.sp, color: Colors.grey),
            ),
            SizedBox(height: 30.h),
            ChangePasswordForm(onChanged: _onChanged),
            SizedBox(height: 40.h),
            CoustemElevetedBoutten(
              text: 'تحديث كلمة المرور',
              height: 55.h,
              backgroundcolor: isValid ? AppColors.primary : Colors.grey,
              onPressed: isValid
                  ? () {
                      context.read<AccountCubit>().changePassword(
                        currentPassword: currentPassword,
                        newPassword: newPassword,
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
