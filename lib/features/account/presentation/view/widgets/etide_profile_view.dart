import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/di/service_locator.dart';
import 'package:sakeena_app/core/utils/app_router.dart';

import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:sakeena_app/core/widgets/coustem_text_form_filed.dart';
import 'package:sakeena_app/core/widgets/snack_bar_helper.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_cubit.dart';
import 'package:sakeena_app/features/account/logic/cubit/account_state.dart';

import 'package:sakeena_app/features/account/presentation/view/widgets/custom_user_image.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/forget_pass_app_bar.dart';

class EditProfileView extends StatefulWidget {
  EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  late final AccountCubit cubit;

  @override
  void initState() {
    super.initState();

    // ❗ خليها getIt عادي زي ما عندك
    cubit = getIt<AccountCubit>();

    // 🔥 تحميل البيانات
    cubit.getProfile();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: BlocListener<AccountCubit, AccountState>(
        listenWhen: (previous, current) {
          // 🔥 مهم جدًا: يخلي listener يشتغل على التغيرات فقط
          return current is ProfileLoaded ||
              current is ProfileUpdated ||
              current is AccountError;
        },
        listener: (context, state) {
          if (state is ProfileLoaded) {
            firstNameController.text = state.profile.firstName;
            lastNameController.text = state.profile.lastName;
            emailController.text = state.profile.email;
          }

          if (state is ProfileUpdated) {
            SnackBarHelper.showSuccess(context, message: 'تم تحديث البيانات');

            context.pushReplacement(AppRouter.kprofileview);
          }

          if (state is AccountError) {
            SnackBarHelper.showError(context, message: state.message);
          }
        },
        child: Scaffold(
          backgroundColor: Color(0xFFFFFAF7),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  CustomAppBar(titel: 'تعديل الملف الشخصي'),
                  SizedBox(height: 10.h),

                  CustomUserImage(),

                  SizedBox(height: 30.h),

                  // الاسم
                  Row(
                    children: [
                         Expanded(
                        child: CoustemTextFormFailed(
                          hent: "الاسم الاول",
                          controller: firstNameController,
                        ),
                      ),
                       SizedBox(width: 12.w),
                      Expanded(
                        child: CoustemTextFormFailed(
                          hent: "الاسم الاخير",
                          controller: lastNameController,
                        ),
                      ),
                     
                   
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // الايميل
                  CoustemTextFormFailed(
                    hent: "الايميل",
                    controller: emailController,
                  ),

                  SizedBox(height: 40.h),

                  CoustemElevetedBoutten(
                    text: "حفظ التغييرات",
                    height: 55.h,
                    backgroundcolor: Color(0xFF9C2D5A),
                    onPressed: () {
                      cubit.updateProfile(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        email: emailController.text,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
