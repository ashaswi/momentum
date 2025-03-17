import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:momentum/Screens/base_screen.dart';
import 'package:momentum/api/dto/task_dto.dart';
import 'package:momentum/api/service/task/create_task_service.dart';
import 'package:momentum/api/service/task/list_task_service.dart';
import 'package:momentum/api/service/task/update_task_service.dart';
import 'package:momentum/components/Header.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  bool _isLoading = false;
  List<dynamic> _tasks = [];
  bool _listIsLoading = false;
  String _selectedStatus = 'doing';

  @override
  void initState() {
    super.initState();
    _fetchTasks(_selectedStatus);
  }

  void _fetchTasks(String status) async {
    try {
      _listIsLoading = true;
      Response response = await ListTaskService().listTasks(_selectedStatus);
      if (response.statusCode == 200) {
        _tasks = jsonDecode(response.body);
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
    return BaseScreen(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(
              primayHeaderText: 'Your To-Do List',
              secondaryHeaderText: 'Plan, focus, achieve.',
              secondaryTextSize: 16,
            ),
            const SizedBox(height: 20),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Add Task',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
              controller: _nameController,
            ),

            const SizedBox(height: 20),
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
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                TaskDto taskDto = TaskDto(
                  name: _nameController.text,
                  date: _startDateController.text,
                  status: 'doing',
                );
                CreateTaskService createTaskService = CreateTaskService();
                Response response = await createTaskService.createTask(taskDto);
                var responseBody = jsonDecode(response.body);
                setState(() {
                  _isLoading = false;
                });
                if (response.statusCode == 201) {
                  _fetchTasks(_selectedStatus);
                  _nameController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Task entry created successfully"),
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
                      'Create Task',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                              ),
                    ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _selectedStatus = 'doing';
                    _fetchTasks(_selectedStatus);
                    setState(() {});
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7DEFF),
                        border: Border.all(
                            color: _selectedStatus == 'doing'
                                ? Theme.of(context).primaryColor
                                : const Color(0xFFE7DEFF)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Doing',
                          style: TextStyle(
                            color: _selectedStatus == 'doing'
                                ? Theme.of(context).primaryColor
                                : const Color(0xFFAC8FFF),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                          ))),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _selectedStatus = 'done';
                    _fetchTasks(_selectedStatus);
                    setState(() {});
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7DEFF),
                        border: Border.all(
                            color: _selectedStatus == 'done'
                                ? Theme.of(context).primaryColor
                                : const Color(0xFFE7DEFF)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Done',
                          style: TextStyle(
                            color: _selectedStatus == 'done'
                                ? Theme.of(context).primaryColor
                                : const Color(0xFFAC8FFF),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                          ))),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const SizedBox(height: 10),
            _listIsLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _tasks.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Card(
                          color: _selectedStatus == 'doing'
                              ? const Color(0xFF7140FC)
                              : const Color(0xFFE1F7E6),
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
                                      _selectedStatus == 'doing'
                                          ? GestureDetector(
                                              onTap: () async {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      "Task moved to done"),
                                                  backgroundColor: Colors.green,
                                                ));
                                                UpdateTaskService
                                                    updateTaskService =
                                                    UpdateTaskService();
                                                await updateTaskService
                                                    .updateTask(
                                                        _tasks[index]['id'],
                                                        TaskDto(
                                                          name: _tasks[index]
                                                              ['name'],
                                                          date: _tasks[index]
                                                              ['start_date'],
                                                          status: 'done',
                                                        ));
                                                _fetchTasks(_selectedStatus);
                                              },
                                              child: SvgPicture.asset(
                                                  'assets/images/icons/cross.svg'),
                                            )
                                          : SvgPicture.asset(
                                              'assets/images/icons/check.svg'),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Text(
                                          _tasks[index]['name'],
                                          style: TextStyle(
                                            color: _selectedStatus == 'doing'
                                                ? Colors.white
                                                : Colors.green,
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
                                      _selectedStatus == 'doing'
                                          ? Text(_tasks[index]['start_date'],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Poppins',
                                              ))
                                          : GestureDetector(
                                              onTap: () async {
 ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                      "Task moved to doing"),
                                                  backgroundColor: Colors.green,
                                                ));
                                                UpdateTaskService
                                                    updateTaskService =
                                                    UpdateTaskService();
                                                await updateTaskService
                                                    .updateTask(
                                                        _tasks[index]['id'],
                                                        TaskDto(
                                                          name: _tasks[index]
                                                              ['name'],
                                                          date: _tasks[index]
                                                              ['start_date'],
                                                          status: 'doing',
                                                        ));
                                                _fetchTasks(_selectedStatus);
                                              },
                                              child: SvgPicture.asset(
                                                  'assets/images/icons/green_cross.svg')),
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
    );
  }
}