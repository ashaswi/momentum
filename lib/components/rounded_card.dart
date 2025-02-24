import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundedCard extends StatelessWidget {
  final String title;
  final Color startBtnColor;
  final Color backgroundColor;
  final Color textColor;
  final String startBtnRoute;
  final String icon;
  const RoundedCard({
    super.key,
    required this.icon,
    required this.title,
    this.startBtnColor = const Color(0xFF7140FC),
    this.backgroundColor = const Color(0xFF7140FC),
    this.startBtnRoute = "/dashboard",
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, top: 15, bottom: 15, right: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: textColor,
                              ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Lets open up",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: textColor,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, startBtnRoute),
                          child: Text(
                            "Start now",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: startBtnColor),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(
                            'assets/images/icons/calendar_icon.svg'),
                      ],
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 4,
            child: Center(
              child: SvgPicture.asset(icon, width: 70),
            ),
          ),
        ],
      ),
    );
  }
}