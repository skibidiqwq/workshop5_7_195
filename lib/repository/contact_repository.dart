import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/contact.dart';

class ContactRepository {
  static const dbName = 'contact_db.db';
  static const tableName = 'contacts';

  static Future<Database> get database async {
    final path = join(await getDatabasesPath(), dbName);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            phone TEXT,
            contactGroup TEXT,
            createdAt TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insert(Contact contact) async {
    return (await database).insert(tableName, contact.toMap());
  }

  static Future<List<Contact>> getContacts() async {
    final maps = await (await database).query(tableName);
    return maps.map((m) => Contact.fromMap(m)).toList();
  }

  static Future<int> update(Contact contact) async {
    return (await database).update(
      tableName,
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  static Future<int> delete(Contact contact) async {
    return (await database).delete(
      tableName,
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }
}