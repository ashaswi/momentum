import 'package:http/http.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';
import 'package:momentum/api/dto/task_dto.dart';

class UpdateTaskService {
  Future<Response> updateTask(int taskId,TaskDto task) async {
    return Api.put('${ApiRoutes.task}$taskId/' ,task.toJson());
  }
}