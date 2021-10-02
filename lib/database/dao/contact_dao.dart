import 'dart:io';
import 'package:flutter_app/models/contact.dart';

import './contact_dao_sqflite.dart';
import './contact_dao_shared_preferences.dart';

final bool supportsSqFlite = Platform.isAndroid ||
    Platform.isIOS ||
    Platform.isMacOS ||
    Platform.isFuchsia;

abstract class ContactDAO {
  Future<int> delete(int id);
  Future<Contact?> find(int id);
  Future<List<Contact>> findAll();
  Future<int> save(Contact contact);
  Future<void> seed() async {
    await save(Contact(name: 'John Doe', accountNumber: 12345));
    await save(Contact(name: 'Jane Doe', accountNumber: 67890));
    await save(Contact(name: 'Anne Parker', accountNumber: 37283));
    await save(Contact(name: 'Joe Smith', accountNumber: 54321));
    await findAll().then(print);
  }
}

final ContactDAO contactDAO =
    supportsSqFlite ? ContactDAOSqflite() : ContactDAOSharedPreferences();
