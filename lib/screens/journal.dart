import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:momentum/Screens/base_screen.dart';
import 'package:momentum/api/dto/journal_dto.dart';
import 'package:momentum/api/service/journal/create_journal_service.dart';
import 'package:momentum/api/service/journal/list_journal_service.dart';
import 'package:momentum/components/Header.dart';
import 'package:momentum/api/service/util_service.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _isLoading = false;
  List<dynamic> _journals = [];
  bool _listIsLoading = false;

  @override
  void initState() {
    super.initState();
    _listIsLoading = true;
    _fetchJournals();
  }
    void _fetchJournals() async {
    try {
      Response response = await ListJournalService().listJournals();
      if (response.statusCode == 200) {
        _journals = jsonDecode(response.body);
           } else {
        _listIsLoading = false;
        const SnackBar(
          content: Text('Failed to fetch journals'),
          backgroundColor: Colors.red,
        );
      }
      _listIsLoading = false;
      setState(() {});
    } catch (e) {
      setState(() => _listIsLoading = false);
      SnackBar(
        content: Text('Failed to fetch journals: $e'),
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF371B34)), 
          onPressed: () {
            Navigator.pushNamed(context, '/dashboard');
          },
        ),
        title: const Text(
          'Journal',
          style: TextStyle(
            color: Color(0xFF371B34),
          ),
        ),
      ),
      body: BaseScreen(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(
              primayHeaderText: 'Your Journal',
              secondaryHeaderText: 'Reflect, release, grow',
              secondaryTextSize: 16,
            ),
            const SizedBox(height: 20),
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 0.5,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Title',
                      ),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      getFormattedDate(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    TextField(
                      controller: _contentController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Tap here to start writing',
                        border: InputBorder.none,
                      ),
                    ),
                    ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                JournalDto journalDto = JournalDto(
                  title: _titleController.text,
                  content: _contentController.text,
                );
                CreateJournalService createJournalService = CreateJournalService();
                Response response = await createJournalService.createJournal(journalDto);
                var responseBody = jsonDecode(response.body);
                setState(() {
                  _isLoading = false;
                });
                if (response.statusCode == 201) {
                  _fetchJournals();
                  _titleController.clear();
                  _contentController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Journal entry created successfully"),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  String firstKey = responseBody.keys.first;
                  String errorMsg = responseBody[firstKey][0];
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("$firstKey: $errorMsg"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      'Make Entry',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                          ),
                    ),
            ),
            const SizedBox(height: 30),
            Text(
              'Your Past Entries',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: const Color(0xFF371B34),
                  ),
                  ),
            const SizedBox(height: 10),
            _listIsLoading ? const Center(child: CircularProgressIndicator()) :
            ListView.builder(
              itemCount: _journals.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color(0xFF7140FC), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _journals[index]['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          _journals[index]['content'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                        ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}