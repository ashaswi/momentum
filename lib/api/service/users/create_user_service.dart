import 'package:http/http.dart';
import 'package:momentum/api/dto/users.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';

class CreateUserSevice {
  Future<Response> createUser(User user) async {
    return Api.post(ApiRoutes.register,user.toJson());
  }
}