class UserProfileModel {
  final String firstName;
  final String lastName;
  final String email;

  UserProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  String get fullName => '$firstName $lastName';

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      firstName: json['firstName'] ?? json['FirstName'] ?? '',
      lastName: json['lastName'] ?? json['LastName'] ?? '',
      email: json['email'] ?? json['Email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
  };
}
