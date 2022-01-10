class UserProfileData {
  final String email;
  final String username;
  final String description;
  final String avatar;

  UserProfileData({
    required this.email,
    required this.username,
    required this.description,
    required this.avatar,
  });

  UserProfileData.fromJson(Map<String, dynamic> json)
      : email = json['email'] ?? '',
        username = json['username'] ?? '',
        description = json['description'] ?? '',
        avatar = json['avatar'] ?? '';

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'description': description,
        'avatar': avatar,
      };
}
