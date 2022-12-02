import 'package:substituicao/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ShinobiRepository {

  final String shinobiTable = "shinobi_table";
  final String idColumn = "id_column";
  final String nameColumn = "name_column";
  final String levelColumn = "level_column";
  final String powerColumn = "power_column";
  final String teacherColumn = "teacher_column";

  Future<Database> initializeDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "shinobi.db");

    return openDatabase(path, version: 1,
          onCreate: (Database db, int newerVersion) async {
            await db.execute(
              "CREATE TABLE $shinobiTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $levelColumn TEXT, $powerColumn TEXT, $teacherColumn TEXT)"
            );
          });
  }

  Future<int> save(Shinobi shinobi) async {
    final Database database = await initializeDB();
    return await database.insert(this.shinobiTable, shinobi.toMap());
  }

  Future<List<Shinobi>> fetchAll() async {
    final Database database = await initializeDB();
    final List<Map<String, Object?>> query = await database.query(
        this.shinobiTable,
        columns: [idColumn, nameColumn, levelColumn, powerColumn, teacherColumn]
    );
    return query.map((element) => Shinobi.fromMap(element)).toList();
  }

  Future<int> update(Shinobi shinobi) async {
    final Database database = await initializeDB();
    return await database.update(
        this.shinobiTable,
        shinobi.toMap(),
        where: '${this.idColumn} = ?',
        whereArgs: [shinobi.id]
    );
  }

  Future<int> delete(Shinobi shinobi) async {
    final Database database = await initializeDB();
    return await database.delete(
        this.shinobiTable,
        where: '${this.idColumn} = ?', //previne contra SQLINJECTION (tecnica de invasao.)
        whereArgs: [shinobi.id]
    );
  }

}