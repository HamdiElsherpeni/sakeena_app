import 'package:flutter/material.dart';

class OtpStep extends StatefulWidget {
  const OtpStep({super.key});

  @override
  State<OtpStep> createState() => _OtpStepState();
}

class _OtpStepState extends State<OtpStep> {
  final int length = 5;
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(length, (_) => TextEditingController());
    focusNodes = List.generate(length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/forgetpass1.png', height: 200),
        const SizedBox(height: 20),
        const Text('ادخلي رمز التحقق'),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(length, (index) {
            return SizedBox(
              width: 50,
              height: 60,
              child: TextField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                textAlign: TextAlign.center,
                maxLength: 1,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.pink),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (index < length - 1) {
                      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                    } else {
                      focusNodes[index].unfocus(); // آخر خانة
                    }
                  } else {
                    if (index > 0) {
                      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
                    }
                  }
                },
                keyboardType: TextInputType.number,
              ),
            );
          }),
        ),
      ],
    );
  }
}