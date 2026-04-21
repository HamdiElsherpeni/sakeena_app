class ResetPasswordRequestModel {
  final String email;
  final String code;
  final String newPassword;
  final String confirmPassword;

  ResetPasswordRequestModel({
    required this.email,
    required this.code,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'code': code,
    'NewPassword': newPassword,
    'ConfirmPassword': confirmPassword,
  };
}
