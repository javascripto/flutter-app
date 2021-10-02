import 'package:flutter/material.dart';
import 'package:flutter_app/models/contact.dart';
import 'package:flutter_app/screens/contact_form.dart';

class ContactsList extends StatelessWidget {
  final List<Contact> contacts = [
    Contact(name: 'John Doe', accountNumber: 12345),
    Contact(name: 'Jane Doe', accountNumber: 67890),
    Contact(name: 'Anne Parker', accountNumber: 37283),
    Contact(name: 'Joe Smith', accountNumber: 54321),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return _ContactItem(contact: contacts[index]);
          }),
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
