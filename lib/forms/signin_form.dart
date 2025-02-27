import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:momentum/api/dto/login_dto.dart';
import 'package:momentum/api/service/auth/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text('Username', style: Theme.of(context).textTheme.bodyLarge),
            TextFormField(
              controller: _usernameController,
            ),
            const SizedBox(height: 30),
            Text('Password', style: Theme.of(context).textTheme.bodyLarge),
            TextFormField(
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                LoginDto loginDto = LoginDto(
                    username: _usernameController.text,
                    password: _passwordController.text);
                LoginService loginService = LoginService();
                Response response = await loginService.login(loginDto);
                var responseBody = jsonDecode(response.body);
                setState(() {
                  _isLoading = false;
                });
                if (response.statusCode == 200) {
                   final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('token', responseBody['token']);
                  Navigator.pushNamed(context, '/dashboard');
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
                borderRadius: BorderRadius.circular(10.0), // Less rounded edges
    ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text('Login',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white)),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an Account?",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text('Sign up',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.purple)),
                ),
              ],
            ),
                 Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/forgot-password-request');
                },
                child: Text('Forgot Password?',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.purple)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
