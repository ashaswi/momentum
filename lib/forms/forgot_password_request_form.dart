import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:momentum/api/dto/forgot_password_request_dto.dart';
import 'package:momentum/api/service/auth/forgot_password_service.dart';

class ForgotPassordRequestForm extends StatefulWidget {
  const ForgotPassordRequestForm({super.key});

  @override
  State<ForgotPassordRequestForm> createState() =>
      _ForgotPassordRequestFormState();
}

class _ForgotPassordRequestFormState extends State<ForgotPassordRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
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
            Text('Email', style: Theme.of(context).textTheme.bodyLarge),
            TextFormField(
              controller: _emailController,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                ForgotPasswordRequestDto forgotPasswordRequestDto =
                    ForgotPasswordRequestDto(
                  email: _emailController.text,
                );
                ForgotPasswordService forgotPasswodService =
                    ForgotPasswordService();
                Response response = await forgotPasswodService
                    .forgotPasswordRequest(forgotPasswordRequestDto);
                var responseBody = jsonDecode(response.body);
                setState(() {
                  _isLoading = false;
                });
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                   const  SnackBar(
                      content: Text("Password reset code sent to your email!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pushNamed(context, '/forgot-password');
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
                  : Text('Request Code',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.white)),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}