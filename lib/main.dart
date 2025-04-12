import 'package:flutter/material.dart';
import 'package:momentum/screens/signin.dart';
import 'package:momentum/screens/signup.dart';
import 'package:momentum/screens/welcome.dart';
import 'package:momentum/screens/dashboard.dart';
import 'package:momentum/screens/forgot_password.dart';
import 'package:momentum/screens/pomodoro.dart';
import 'package:momentum/screens/forgot_password_request.dart';
import 'package:momentum/screens/meditate.dart';
import 'package:momentum/screens/journal.dart';
import 'package:momentum/screens/mood.dart';
import 'package:momentum/screens/survey_screen.dart';
import 'package:momentum/screens/habit.dart';
import 'package:momentum/screens/task.dart';
import 'package:momentum/screens/profile.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {
      // ...
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Momentum',

      // Defining routes for navigation
      routes: {
        '/welcome': (context) => const Welcome(),
        '/signin': (context) => const Signin(),
        '/signup': (context) => const Signup(),
        '/dashboard': (context) => const Dashboard(),
        '/forgot-password-request': (context) => const ForgotPasswordRequest(),
        '/forgot-password': (context) => const ForgotPassword(),
        '/pomodoro': (context) => const Pomodoro(),
        '/meditate': (context) => const Meditate(),
        '/journal': (context) => const Journal(),
        '/survey': (context) => const SurveyScreen(),
        '/mood': (context) => const Mood(),
        '/habit': (context) => const Habit(),
        '/task': (context) => const Task(),
        '/profile': (context) => const Profile(),
      },

      theme: ThemeData(
        primaryColor: const Color(0xFF7140FC),
        fontFamily: 'Poppins', // Setting default font

        // Define Color Scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: const Color(0xFF7140FC),
          secondary: const Color(0xFF371B34),
          background: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
        ),

        // Defining Text Theme with Correct Colors
        textTheme: const TextTheme(
         displayLarge: TextStyle(
              fontSize: 38,
              color: Color(0xFF371B34),
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
          headlineLarge: TextStyle(
              fontSize: 32,
              color: Color(0xFF371B34),
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
          headlineMedium: TextStyle(
              fontSize: 24,
              color: Color(0xFF371B34),
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
          headlineSmall: TextStyle(
              fontSize: 16,
              color: Color(0xFF371B34),
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
          bodyLarge: TextStyle(
              fontSize: 18, color: Color(0xFF371B34), fontFamily: 'Poppins'),
          bodyMedium: TextStyle(
              fontSize: 14, color: Color(0xFF371B34), fontFamily: 'Poppins'),
        ),

        primaryTextTheme: const TextTheme(
          headlineLarge: TextStyle(color: Color(0xFF371B34)),
        ),

        // Material 3 for better UI
        useMaterial3: true,
      ),

      color: Colors.white,
      initialRoute: '/welcome',
      debugShowCheckedModeBanner: false, // Hiding debug banner
    );
  }
}
