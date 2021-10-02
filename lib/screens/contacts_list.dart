import 'package:flutter/material.dart';
import 'package:flutter_app/screens/contact_form.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text('John Doe', style: TextStyle(fontSize: 24)),
              subtitle: Text('1000', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ContactForm()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
