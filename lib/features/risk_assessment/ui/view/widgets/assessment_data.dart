class QuestionModel {
  final String text;
  final List<String> options;
  final String fieldName; // ← الـ key اللي بيتبعت للـ API
  final List<int> optionValues; // ← الـ int المقابل لكل option

  const QuestionModel({
    required this.text,
    required this.options,
    required this.fieldName,
    required this.optionValues,
  });
}

const List<String> steps = ['الشخصية', 'الهرمونية', 'العائلية', 'الطبية'];

final Map<int, List<QuestionModel>> stepQuestions = {
  1: [
    QuestionModel(
      fieldName: 'ageGroup',
      text: 'ما هي فئتك العمرية؟',
      options: ['أقل من 30 عاما', '30-39 سنة', '40 - 50 سنة', 'فوق ال 50 سنة'],
      optionValues: [0, 1, 2, 3],
    ),
    QuestionModel(
      fieldName: 'ethnicity',
      text: 'ما هو عرقك أو أصلك الجيني؟',
      options: ['عربي / قوقازي', 'غير ذلك'],
      optionValues: [0, 1],
    ),
    QuestionModel(
      fieldName: 'bmiCategory',
      text: 'ما هو مؤشر كتلة جسمك (BMI)؟',
      options: ['وزن مثالي', 'زيادة في الوزن', 'سمنة (أكثر من 30)'],
      optionValues: [0, 1, 2],
    ),
  ],

  2: [
    QuestionModel(
      fieldName: 'menarcheAge',
      text: 'في أي سن بدأت الدورة الشهرية لأول مرة؟',
      options: ['قبل سن 12', 'بين 12 و14 سنة', 'بعد 14 سنة'],
      optionValues: [0, 1, 2],
    ),
    QuestionModel(
      fieldName: 'pregnancyHistory',
      text: 'بخصوص الحمل والولادة:',
      options: [
        'أنجبت أول طفل قبل سن 30',
        'أنجبت أول طفل بعد سن 30',
        'لم يحدث حمل أو ولادة',
      ],
      optionValues: [0, 1, 2],
    ),
    QuestionModel(
      fieldName: 'menopauseStatus',
      text: 'هل مررت بمرحلة انقطاع الطمث؟',
      options: [
        'لا، لم أصل لها بعد',
        'نعم، بدون علاج هرموني',
        'نعم، مع علاج هرموني تعويضي (HRT)',
      ],
      optionValues: [0, 1, 2],
    ),
  ],

  3: [
    QuestionModel(
      fieldName: 'familyHistoryLevel',
      text: 'هل أصيبت أم، أخت، أو ابنة بسرطان الثدي أو المبيض؟',
      options: ['لا يوجد', 'قريبة واحدة فقط', 'أكثر من قريبة'],
      optionValues: [0, 1, 2],
    ),
    QuestionModel(
      fieldName: 'earlyFamilyDiagnosis',
      text: 'هل أصيبت أي قريبة بالسرطان قبل سن 45؟',
      options: ['نعم', 'لا'],
      optionValues: [0, 1],
    ),
    QuestionModel(
      fieldName: 'brcaMutation',
      text: 'هل تم اكتشاف طفرة BRCA1 أو BRCA2 لديك؟',
      options: ['نعم', 'لا / لم أجرِ الفحص'],
      optionValues: [0, 1],
    ),
  ],

  4: [
    QuestionModel(
      fieldName: 'breastDensity',
      text: 'هل أخبرك الطبيب بأن لديك أنسجة ثدي كثيفة؟',
      options: ['نعم', 'لا', 'لم أقم بعمل أشعة من قبل'],
      optionValues: [0, 1, 2],
    ),
    QuestionModel(
      fieldName: 'biopsyResult',
      text: 'هل سبق وأخذت عينة من الثدي لديك؟',
      options: ['نعم', 'لا / كانت النتيجة حميدة', 'لم أحتج لإجراء عينة'],
      optionValues: [0, 1, 2],
    ),
    QuestionModel(
      fieldName: 'radiationHistory',
      text: 'هل تعرضت لعلاج إشعاعي في منطقة الصدر سابقاً؟',
      options: ['نعم', 'لا'],
      optionValues: [0, 1],
    ),
  ],
};
