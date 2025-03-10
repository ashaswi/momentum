import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({super.key});

  @override
  State<Pomodoro> createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  int minutes = 25;
  int seconds = 0;
  bool isRunning = false;
  bool onFocus = true;
  Timer? timer;
  void startTimer() {
    isRunning = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds == 0) {
        if (minutes == 0) {
          onFocus = !onFocus;
          minutes = onFocus ? 25 : 5;
          seconds = 0;
          isRunning = false;
          timer.cancel();
        } else {
          minutes--;
          seconds = 59;
        }
      } else {
        seconds--;
      }
      setState(() {});
    });
  }

  void stopTimer() {
    isRunning = false;
    timer?.cancel();
  }

  String formatTime(int value) {
    return value.toString().padLeft(2, '0'); // Ensure 2-digit format
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF371B34)), 
          onPressed: () {
            Navigator.pushNamed(context, '/dashboard'); 
          },
        ),
        title: const Text(
          'Pomodoro Timer',
          style: TextStyle(
            color: Color(0xFF371B34), 
          ),
        ),
      ),
    body: Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: onFocus ? Colors.white : const Color(0xFF7140FC),
          ),
        ),
        Positioned.fill(
          child: SvgPicture.asset(
            onFocus
                ? 'assets/images/icons/background_elements.svg'
                : 'assets/images/icons/background_elements_break.svg',
            fit: BoxFit.cover,
            placeholderBuilder: (context) => Container(
              color: Colors.red, // Debugging: Shows red if SVG fails to load
            ),
          ),
        ),
        SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: onFocus
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SvgPicture.asset(
                    onFocus
                        ? 'assets/images/icons/focus_icon.svg'
                        : 'assets/images/icons/break_icon.svg',
                    height: 40,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: onFocus
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        width: 3),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        formatTime(minutes),
                        style: TextStyle(
                            fontSize: 157,
                            fontWeight: FontWeight.w700,
                            color: onFocus
                                ? const Color(0xFF7140FC)
                                : Colors.white,
                            fontFamily: 'Poppins',
                            height: 0.85),
                      ),
                      Text(
                        formatTime(seconds),
                        style: TextStyle(
                          height: 0.85,
                          fontSize: 157,
                          fontWeight: FontWeight.w700,
                          color: onFocus
                              ? const Color(0xFF7140FC)
                              : Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (!isRunning) {
                          startTimer();
                        }
                      },
                      child: SvgPicture.asset(
                        onFocus
                            ? 'assets/images/icons/start_btn.svg'
                            : 'assets/images/icons/start_btn_break.svg',
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: stopTimer,
                      child: SvgPicture.asset(
                        onFocus
                            ? 'assets/images/icons/pause_btn.svg'
                            : 'assets/images/icons/pause_btn_break.svg',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}

 /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: onFocus
            ? const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF7140FC), // Dark purple at top
                    Color(0xFF7E67C1), // Deep blue at bottom
                  ],
                ),
              )
            : const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Stack(children: [
            const SizedBox.expand(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: onFocus
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: onFocus
                        ? const Text(
                            'Focus',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                          )
                        : const Text(
                            'Short Break',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepPurple,
                              fontFamily: 'Poppins',
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 350,
                    height:350,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: onFocus
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          width: 3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          formatTime(minutes),
                          style: TextStyle(
                              fontSize: 157,
                              fontWeight: FontWeight.w700,
                              color: onFocus
                                  ? Colors.white
                                  : const Color(0xFF7140FC),
                              fontFamily: 'Poppins',
                              height: 0.85),
                        ),
                        Text(
                          formatTime(seconds),
                          style: TextStyle(
                            height: 0.85,
                            fontSize: 157,
                            fontWeight: FontWeight.w700,
                            color: onFocus
                                ? Colors.white
                                : const Color(0xFF7140FC),
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // add a gap
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!isRunning) {
                            startTimer();
                          }
                        },
                        child: onFocus ? SvgPicture.asset(
                            'assets/images/icons/start_btn.svg'): SvgPicture.asset(
                            'assets/images/icons/start_btn_break.svg'),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: stopTimer,
                        child: onFocus ? SvgPicture.asset(
                            'assets/images/icons/pause_btn.svg'): SvgPicture.asset(
                            'assets/images/icons/pause_btn_break.svg'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}*/