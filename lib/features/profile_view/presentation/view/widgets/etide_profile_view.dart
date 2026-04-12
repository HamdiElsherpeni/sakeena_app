import 'package:flutter/material.dart';
import 'package:sakeena_app/core/resources/app_assets.dart';
import 'package:sakeena_app/core/widgets/coustem_eleveted_butten.dart';
import 'package:sakeena_app/core/widgets/coustem_text_form_filed.dart';
import 'package:sakeena_app/features/auth/presentation/view/widgets/forget_pass_app_bar.dart';
import 'package:sakeena_app/features/profile_view/presentation/view/widgets/custom_user_image.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController firstNameController =
      TextEditingController(text: "سارة");

  final TextEditingController lastNameController =
      TextEditingController(text: "محمد");

  final TextEditingController emailController =
      TextEditingController(text: "saramohamed223@gmail.com");

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
         
          backgroundColor: const Color(0xFFFFFAF7),
        
        
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                
                children: [
                  const SizedBox(height: 10),

                  CustomAppBar(titel: 'تعديل الملف الشخصي'),
                  const SizedBox(height: 10),
        
                  // ── Avatar ──────────────────────────────────
                CustomUserImage(),
        
                  const SizedBox(height: 8),
        
                  const Text(
                    "انقري لتغيير الصورة",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
        
                  const SizedBox(height: 30),
        
                  // ── الاسم الأول والأخير جنب بعض ────────────
                  Row(
                    children: [
                      // الاسم الأخير (يسار)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "الاسم الاخير",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 6),
                            CoustemTextFormFailed(
                              hent: "الاسم الاخير",
                              controller: lastNameController,
                            ),
                          ],
                        ),
                      ),
        
                      const SizedBox(width: 12),
        
                      // الاسم الأول (يمين)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "الاسم الاول",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 6),
                            CoustemTextFormFailed(
                              hent: "الاسم الاول",
                              controller: firstNameController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
        
                  const SizedBox(height: 20),
        
                  // ── الإيميل ─────────────────────────────────
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "الايميل",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  CoustemTextFormFailed(
                    hent: "الايميل",
                    controller: emailController,
                  ),
        
                  const SizedBox(height: 40),
        
                  // ── زرار الحفظ ───────────────────────────────
                  CoustemElevetedBoutten(
                    text: "حفظ التغييرات",
                    backgroundcolor: const Color(0xFF9C2D5A),
                    height: 55,
                    onPressed: () {},
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