import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:momentum/api/dto/users.dart';
import 'package:momentum/api/service/users/create_user_service.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text('Email', style: Theme.of(context).textTheme.bodyLarge),
          TextFormField(
            controller: _emailController,
          ),
          const SizedBox(height: 20),
          Text('Username', style: Theme.of(context).textTheme.bodyLarge),
          TextFormField(
            controller: _usernameController,
          ),
          const SizedBox(height: 20),
          Text('Password', style: Theme.of(context).textTheme.bodyLarge),
          TextFormField(
            obscureText: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 20),
          Text('Confirm Password',
              style: Theme.of(context).textTheme.bodyLarge),
          TextFormField(
            obscureText: true,
            controller: _confirmPasswordController,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              User user = User(
                email: _emailController.text,
                username: _usernameController.text,
                password: _passwordController.text,
                confirmPassword: _confirmPasswordController.text,
              );
              CreateUserSevice createUserSevice = CreateUserSevice();
              Response response = await createUserSevice.createUser(user);
              setState(() {
                _isLoading = false;
              });
              if (response.statusCode == 201) {
                Navigator.pushNamed(context, '/login');
              } else {
                var errors = jsonDecode(response.body);
                String firstKey = errors.keys.first;
                String errorMessage = errors[firstKey][0];
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    action: SnackBarAction(
                      label: 'X',
                      textColor: Colors.white,
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                    content: Text("$firstKey: $errorMessage"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              )
            ),
            child: _isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text('Create Account',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white)),
              
          )
        ],
      ),
    );
  }
}
