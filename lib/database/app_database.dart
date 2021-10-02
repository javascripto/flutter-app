import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/models/contact.dart';

Future<Database> _createDatabase() async {
  String dbPath = await getDatabasesPath();
  String path = join(dbPath, 'bytebank.db');
  return openDatabase(path, version: 1, onCreate: (db, version) {
    db.execute('''
      CREATE TABLE contacts (
        int id PRIMARY KEY,
        name TEXT,
        account_number INTEGER
      )
    ''');
  });
}

Future<int> save(Contact contact) async {
  Database db = await _createDatabase();
  int id = await db.insert('contacts', {
    'name': contact.name,
    'account_number': contact.accountNumber,
  });
  return id;
}

Future<List<Contact>> findAll() async {
  Database db = await _createDatabase();
  List<Map> contactMapsList = await db.query('contacts');
  List<Contact> contactList = contactMapsList
      .map(
        (contactMap) => Contact(
          id: contactMap['id'],
          name: contactMap['name'],
          accountNumber: contactMap['account_number'],
        ),
      )
      .toList();
  return contactList;
}

Future<Contact?> find(int id) async {
  Database db = await _createDatabase();
  List<Map> contactMapsList = await db.query(
    'contacts',
    where: 'id = ?',
    whereArgs: [id],
  );
  if (contactMapsList.isEmpty) return null;
  return Contact(
    id: contactMapsList.first['id'],
    name: contactMapsList.first['name'],
    accountNumber: contactMapsList.first['account_number'],
  );
}

Future<int> delete(int id) async {
  Database db = await _createDatabase();
  int affectedRows = await db.delete(
    'contacts',
    where: 'id = ?',
    whereArgs: [id],
  );
  return affectedRows;
}
