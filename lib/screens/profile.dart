import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:momentum/Screens/base_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:momentum/api/service/profile/read_profile_service.dart';
import 'package:momentum/forms/profile_form.dart';
//import 'package:momentum/components/curved_curtain.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isLoading = false;
  Map<String, dynamic>? profileData; 

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    setState(() {
      _isLoading = true;
    });

    final response = await ReadProfileService().readProfile();

    if (response.statusCode == 200) {
      setState(() {
        profileData = jsonDecode(response.body).first;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (profileData == null) {
      return const Center(
        child: Text("Failed to load profile data"),
      );
    }

    return BaseScreen(
      hasPadding: false,
      child: Stack(
        children: [
          Positioned(
            top: -200,
            left: -10,
            right: -10,
            child: SvgPicture.asset(
              'assets/images/gradient/Gradient.svg',
              fit: BoxFit.cover,
              height: 500,
            ),
          ),
          Positioned(
            top: 270,
            left: 30,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 38,
                      color: Color(0xFF424242),
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 16),
                  SvgPicture.asset(
                    'assets/images/icons/line_icon.svg',
                    width: 80,
                  ),
                  const SizedBox(height: 16),
                  ProfileForm(
                    username: profileData?['username'] ?? 'N/A',
                    email: profileData?['email'] ?? 'N/A',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}