class UpdateProfileRequest {
  final String firstName;
  final String lastName;
  final String email;

  UpdateProfileRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
    'FirstName': firstName,
    'LastName': lastName,
    'email': email,
  };
}
