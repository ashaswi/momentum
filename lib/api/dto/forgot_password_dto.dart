class ForgotPasswordDto {
  final String? email;
  final String? code;
  final String? newPassword;
  final String? confirmNewPassword;
  const ForgotPasswordDto({
    this.email,
    this.newPassword,
    this.confirmNewPassword,
    this.code
  });

  factory ForgotPasswordDto.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordDto(
      email: json['email'],
      newPassword: json['new_password'],
      confirmNewPassword: json['confirmNewPassword'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'email': email,
      'new_password': newPassword,
      'confirm_new_password':confirmNewPassword 
    };
  }
}