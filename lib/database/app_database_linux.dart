import 'dart:convert';
import 'package:flutter_app/models/contact.dart';
import 'package:shared_preferences/shared_preferences.dart';

int _lastIndex = 0;

Future<int> save(Contact contact) async {
  final storage = await SharedPreferences.getInstance();
  List<String> contacts = storage.getStringList('contacts') ?? [];

  if (contacts.isNotEmpty) {
    Contact contact = Contact.fromJson(jsonDecode(contacts.last));
    _lastIndex = contact.id ?? _lastIndex;
  }
  contact.id = contact.id ?? ++_lastIndex;
  contacts.add(jsonEncode(contact.toJson()));
  storage.setStringList('contacts', contacts);
  return contact.id!;
}

Future<List<Contact>> findAll() async {
  final storage = await SharedPreferences.getInstance();
  List<String> contactsString = storage.getStringList('contacts') ?? [];
  List<Contact> contacts = contactsString.map((contactString) {
    return Contact.fromJson(jsonDecode(contactString));
  }).toList();
  return contacts;
}

Future<Contact?> find(int id) async {
  return findAll().then(
    (contacts) => contacts.firstWhere((contact) => contact.id == id),
  );
}

Future<int> delete(int id) async {
  final storage = await SharedPreferences.getInstance();
  List<Contact> contacts = await findAll();
  int affectedRows = 0;
  contacts.removeWhere((contact) {
    if (contact.id == id) {
      affectedRows++;
      return true;
    }
    return false;
  });
  List<String> newContactsString = contacts.map((contact) {
    return json.encode(contact.toJson());
  }).toList();
  storage.setStringList('contacts', newContactsString);
  return affectedRows;
}

Future<void> resetSeed() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.clear();
  await save(Contact(name: 'John Doe', accountNumber: 12345));
  await save(Contact(name: 'Jane Doe', accountNumber: 67890));
  await save(Contact(name: 'Anne Parker', accountNumber: 37283));
  await save(Contact(name: 'Joe Smith', accountNumber: 54321));
  await findAll().then(print);
}
