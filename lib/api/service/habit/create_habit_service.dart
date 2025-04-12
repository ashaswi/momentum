import 'package:http/http.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';
import 'package:momentum/api/dto/habit_dto.dart';
import 'package:momentum/api/service/notification/notification_service.dart';

class CreateHabitService {
  Future<Response> createHabit(HabitDto habit) async {
    scheduleNotification(habit.name, '',DateTime.parse(habit.date + " " +  habit.time));
    return Api.post(ApiRoutes.habit,habit.toJson());
  }
}