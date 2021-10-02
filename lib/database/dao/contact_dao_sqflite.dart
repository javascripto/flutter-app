import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/models/contact.dart';
import 'package:flutter_app/database/dao/contact_dao.dart';

class ContactDAOSqflite extends ContactDAO {
  static final String _tableName = 'contacts';

  Future<Database> _createDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'bytebank.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $_tableName (
          int id PRIMARY KEY,
          name TEXT,
          account_number INTEGER
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
      'name': contact.name,
      'account_number': contact.accountNumber,
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
            id: contactMap['id'],
            name: contactMap['name'],
            accountNumber: contactMap['account_number'],
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

  @override
  Future<int> delete(int id) async {
    Database db = await _createDatabase();
    int affectedRows = await db.delete(
      _tableName,
      where: 'id = ?',
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
