import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:momentum/api/dto/forgot_password_dto.dart';
import 'package:momentum/api/service/auth/forgot_password_service.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
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
          const SizedBox(height: 40),
          Text('Reset', style: Theme.of(context).textTheme.bodyLarge),
          TextFormField(
            controller: _codeController,
          ),
          const SizedBox(height: 30),
          Text('Password', style: Theme.of(context).textTheme.bodyLarge),
          TextFormField(
            obscureText: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 30),
          Text('Confirm Password',
              style: Theme.of(context).textTheme.bodyLarge),
          TextFormField(
            obscureText: true,
            controller: _confirmPasswordController,
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              ForgotPasswordDto forgotPasswordDto = ForgotPasswordDto(
                code: _codeController.text,
                newPassword: _passwordController.text,
                confirmNewPassword: _confirmPasswordController.text,
              );
              ForgotPasswordService forgotPasswordService = ForgotPasswordService();
              Response response = await forgotPasswordService.forgotPassword(forgotPasswordDto);
              setState(() {
                _isLoading = false;
              });
              if (response.statusCode == 200) {
                Navigator.pushNamed(context, '/signin');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Password reset successful. Please login!"),
                    backgroundColor: Colors.green,
                  ),
                );
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
                        // Code to execute when the close button is pressed.
                        // You can dismiss the SnackBar or perform any other action.
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
              minimumSize: const Size(double.infinity, 50),
            ),
            child: _isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text('Reset Password',
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