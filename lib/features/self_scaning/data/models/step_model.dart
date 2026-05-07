class ExamStep {
  final int stepNumber;
  final int totalSteps;
  final String title;
  final String subtitle;
  final String instruction;
  final List<String> tips;
  final bool isLastStep;
  final String? reminderText;
  final String? reminderCallToAction;

  const ExamStep({
    required this.stepNumber,
    required this.totalSteps,
    required this.title,
    required this.subtitle,
    required this.instruction,
    required this.tips,
    this.isLastStep = false,
    this.reminderText,
    this.reminderCallToAction,
  });
}

final List<ExamStep> examSteps = [
  ExamStep(
    stepNumber: 1,
    totalSteps: 5,
    title: 'الخطوة 1: النظر في المرآة',
    subtitle: 'افحصي ثديك بصرًا',
    instruction:
        'قفي أمام المرآة مع وضع ذراعيك على جانبيك.\nانظري بعناية إلى ثدييك وابحثي عن أي تغييرات في الحجم أو الشكل أو اللون.',
    tips: [
      'تحققي من تماثل الثديين',
      'ابحثي عن أي تجاعيد أو تنوعات',
      'لاحظي أي تغيرات في الحلمة',
    ],
  ),
  ExamStep(
    stepNumber: 2,
    totalSteps: 5,
    title: 'الخطوة 2: رفع الذراعين',
    subtitle: 'افحصي الثدين مع رفع الذراعين',
    instruction:
        'ارفعي ذراعيك فوق رأسك وافحصي ثدييك مرة أخرى. ابحثي عن نفس التغييرات.',
    tips: [
      'تأكدي من عدم وجود انكماش في الجلد',
      'لاحظي أي تغييرات في الشكل',
      'تحققي من الجزء السفلي من الثدين',
    ],
  ),
  ExamStep(
    stepNumber: 3,
    totalSteps: 5,
    title: 'الخطوة 3: الفحص أثناء الاستلقاء',
    subtitle: 'افحصي الثدين باستخدام أطراف أصابعك',
    instruction:
        'استلقي على ظهرك. استخدمي يدك اليمنى واليد اليسرى لفحص الثدي الأيمن والأيسر بالتناوب.\nاستخدمي أطراف الأصابع الثلاثة الوسطى.',
    tips: [
      'تحرکي بحركات دائرية صغيرة',
      'افحصي من الحلمة إلى الخارج',
      'استخدمي ضغط خفيف ثم متوسط ثم قوي',
    ],
  ),
  ExamStep(
    stepNumber: 4,
    totalSteps: 5,
    title: 'الخطوة 4: الفحص في الحمام',
    subtitle: 'افحصي الثدين أثناء الاستحمام',
    instruction:
        'يمكن أن يكون الفحص أسهل عندما يكون الجلد رطبًا. استخدمي نفس الحركات الدائرية لفحص كل جزء من الثدي والإبط.',
    tips: [
      'استخدمي الصابون لتسهيل الحركة',
      'افحصي الإبط أيضًا',
      'تحققي من أي كتل أو سماكة',
    ],
  ),
  ExamStep(
    stepNumber: 5,
    totalSteps: 5,
    title: 'الخطوة 5: متى تستشيري الطبيب',
    subtitle: 'علامات يجب الانتباه إليها',
    instruction: 'إذا لاحظت أيًا من التغييرات التالية، استشيري طبيبك فورًا:',
    tips: [
      'وجود كتلة أو سماكة في الثدي أو الإبط',
      'تغير في حجم أو شكل الثدي',
      'إفرازات من الحلمة (غير الحليب)',
      'احمرار أو تقشر في جلد الثدي',
      'ألم مستمر في منطقة معينة',
    ],
    isLastStep: true,
    reminderText:
        'يُنصح بإجراء الفحص الذاتي مرة واحدة شهريًا، ويفضل بعد أسبوع من انتهاء الدورة الشهرية عندما يكون الثدي أقل حساسية.',
    reminderCallToAction: 'هل لديك أسئلة؟ تحدثي مع سكينة',
  ),
];
