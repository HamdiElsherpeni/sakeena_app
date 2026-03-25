import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:sakeena_app/core/widgets/coustem_text_form_filed.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/custom_googel_button.dart';

class SinUpViewBody extends StatefulWidget {
  const SinUpViewBody({super.key});

  @override
  State<SinUpViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<SinUpViewBody> {
  bool isObscure = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 21,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.KprimaryColor,
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // عنوان ترحيبي
          Text(
            'أهلاً بك في سكينة!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 10),
          Text(
            'رحلتك نحو الوقاية والعناية بنفسك تبدأ من هنا.',
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 30),
          // الايميل
          Text(
            'الاسم كامل',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          CoustemTextFormFailed(
            hent: ' مثال:ندي محمد زعبلاوي',
            controller: emailController,
          ),

          const SizedBox(height: 30),
          // الايميل
          Text(
            'الايميل',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          CoustemTextFormFailed(
            hent: 'SakeenaTeam@gmail.com',
            controller: emailController,
          ),

          const SizedBox(height: 20),
          // الباسوورد
          Text(
            'الباسوورد',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          CoustemTextFormFailed(
            hent: 'ادخل كلمة المرور',
            obscure: isObscure,
            controller: passwordController,
            sufixIcon: IconButton(
              icon: Icon(
                isObscure ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
            ),
          ),

          const SizedBox(height: 10),
          // Forget Password
         

          const SizedBox(height: 20),
          CoustemElevetedBoutten(
            text:' انشاء حساب',
            backgroundcolor: AppColors.primary,
            height: 60,
          ),
          // زر تسجيل الحساب
          const SizedBox(height: 30),
          // أو تسجيل الدخول عبر Google
          Row(
            children: [
              Expanded(
                child: Divider(color: Colors.grey.shade400, thickness: 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'او سجل من خلال',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Expanded(
                child: Divider(color: Colors.grey.shade400, thickness: 1),
              ),
            ],
          ),
          const SizedBox(height: 30),

          CustomGoogelButton(),
          const SizedBox(height: 30),
          // رابط انشاء حساب جديد
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('لدي حساب بالفعل؟', style: TextStyle(color: Colors.grey)),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'سجلي من هنا',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
