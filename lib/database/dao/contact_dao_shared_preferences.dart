import 'dart:convert';
import 'package:flutter_app/models/contact.dart';
import 'package:flutter_app/database/dao/contact_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactDAOSharedPreferences extends ContactDAO {
  static int _lastIndex = 0;

  @override
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

  @override
  Future<List<Contact>> findAll() async {
    final storage = await SharedPreferences.getInstance();
    List<String> contactsString = storage.getStringList('contacts') ?? [];
    List<Contact> contacts = contactsString.map((contactString) {
      return Contact.fromJson(jsonDecode(contactString));
    }).toList();
    return contacts;
  }

  @override
  Future<Contact?> find(int id) async {
    return findAll().then(
      (contacts) => contacts.firstWhere((contact) => contact.id == id),
    );
  }

  @override
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

  @override
  Future<void> seed() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    await super.seed();
  }
}
