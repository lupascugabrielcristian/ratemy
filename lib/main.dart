import 'package:flutter/material.dart';
import 'package:ratemy/screens/login_screen.dart';
import 'package:ratemy/screens/presentation/app_theme.dart';

import 'application/injector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Injector injector = Injector();

  MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    String initialRoute = LoginScreen.id;

    return MaterialApp(
      title: 'RateMy',
      initialRoute: initialRoute,
      routes: {
        LoginScreen.id: (context) => LoginScreen(presentation: injector.getLoginPresentation()),
      },
      theme: AppTheme.getAppTheme(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return LoginScreen(presentation: injector.getLoginPresentation());
        });
      },
    );
  }
}
