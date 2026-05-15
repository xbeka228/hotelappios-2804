import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  factory DBHelper() => _instance;
  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'hotel_db.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE rooms(
            id TEXT PRIMARY KEY,
            type TEXT,
            status TEXT,
            guest TEXT
          )
        ''');
        // Заполняем отель номерами при первом запуске
        await db.insert('rooms', {'id': '101', 'type': 'Standard', 'status': 'Свободен', 'guest': ''});
        await db.insert('rooms', {'id': '102', 'type': 'Standard', 'status': 'Свободен', 'guest': ''});
        await db.insert('rooms', {'id': '103', 'type': 'Comfort', 'status': 'Свободен', 'guest': ''});
        await db.insert('rooms', {'id': '104', 'type': 'Comfort', 'status': 'Свободен', 'guest': ''});
        await db.insert('rooms', {'id': '105', 'type': 'Luxe', 'status': 'Свободен', 'guest': ''});
      },
    );
  }

  Future<List<Map<String, dynamic>>> getRooms() async {
    final db = await database;
    return await db.query('rooms');
  }

  Future<String> bookRoom(String type, String guestName) async {
    final db = await database;
    List<Map> result = await db.query('rooms', 
      where: 'type = ? AND status = ?', 
      whereArgs: [type, 'Свободен'], 
      limit: 1);

    if (result.isNotEmpty) {
      String roomId = result.first['id'];
      await db.update('rooms', 
        {'status': 'Занят', 'guest': guestName}, 
        where: 'id = ?', 
        whereArgs: [roomId]);
      return roomId;
    }
    return "Full";
  }

  Future<void> resetRoom(String id) async {
    final db = await database;
    await db.update('rooms', {'status': 'Свободен', 'guest': ''}, where: 'id = ?', whereArgs: [id]);
  }
}