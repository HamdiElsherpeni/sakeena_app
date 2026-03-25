class OnBoardingModel {
  final String image;
  final String title;
  final String subTitle;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.subTitle,
  });
}

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
    image: 'assets/images/on_brding_image_1.png',
    title: 'اتعلمي تحمي نفسك',
    subTitle:
        'محتوى تعليمي بسيط يشمل فيديوهات وطريقة الفحص الذاتي يساعدك على فهم الوقاية والأعراض.',
  ),
  OnBoardingModel(
    image: 'assets/images/on_brding_image_2.png',
    title: 'اطمّني على نفسك بسهولة',
    subTitle:
        'استخدمي خاصية الفحص لمتابعة أي تغييرات واكتشاف مبكر يساعدك تتحركي بسرعة.',
  ),
  OnBoardingModel(
    image: 'assets/images/on_brding_image_3.png',
    title: 'اسألي في أي وقت',
    subTitle:
        'شات ذكي يجاوب على أسئلتك عن أعراض سرطان الثدي، الوقاية، والفحص الذاتي',
  ),
  OnBoardingModel(
    image: 'assets/images/on_brding_image_4.png',
    title: 'خصوصيتك أولويتنا',
    subTitle:
        'إحنا مهتمين بخصوصيتك. في سكينة بياناتكِ محفوظة ومشفّرة، ومش بيتم مشاركتها مع أي جهة إلا بموافقتك. وتقدري تتحكمي فيها وتعدّليها أو تحذفيها في أي وقت.',
  ),
];
