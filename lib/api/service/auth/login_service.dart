import 'package:http/http.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';
import 'package:momentum/api/dto/login_dto.dart';

class LoginService {
  Future<Response> login(LoginDto loginDto) async {
    return Api.post(ApiRoutes.login, loginDto.toJson());
  }
}