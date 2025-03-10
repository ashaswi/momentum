import 'package:http/http.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';
import 'package:momentum/api/dto/habit_dto.dart';

class CreateHabitService {
  Future<Response> createHabit(HabitDto habit) async {
    return Api.post(ApiRoutes.habit,habit.toJson());
  }
}