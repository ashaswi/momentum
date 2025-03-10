import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:momentum/Screens/base_screen.dart';
import 'package:momentum/api/dto/mood_dto.dart';
import 'package:momentum/api/service/mood/create_mood_service.dart';
import 'package:momentum/api/service/mood/list_mood_service.dart';
import 'package:momentum/components/Header.dart';
import 'package:momentum/api/service/util_service.dart';

class Mood extends StatefulWidget {
  const Mood({super.key});

  @override
  State<Mood> createState() => _MoodState();
}

class _MoodState extends State<Mood> {
  final TextEditingController _contentController = TextEditingController();
  bool _isLoading = false;
  List<dynamic> _moods = [];
  bool _listIsLoading = false;
  String _feeling = '';

  @override
  void initState() {
    super.initState();
    _listIsLoading = true;
    _fetchMoods();
  }

  void updateFeeling(String mood) {
    setState(() {
      _feeling = mood;
    });
  }

  void _fetchMoods() async {
    try {
      Response response = await ListMoodService().listMoods();
      if (response.statusCode == 200) {
        _moods = jsonDecode(response.body);
      } else {
        _listIsLoading = false;
        const SnackBar(
          content: Text('Failed to fetch mood entries'),
          backgroundColor: Colors.red,
        );
      }
      _listIsLoading = false;
      setState(() {});
    } catch (e) {
      setState(() => _listIsLoading = false);
      SnackBar(
        content: Text('Failed to fetch mood entries: $e'),
        backgroundColor: Colors.red,
      );
    }
  }

  Widget moodButton(String mood, String assetPath) {
    bool isSelected = _feeling == mood;

    return GestureDetector(
      onTap: () => updateFeeling(mood),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            EdgeInsets.all(isSelected ? 8 : 0), // Add padding when selected
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? Colors.blue.withOpacity(0.3)
              : Colors.transparent, // Highlight selected
        ),
        child: SvgPicture.asset(
          assetPath,
          height: isSelected ? 50 : 40, // Enlarge selected icon
          width: isSelected ? 50 : 40,
        ),
      ),
    );
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
          'Mood Tracker',
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
              primayHeaderText: 'Track Your Mood',
              secondaryHeaderText: 'Feel, track, evolve',
              secondaryTextSize: 16,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      moodButton('great', 'assets/images/moods/great.svg'),
                      moodButton('happy', 'assets/images/moods/happy.svg'),
                      moodButton('neutral', 'assets/images/moods/neutral.svg'),
                      moodButton('upset', 'assets/images/moods/upset.svg'),
                      moodButton('sad', 'assets/images/moods/sad.svg'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      moodButton('angry', 'assets/images/moods/angry.svg'),
                      moodButton('annoyed', 'assets/images/moods/annoyed.svg'),
                      moodButton('sick', 'assets/images/moods/sick.svg'),
                      moodButton('scared', 'assets/images/moods/scared.svg'),
                      moodButton('bored', 'assets/images/moods/bored.svg'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 0.5,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Why?",
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
                MoodDto moodDto = MoodDto(
                  feeling: _feeling,
                  content: _contentController.text,
                );
                CreateMoodService createMoodService = CreateMoodService();
                Response response = await createMoodService.createMood(moodDto);
                var responseBody = jsonDecode(response.body);
                setState(() {
                  _isLoading = false;
                });
                if (response.statusCode == 201) {
                  _fetchMoods();
                  _feeling = '';
                  _contentController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Mood entry created successfully"),
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
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
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
            _listIsLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _moods.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Card(
                          color: const Color(0xFF7140FC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Column(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/images/moods/${_moods[index]['feeling']}.svg",
                                          height: 40,
                                        ),
                                        Text(
                                          _moods[index]['feeling'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      _moods[index]['content'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ])
                                ]),
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