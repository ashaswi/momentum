import 'package:flutter/material.dart';

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text('Email', style: Theme.of(context).textTheme.bodyLarge),
              TextFormField(),
              const SizedBox(height: 30),
              Text('Password', style: Theme.of(context).textTheme.bodyLarge),
              TextFormField(),
              const SizedBox(height: 90),
              ElevatedButton(
                  onPressed: () => print('hello'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
