import 'package:flutter/material.dart';
import 'package:flutter_app/models/contact.dart';
import 'package:flutter_app/database/dao/contact_dao.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _accountNumberController =
      TextEditingController();

  void _createContact() async {
    final String name = _nameController.text;
    final int? accountNumber = int.tryParse(_accountNumberController.text);
    final Contact contact = Contact(name: name, accountNumber: accountNumber);
    await contactDAO.save(contact);
    Navigator.pop(context, contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Full name',
              ),
              style: TextStyle(fontSize: 24),
              controller: _nameController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Account number',
                ),
                style: TextStyle(fontSize: 24),
                keyboardType: TextInputType.number,
                controller: _accountNumberController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: _createContact,
                  child: Text('Create'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
