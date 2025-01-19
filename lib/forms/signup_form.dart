import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:momentum/api/dto/users.dart';
import 'package:momentum/api/service/users.dart/create_user_service.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text('Email', style: Theme.of(context).textTheme.bodyLarge),
          TextFormField(
            controller: _emailController,
          ),
          const SizedBox(height: 30),
          Text('Username', style: Theme.of(context).textTheme.bodyLarge),
          TextFormField(
            controller: _usernameController,
          ),
          const SizedBox(height: 30),
          Text('Password', style: Theme.of(context).textTheme.bodyLarge),
          TextFormField(
            controller: _passwordController,
          ),
          const SizedBox(height: 30),
          Text('Confirm Password',
              style: Theme.of(context).textTheme.bodyLarge),
          TextFormField(
            controller: _confirmPasswordController,
          ),
          const SizedBox(height: 50),
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
                Navigator.pushNamed(context, '/dashboard');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              minimumSize: const Size(double.infinity, 50),
            ),
            child: _isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text('Signup',
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
