import 'package:flutter/material.dart';
import 'package:ratemy/screens/presentation/profile_presentation.dart';

import 'components/title_row.dart';

class ProfileScreen extends StatefulWidget {
  final ProfilePresentation presentation;

  const ProfileScreen({super.key, required this.presentation});

  static String id = 'profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.presentation.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              widget.presentation.gapAboveScreenTitle,

              TitleRow(
                backAction: () {
                  Navigator.pop(context, false);
                },
                title: 'Profile screen',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
