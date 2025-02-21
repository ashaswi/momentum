import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:momentum/Screens/base_screen.dart';
import 'package:momentum/components/Header.dart';
import 'package:momentum/components/rounded_card.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        hasPadding: false,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header(
          primayHeaderText: "Welcome Back,",
          secondaryHeaderText: "Lorem!",
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
          startBtnRoute: '/dashboard',
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/icons/journal_icon.svg'),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/icons/mood_log.svg'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Mood Log',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Quote helpline',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
              ),
              const SizedBox(
                width: 10,
              ),
              SvgPicture.asset('assets/images/icons/quote_icon.svg'),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        RoundedCard(
          icon: 'assets/images/icons/meditation_icon.svg',
          title: 'Your journal',
          textColor: Colors.white,
          startBtnColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor,
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
        ),
      ],
    ));
  }
}
