import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/models/contact.dart';
import 'package:flutter_app/database/dao/contact_dao.dart';

class ContactDAOSqflite extends ContactDAO {
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<Database> _createDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'bytebank.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $_tableName (
          $_id INTEGER PRIMARY KEY,
          $_name TEXT,
          $_accountNumber INTEGER
        )
      ''');
      },
      onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  @override
  Future<int> save(Contact contact) async {
    Database db = await _createDatabase();
    int id = await db.insert(_tableName, {
      _name: contact.name,
      _accountNumber: contact.accountNumber,
    });
    return id;
  }

  @override
  Future<List<Contact>> findAll() async {
    Database db = await _createDatabase();
    List<Map> contactMapsList = await db.query(_tableName);
    List<Contact> contactList = contactMapsList
        .map(
          (contactMap) => Contact(
            id: contactMap[_id],
            name: contactMap[_name],
            accountNumber: contactMap[_accountNumber],
          ),
        )
        .toList();
    return contactList;
  }

  @override
  Future<Contact?> find(int id) async {
    Database db = await _createDatabase();
    List<Map> contactMapsList = await db.query(
      _tableName,
      where: '$_id = ?',
      whereArgs: [id],
    );
    if (contactMapsList.isEmpty) return null;
    return Contact(
      id: contactMapsList.first[_id],
      name: contactMapsList.first[_name],
      accountNumber: contactMapsList.first[_accountNumber],
    );
  }

  @override
  Future<int> delete(int id) async {
    Database db = await _createDatabase();
    int affectedRows = await db.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [id],
    );
    return affectedRows;
  }

  @override
  Future<void> seed() async {
    Database db = await _createDatabase();
    await db.delete(_tableName);
    super.seed();
  }
}
