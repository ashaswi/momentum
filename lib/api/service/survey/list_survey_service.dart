import 'package:http/http.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';

class ListSurveyService {
  Future<Response> listSurveys() async {
    return Api.get(ApiRoutes.survey);
  }
}