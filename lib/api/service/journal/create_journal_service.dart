
import 'package:http/http.dart';
import 'package:momentum/api/api.dart';
import 'package:momentum/api/api_routes.dart';
import 'package:momentum/api/dto/journal_dto.dart';

class CreateJournalService {
  Future<Response> createJournal(JournalDto journal) async {
    return Api.post(ApiRoutes.journal,journal.toJson());
  }
}