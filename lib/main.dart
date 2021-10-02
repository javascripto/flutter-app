import 'package:flutter/material.dart';
import 'package:flutter_app/models/contact.dart';
import 'package:flutter_app/screens/dashboard.dart';
import 'package:flutter_app/database/app_database.dart';

void main() async {
  // await save(Contact(name: 'John Doe', accountNumber: 12345));
  // await save(Contact(name: 'Jane Doe', accountNumber: 67890));
  // await save(Contact(name: 'Anne Parker', accountNumber: 37283));
  // await save(Contact(name: 'Joe Smith', accountNumber: 54321));
  // await findAll().then(print);
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
    primarySwatch: Colors.green,
    primaryColor: Colors.green[900],
    accentColor: Colors.blueAccent[700],
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
