import 'package:http/http.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';

class ReadProfileService {
  Future<Response> readProfile() async {
    return Api.get(ApiRoutes.profile);
  }
}