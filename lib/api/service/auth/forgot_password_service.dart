import 'package:http/http.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';
import 'package:momentum/api/dto/forgot_password_dto.dart';
import 'package:momentum/api/dto/forgot_password_request_dto.dart';

class ForgotPasswordService {
  Future<Response> forgotPasswordRequest(ForgotPasswordRequestDto forgotPasswordRequestDto) async {
    return Api.post(ApiRoutes.forgotPasswordRequest, forgotPasswordRequestDto.toJson());
  }
    Future<Response> forgotPassword(ForgotPasswordDto forgotPasswordDto) async {
    return Api.post(ApiRoutes.forgotPassword, forgotPasswordDto.toJson());
  }
}