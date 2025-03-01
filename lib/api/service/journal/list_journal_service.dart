import 'package:http/http.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';

class ListJournalService {
  Future<Response> listJournals() async {
    return Api.get(ApiRoutes.journal);
  }
}