import 'package:http/http.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';
import 'package:momentum/api/dto/task_dto.dart';

class CreateTaskService {
  Future<Response> createTask(TaskDto task) async {
    return Api.post(ApiRoutes.task,task.toJson());
  }
}