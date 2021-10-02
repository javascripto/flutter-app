import 'package:flutter/material.dart';
import 'package:flutter_app/models/contact.dart';
import 'package:flutter_app/screens/contact_form.dart';
import 'package:flutter_app/database/dao/contact_dao.dart';

class ContactsList extends StatefulWidget {
  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        future: Future.delayed(Duration(milliseconds: 500))
            .then((value) => contactDAO.findAll()),
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
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ContactForm()),
          );
          setState(() {/* update FutureBuilder */});
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
