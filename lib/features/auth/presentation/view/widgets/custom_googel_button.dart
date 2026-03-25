import 'package:flutter/material.dart';

class CustomGoogelButton extends StatelessWidget {
  const CustomGoogelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Image.asset(
          'assets/images/googel_icon.png',
          width: 20,
          height: 20,
        ),
        label: Text(
          'حساب Google',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
