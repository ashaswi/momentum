import 'package:http/http.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';
//import 'package:momentum/api/dto/task_dto.dart';

class DeleteTaskService {
  Future<Response> deleteTask(int taskId,) async {
    return Api.delete('${ApiRoutes.task}$taskId/');
  }
}