import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
      theme: getBytebankTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
    );
  }
}

ThemeData getBytebankTheme() {
  return ThemeData(
    primaryColor: Colors.green[900],
    accentColor: Colors.blueAccent[700],
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueAccent[700],
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
