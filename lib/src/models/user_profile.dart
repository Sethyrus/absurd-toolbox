class UserProfile {
  final String email;
  final String username;
  final String description;
  final String avatar;

  UserProfile({
    required this.email,
    required this.username,
    required this.description,
    required this.avatar,
  });

  UserProfile clone() {
    return UserProfile(
      email: email,
      username: username,
      description: description,
      avatar: avatar,
    );
  }

  bool isSameAs(UserProfile profile) => !(profile.email != email ||
      profile.username != username ||
      profile.description != description ||
      profile.avatar != avatar);

  UserProfile.fromJson(Map<String, dynamic> json)
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
