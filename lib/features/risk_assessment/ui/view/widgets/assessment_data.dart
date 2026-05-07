class QuestionModel {
  final String text;
  final List<String> options;

  const QuestionModel({required this.text, required this.options});
}

const List<String> steps = ['الشخصية', 'الهرمونية', 'العائلية', 'الطبية'];

final Map<int, List<QuestionModel>> stepQuestions = {
  1: [
    QuestionModel(
      text: 'ما هي فئتك العمرية؟',
      options: ['أقل من 30 عاما', '30-39 سنة', '40 - 50 سنة', 'فوق ال 50 سنة'],
    ),

    QuestionModel(
      text: 'ما هو عرقك أو أصلك الجيني؟',
      options: ['عربي / قوقازي', 'غير ذلك'],
    ),

    QuestionModel(
      text: 'ما هو مؤشر كتلة جسمك (BMI)؟',
      options: ['وزن مثالي', 'زيادة في الوزن', 'سمنة (أكثر من 30)'],
    ),
  ],

  2: [
    QuestionModel(
      text: 'في أي سن بدأت الدورة الشهرية لأول مرة؟',
      options: ['قبل سن 12', 'بين 12 و14 سنة', 'بعد 14 سنة'],
    ),

    QuestionModel(
      text: 'بخصوص الحمل والولادة:',
      options: [
        'أنجبت أول طفل قبل سن 30',
        'أنجبت أول طفل بعد سن 30',
        'لم يحدث حمل أو ولادة',
      ],
    ),

    QuestionModel(
      text: 'هل مررت بمرحلة انقطاع الطمث؟',
      options: [
        'لا، لم أصل لها بعد',
        'نعم، بدون علاج هرموني',
        'نعم، مع علاج هرموني تعويضي (HRT)',
      ],
    ),
  ],

  3: [
    QuestionModel(
      text: 'هل أصيبت أم، أخت، أو ابنة بسرطان الثدي أو المبيض؟',
      options: ['لا يوجد', 'قريبة واحدة فقط', 'أكثر من قريبة'],
    ),

    QuestionModel(
      text: 'هل أصيبت أي قريبة بالسرطان قبل سن 45؟',
      options: ['نعم', 'لا'],
    ),

    QuestionModel(
      text: 'هل تم اكتشاف طفرة BRCA1 أو BRCA2 لديك؟',
      options: ['نعم', 'لا / لم أجرِ الفحص'],
    ),
  ],

  4: [
    QuestionModel(
      text: 'هل أخبرك الطبيب بأن لديك أنسجة ثدي كثيفة؟',
      options: ['نعم', 'لا', 'لم أقم بعمل أشعة من قبل'],
    ),

    QuestionModel(
      text: 'هل سبق وأخذت عينة من الثدي لديك؟',
      options: ['نعم', 'لا / كانت النتيجة حميدة', 'لم أحتج لإجراء عينة'],
    ),

    QuestionModel(
      text: 'هل تعرضت لعلاج إشعاعي في منطقة الصدر سابقاً؟',
      options: ['نعم', 'لا'],
    ),
  ],
};
