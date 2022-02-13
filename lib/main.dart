import 'package:flutter/material.dart';
import 'package:flutter_app/screens/dashboard.dart';

void main() async {
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

ThemeData getBytebankTheme() {
  return ThemeData(
    primaryColor: Colors.green[900],
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(
      secondary: Colors.blueAccent[700],
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueAccent[700],
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blueAccent[700]),
        padding: MaterialStateProperty.all(EdgeInsets.all(16)),
      ),
    ),
  );
}
