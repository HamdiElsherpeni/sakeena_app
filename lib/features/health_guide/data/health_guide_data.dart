import 'models/health_guide_models.dart';

class HealthGuideData {
  static const List<HealthCategory> categories = [
    HealthCategory(
      id: 'prevention',
      title: 'الوقاية',
      icon: '🛡️',
      color: 'pink',
    ),
    HealthCategory(
      id: 'nutrition',
      title: 'التغذية',
      icon: '🥗',
      color: 'green',
    ),
    HealthCategory(
      id: 'exercise',
      title: 'الرياضة',
      icon: '🏃‍♀️',
      color: 'blue',
    ),
    HealthCategory(
      id: 'awareness',
      title: 'التوعية',
      icon: '💡',
      color: 'yellow',
    ),
    HealthCategory(
      id: 'selfcheck',
      title: 'الفحص الذاتي',
      icon: '🤲',
      color: 'purple',
    ),
    HealthCategory(
      id: 'mental',
      title: 'الصحة النفسية',
      icon: '🧠',
      color: 'orange',
    ),
  ];

  static const List<HealthArticle> articles = [
    // Prevention
    HealthArticle(
      id: 'a1',
      categoryId: 'prevention',
      title: 'كيف تحمين نفسك من سرطان الثدي؟',
      summary: 'خطوات بسيطة يومية تقلل من خطر الإصابة',
      content:
          'الوقاية تبدأ بالوعي. إجراء الفحص الدوري كل 6 أشهر، والحفاظ على وزن صحي، وممارسة الرياضة بانتظام كلها عوامل تساهم في تقليل الخطر. تجنبي التدخين والكحول، والتزمي بنظام غذائي متوازن غني بالخضروات والفواكه.',
      readTime: '3 دقائق',
    ),
    HealthArticle(
      id: 'a2',
      categoryId: 'prevention',
      title: 'أهمية الكشف المبكر',
      summary: 'لماذا الكشف المبكر ينقذ الأرواح؟',
      content:
          'الكشف المبكر يرفع نسبة الشفاء إلى أكثر من 95٪. ماموغرام سنوي للنساء فوق الـ 40، والفحص الذاتي الشهري أدوات بسيطة لكنها قد تنقذ حياتك.',
      readTime: '4 دقائق',
    ),
    // Nutrition
    HealthArticle(
      id: 'a3',
      categoryId: 'nutrition',
      title: 'أطعمة تحمي من السرطان',
      summary: 'أدخلي هذه الأطعمة في نظامك الغذائي اليومي',
      content:
          'الكركم، البروكلي، التوت، الثوم، والشاي الأخضر كلها أغذية غنية بمضادات الأكسدة التي تساعد في الوقاية من السرطان. احرصي على تناول الأسماك الدهنية الغنية بأوميغا 3 مرتين أسبوعياً.',
      readTime: '5 دقائق',
    ),
    HealthArticle(
      id: 'a4',
      categoryId: 'nutrition',
      title: 'أطعمة يجب تجنبها',
      summary: 'تعرفي على الأطعمة التي تزيد من مخاطر الإصابة',
      content:
          'تجنبي الأطعمة المصنعة والمعلبة، واللحوم المصنعة، والدهون المشبعة. قللي من السكريات المضافة والمشروبات الغازية. الأطعمة المشوية على الفحم تحتوي على مواد مسرطنة يجب تجنبها.',
      readTime: '4 دقائق',
    ),
    // Exercise
    HealthArticle(
      id: 'a5',
      categoryId: 'exercise',
      title: 'الرياضة ودورها في الوقاية',
      summary: 'كم دقيقة رياضة يومياً تكفي للحماية؟',
      content:
          'الدراسات تُثبت أن 150 دقيقة أسبوعياً من النشاط البدني المعتدل تقلل خطر سرطان الثدي بنسبة 20-40٪. المشي السريع، السباحة، واليوغا خيارات ممتازة للبداية.',
      readTime: '3 دقائق',
    ),
    // Awareness
    HealthArticle(
      id: 'a6',
      categoryId: 'awareness',
      title: 'حقائق وأرقام عن سرطان الثدي',
      summary: 'إحصاءات مهمة يجب أن تعرفيها',
      content:
          'سرطان الثدي هو الأكثر شيوعاً بين النساء عالمياً. 1 من كل 8 نساء قد تُصاب به خلال حياتها. في مصر تتراوح نسبته بين 29-38٪ من سرطانات المرأة. التوعية والكشف المبكر سلاحنا الأقوى.',
      readTime: '5 دقائق',
    ),
    // Self Check
    HealthArticle(
      id: 'a7',
      categoryId: 'selfcheck',
      title: 'خطوات الفحص الذاتي الصحيح',
      summary: 'تعلمي كيف تفحصين نفسك في 5 دقائق',
      content:
          'قفي أمام المرآة وافحصي شكل الثدي. ارفعي ذراعيك للأعلى. ابحثي عن أي تغيرات في الشكل أو الحجم أو الجلد. استلقي وافحصي بأصابعك بحركات دائرية من الخارج للداخل. افحصي الإبط أيضاً.',
      readTime: '4 دقائق',
    ),
    // Mental
    HealthArticle(
      id: 'a8',
      categoryId: 'mental',
      title: 'كيف تتعاملين مع القلق والخوف؟',
      summary: 'الصحة النفسية جزء أساسي من رحلة الشفاء',
      content:
          'القلق طبيعي، لكن لا تتركيه يسيطر عليك. تحدثي مع أشخاص تثقين بهم، انضمي لمجموعات دعم، مارسي التأمل والتنفس العميق. طلب المساعدة النفسية قوة وليس ضعف.',
      readTime: '5 دقائق',
    ),
  ];

  static const List<HealthTip> quickTips = [
    HealthTip(
      icon: '💧',
      title: 'اشربي الماء',
      body: 'احرصي على شرب 8 أكواب ماء يومياً للحفاظ على صحة خلاياك.',
    ),
    HealthTip(
      icon: '😴',
      title: 'النوم الكافي',
      body: '7-8 ساعات نوم يومياً تعزز جهاز المناعة وتقلل الالتهابات.',
    ),
    HealthTip(
      icon: '🚭',
      title: 'ابتعدي عن التدخين',
      body: 'التدخين يزيد من خطر الإصابة بأنواع متعددة من السرطان.',
    ),
    HealthTip(
      icon: '📅',
      title: 'فحص دوري منتظم',
      body: 'لا تتأجلي موعد الفحص الدوري مهما كانت مشاغلك.',
    ),
  ];
}