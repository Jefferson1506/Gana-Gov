class UserModel {
  final String username;
  final String password;
  final String role;

  UserModel({
    required this.username,
    required this.password,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      username: data['User'] ?? '',
      password: data['clave'] ?? '',
      role: data['rol'] ?? '',
    );
  }
}
