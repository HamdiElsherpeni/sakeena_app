import 'package:flutter/material.dart';

class CustomWellcomeTextSinUp extends StatelessWidget {
  const CustomWellcomeTextSinUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'أهلاً بك في سكينة!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          textAlign: TextAlign.right,
        ),
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'اهلا بك في',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              textAlign: TextAlign.right,
            ),
            Text(
              ' سكينة!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.right,
            ),
            Text(
              '- قومي بانشاء حساب ',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        Text('لاستخدام التطبيق '),
      ],
    );
  }
}
