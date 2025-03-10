import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:momentum/Screens/base_screen.dart';
import 'package:momentum/api/dto/habit_dto.dart';
import 'package:momentum/api/service/habit/create_habit_service.dart';
import 'package:momentum/api/service/habit/list_habit_service.dart';
import 'package:momentum/api/service/util_service.dart';
import 'package:momentum/components/Header.dart';

class Habit extends StatefulWidget {
  const Habit({super.key});

  @override
  State<Habit> createState() => _HabitState();
}

class _HabitState extends State<Habit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isLoading = false;
  List<dynamic> _habits = [];
  bool _listIsLoading = false;

  @override
  void initState() {
    super.initState();
    _listIsLoading = true;
    _fetchHabits();
  }

  Future<void> _pickTime(context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _startTimeController.text =
            '${_selectedTime.hour}:${_selectedTime.minute}';
      });
    }
  }

  void _fetchHabits() async {
    try {
      Response response = await ListHabitService().listHabits();
      if (response.statusCode == 200) {
        _habits = jsonDecode(response.body);
      } else {
        _listIsLoading = false;
        const SnackBar(
          content: Text('Failed to fetch habits'),
          backgroundColor: Colors.red,
        );
      }
      _listIsLoading = false;
      setState(() {});
    } catch (e) {
      setState(() => _listIsLoading = false);
      SnackBar(
        content: Text('Failed to fetch habits: $e'),
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _startDateController.text =
            "${picked.toLocal()}".split(' ')[0]; // Format YYYY-MM-DD
      });
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
          'Habit Tracker',
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
              primayHeaderText: 'Track Your Habit',
              secondaryHeaderText: 'Create, commit, succeed.',
              secondaryTextSize: 16,
            ),
            const SizedBox(height: 20),
            const Text(
              'Habit Name',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Tap here to start writing....",
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0.5), // Border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Colors.purple, width: 0.5),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Start Date',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            // date picker
            TextField(
              controller: _startDateController,
              readOnly: true, // Prevents manual input
              decoration: InputDecoration(
                hintText: 'YYYY-MM-DD',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0.5), // Border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Colors.purple, width: 0.5),
                ),
              ),
              onTap: () => _selectDate(context), // Opens date picker on tap
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Start Time',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
            ),
            TextField(
              controller: _startTimeController,
              readOnly: true, // Prevents manual input
              onTap: () => _pickTime(context),
              decoration: InputDecoration(
                hintText: 'H:M',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: () => _pickTime(context),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded border
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0.5), // Border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Colors.purple, width: 0.5),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                HabitDto habitDto = HabitDto(
                  name: _nameController.text,
                  date: _startDateController.text,
                  time: _startTimeController.text,
                );
                CreateHabitService createHabitService = CreateHabitService();
                Response response =
                    await createHabitService.createHabit(habitDto);
                var responseBody = jsonDecode(response.body);
                setState(() {
                  _isLoading = false;
                });
                if (response.statusCode == 201) {
                  _fetchHabits();
                  _nameController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Habit entry created successfully"),
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
                      'Create Habit',
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
                    itemCount: _habits.length,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _habits[index]['name'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 23,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins',
                                          ),
                                          overflow: TextOverflow
                                              .visible, // Ensure wrapping
                                          softWrap:
                                              true, // Allow multi-line text
                                        ),
                                      ),
                                      Text(
                                          _habits[index]['start_date'] +
                                              '  ' +
                                              formatTime(
                                                  _habits[index]['start_time']),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                          )),
                                    ],
                                  ),
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