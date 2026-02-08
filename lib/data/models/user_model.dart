class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.password,
  });

  final String id;
  final String name;
  final String email;
  final String? password;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? '').toString(),
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // Temporary use model as DTO for simplicity
  factory UserModel.loginDTO(Map<String, dynamic> json) {
    return UserModel(
      id: '',
      name: '',
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }

  // Temporary use model as DTO for simplicity
  factory UserModel.registerDTO(Map<String, dynamic> json) {
    return UserModel(
      id: '',
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );
  }
}
