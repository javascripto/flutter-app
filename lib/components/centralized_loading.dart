import 'package:flutter/material.dart';

class CentralizedLoading extends StatelessWidget {
  final String text;

  const CentralizedLoading({this.text = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
          Text(text),
        ],
      ),
    );
  }
}
