import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena_app/core/resources/app_colors.dart';
import 'package:sakeena_app/core/utils/app_router.dart';
import 'package:sakeena_app/features/education/data/models/article_model.dart';

class EducationArticlesSection extends StatelessWidget {
  const EducationArticlesSection({super.key});

  static const _articles = [
    ArticleModel(
      title: 'التغذية السليمة ودورها في الوقاية',
      subtitle:
          'كيف يمكن للنظام الغذائي الصحي أن يساعد في تقليل مخاطر الإصابة...',
      minutes: 5,
      content: '''
التغذية السليمة تلعب دوراً محورياً في الوقاية من سرطان الثدي. إليكِ أبرز النصائح:

🥦 الخضروات والفواكه
تناولي كميات وفيرة من الخضروات الورقية والفواكه الملونة، فهي غنية بمضادات الأكسدة التي تحمي خلايا الجسم.

🌾 الحبوب الكاملة
استبدلي الخبز الأبيض والأرز المكرر بالحبوب الكاملة التي تحتوي على ألياف تساعد في تنظيم مستويات الهرمونات.

🐟 البروتين الصحي
أكثري من الأسماك الغنية بأوميغا-3 وقللي من اللحوم الحمراء والمصنعة.

🚫 تجنبي
- الأطعمة المصنعة والمحفوظة
- السكريات المضافة
- الدهون المشبعة والمهدرجة

💧 اشربي كميات كافية من الماء يومياً، لا تقل عن 8 أكواب.
      ''',
    ),
    ArticleModel(
      title: 'التعامل مع القلق والخوف',
      subtitle: 'نصائح نفسية للتعامل مع مخاوف الإصابة بسرطان الثدي...',
      minutes: 4,
      content: '''
القلق والخوف مشاعر طبيعية، لكن يمكن إدارتها بفاعلية:

🧘 التنفس العميق
خصصي 5 دقائق يومياً للتنفس العميق البطيء، فهو يهدئ الجهاز العصبي ويقلل التوتر.

📝 كتابة المخاوف
اكتبي مخاوفك على ورقة وبجانبها ما يمكنك فعله حيالها. هذا يحول القلق العام إلى خطوات عملية.

👭 الدعم الاجتماعي
لا تترددي في التحدث مع صديقة أو فرد من العائلة تثقين به. الحديث يخفف العبء النفسي.

🏃 النشاط البدني
المشي 30 دقيقة يومياً يفرز هرمونات السعادة ويقلل هرمونات التوتر بشكل ملحوظ.

💬 المساعدة المتخصصة
إذا استمر القلق لأكثر من أسبوعين، استشيري متخصصاً نفسياً. طلب المساعدة علامة قوة لا ضعف.
      ''',
    ),
    ArticleModel(
      title: 'قصص نجاح ملهمة',
      subtitle: 'تجارب واقعية لنساء تغلبن على سرطان الثدي...',
      minutes: 7,
      content: '''
قصص حقيقية من نساء تغلبن على التحدي:

🌸 قصة سارة - 34 عاماً
"اكتشفت الإصابة مبكراً خلال الفحص الذاتي الشهري. بدأت العلاج فوراً وبعد عام كامل أنا بصحة تامة. الفحص المبكر أنقذ حياتي."

🌺 قصة منى - 45 عاماً
"كنت خائفة جداً في البداية، لكن دعم عائلتي وفريق الأطباء المتميز أعطاني القوة. اليوم أشارك في جمعيات دعم المريضات."

🌼 قصة ريم - 52 عاماً
"أجريت الفحص الدوري رغم أنني لم أكن أشعر بأي أعراض. وجدوا ورماً صغيراً جداً في مرحلة مبكرة جداً. العلاج كان بسيطاً والنتيجة رائعة."

💪 الدرس المشترك
جميع هؤلاء النساء يؤكدن أن:
- الكشف المبكر هو المفتاح
- الدعم العاطفي ضروري
- الإيجابية والإرادة تصنعان فارقاً كبيراً
      ''',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'مقالات مفيدة',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
            fontFamily: 'Rubik',
          ),
        ),
        SizedBox(height: 12.h),
        ..._articles.map((a) => _ArticleCard(data: a)),
      ],
    );
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.data});
  final ArticleModel data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRouter.kArticleView, extra: data),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border, width: 1.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
                fontFamily: 'Rubik',
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              data.subtitle,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textSecondary,
                fontFamily: 'Rubik',
                height: 1.4,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${data.minutes} دقائق',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.textSecondary,
                    fontFamily: 'Rubik',
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 12.sp,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'اقرأي المزيد',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Rubik',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
