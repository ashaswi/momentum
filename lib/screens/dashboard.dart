import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:momentum/Screens/base_screen.dart';
import 'package:momentum/components/Header.dart';
import 'package:momentum/components/rounded_card.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  final String phoneNumber = "1166";

  Future<void> _launchPhone() async {
    final Uri uri = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Could not launch phone dialer.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        hasPadding: true,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                 Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Header(
                    primayHeaderText: "Welcome Back,",
                    secondaryTextSize: 20,
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.pushNamed(context, '/profile'),
                    },
                    child: Image.asset(
  'assets/images/icons/profile.png',
  height: 50,
  errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.person); // fallback to person icon
  },
)
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "How are you feeling today?",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              const RoundedCard(
                icon: 'assets/images/icons/meetup_icon.svg',
                title: 'Your journal',
                startBtnRoute: '/journal',
                backgroundColor: Color(0xFFE7DEFF),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F3F1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.pushNamed(context, '/task'),
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                'assets/images/icons/todo_icon.svg'),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'To Do List',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F3F1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.pushNamed(context, '/habit'),
                        },

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                'assets/images/icons/habit_icon.svg'),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Habit Tracker',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F3F1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: _launchPhone,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Dial #1166 for free, confidential support',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset('assets/images/icons/quote_icon.svg'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              RoundedCard(
                icon: 'assets/images/icons/mood_log_icon.svg',
                title: 'Mood Log',
                textColor: Colors.white,
                startBtnColor: Colors.white,
                startBtnRoute: '/mood',
                backgroundColor: Theme.of(context).primaryColor,
                buttonText: "Let's Log",
              ),
              const SizedBox(
                height: 20,
              ),
              RoundedCard(
                icon: 'assets/images/icons/meditation_icon.svg',
                title: 'Meditation',
                textColor: Colors.white,
                startBtnColor: Colors.white,
                startBtnRoute: '/meditate',
                backgroundColor: Theme.of(context).primaryColor,
                buttonText: "Let's Relax",
              ),
              const SizedBox(
                height: 20,
              ),
              RoundedCard(
                icon: 'assets/images/icons/timer_icon.svg',
                title: 'Pomodoro Timer',
                textColor: Colors.white,
                startBtnColor: Colors.white,
                startBtnRoute: '/pomodoro',
                backgroundColor: Theme.of(context).primaryColor,
                buttonText: "Let's Focus",
              ),
              const SizedBox(
                height: 20,
              ),
              RoundedCard(
                icon: 'assets/images/icons/survey_icon.svg',
                title: 'Survey',
                textColor: Colors.white,
                startBtnColor: Colors.white,
                startBtnRoute: '/survey',
                backgroundColor: Theme.of(context).primaryColor,
                buttonText: "Let's Reflect",
              ),
            ],
          ),
        ));
  }
}
