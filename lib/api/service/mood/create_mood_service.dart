import 'package:http/http.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';
import 'package:momentum/api/dto/mood_dto.dart';

class CreateMoodService {
  Future<Response> createMood(MoodDto mood) async {
    return Api.post(ApiRoutes.mood,mood.toJson());
  }
}