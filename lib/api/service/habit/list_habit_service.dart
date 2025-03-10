import 'package:http/http.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';

class ListHabitService {
  Future<Response> listHabits() async {
    return Api.get(ApiRoutes.habit);
  }
}