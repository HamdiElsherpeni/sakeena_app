import 'package:flutter/material.dart';
import 'rule_item.dart';

class PasswordRules extends StatelessWidget {
  final bool hasLower;
  final bool hasUpper;
  final bool hasNumber;
  final bool hasSpecial;

  const PasswordRules({
    super.key,
    required this.hasLower,
    required this.hasUpper,
    required this.hasNumber,
    required this.hasSpecial,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RuleItem(condition: hasLower, text: "حرف صغير (a-z)"),
        RuleItem(condition: hasUpper, text: "حرف كبير (A-Z)"),
        RuleItem(condition: hasNumber, text: "رقم (0-9)"),
        RuleItem(condition: hasSpecial, text: "رمز (@\$!%*?&)"),
      ],
    );
  }
}