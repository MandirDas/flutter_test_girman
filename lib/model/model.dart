class User {
  final String firstName;
  final String lastName;
  final String city;
  final String contactNumber;

  User({
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.contactNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      city: json['city'] as String? ?? '',
      contactNumber: json['contact_number'] as String? ?? '',
    );
  }
}
