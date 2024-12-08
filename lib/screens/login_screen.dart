import 'package:flutter/material.dart';
import 'package:ratemy/screens/presentation/login_presentation.dart';

import 'components/title_row.dart';


class LoginScreen extends StatefulWidget {
  final LoginPresentation presentation;

  const LoginScreen({super.key, required this.presentation});

  static String id = 'Login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                title: 'Login',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
