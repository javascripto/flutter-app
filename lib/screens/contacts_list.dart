import 'package:flutter/material.dart';
import 'package:flutter_app/models/contact.dart';
import 'package:flutter_app/screens/contact_form.dart';
import 'package:flutter_app/database/app_database.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        future: Future.delayed(Duration(seconds: 1)).then((value) => findAll()),
        // initialData: <Contact>[], // optional
        builder: (context, snapshot) {
          final contacts = snapshot.data;
          if (contacts == null) return CentralizedLoading();
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return _ContactItem(contact: contacts[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Contact newContact = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ContactForm()),
          );
          debugPrint(newContact.toString());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

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

class _ContactItem extends StatelessWidget {
  final Contact contact;

  _ContactItem({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('${contact.name}', style: TextStyle(fontSize: 24)),
        subtitle:
            Text('${contact.accountNumber}', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
