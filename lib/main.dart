import 'package:authentication_library/LoginContainer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
   App();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authenticated App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginContainer(),
    );
  }
}