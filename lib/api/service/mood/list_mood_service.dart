import 'package:http/http.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';

class ListMoodService {
  Future<Response> listMoods() async {
    return Api.get(ApiRoutes.mood);
  }
}