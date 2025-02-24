class ForgotPasswordRequestDto {
  final String? email;
  const ForgotPasswordRequestDto({
    this.email,
  });

  factory ForgotPasswordRequestDto.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordRequestDto(
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}