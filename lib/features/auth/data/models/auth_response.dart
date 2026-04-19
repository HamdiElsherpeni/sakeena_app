class AuthResponse {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String token;
  final int expiresIn;
  final String refreshToken;
  final String refreshTokenExpiration;

  AuthResponse({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.token,
    required this.expiresIn,
    required this.refreshToken,
    required this.refreshTokenExpiration,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    id: json['id'],
    email: json['email'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    token: json['token'],
    expiresIn: json['expiresIn'],
    refreshToken: json['refreshToken'],
    refreshTokenExpiration: json['refreshTokenExpiration'],
  );
}
