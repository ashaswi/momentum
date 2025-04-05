import 'package:flutter/material.dart';

class ProfileForm extends StatefulWidget {
  final String username;
  final String email;
  const ProfileForm({super.key, required this.username, required this.email});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
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
              readOnly: true,
              initialValue: widget.username,
            ),
            const SizedBox(height: 30),
            Text('Email', style: Theme.of(context).textTheme.bodyLarge),
            TextFormField(
              readOnly: true,
              initialValue: widget.email,
            ),
            const SizedBox(height: 50),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}