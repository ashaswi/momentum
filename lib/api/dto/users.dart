class User {
  final String username;
  final String? email;
  final String? password;
  final String? confirmPassword;
  const User({
    required this.username,
    this.email,
    this.password,
    this.confirmPassword
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'confirm_password': confirmPassword
    };
  }
}