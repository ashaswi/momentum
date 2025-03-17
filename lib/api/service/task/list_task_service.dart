import 'package:http/http.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';

class ListTaskService {
  Future<Response> listTasks(String status) async {
    return Api.get(ApiRoutes.task,params:  {'status': status});
  }
}