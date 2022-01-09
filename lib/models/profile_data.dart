class ProfileData {
  final String email;
  final String username;
  final String description;

  ProfileData({
    required this.email,
    required this.username,
    required this.description,
  });

  ProfileData.fromJson(Map<String, dynamic> json)
      : email = json['email'] ?? '',
        username = json['username'] ?? '',
        description = json['description'] ?? '';

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'description': description,
      };
}
