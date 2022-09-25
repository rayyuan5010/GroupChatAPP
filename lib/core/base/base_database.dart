import 'package:group_chat/core/logger.dart';
import 'package:group_chat/other/dbHelp.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseBasic {
  Future create(Database db, String tableName, Map columns) async {
    Logger().i("[DataBaseBasic][create][$tableName] start");
    var result = await db
        .query('sqlite_master', where: 'name = ?', whereArgs: [tableName]);
    if (result.isEmpty) {
      Logger().i("[DataBaseBasic][create][$tableName] table create");
      String columnsSQL = "";
      columns.forEach((key, value) {
        columnsSQL += "$key $value ,";
      });
      columnsSQL += "createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,";
      columnsSQL += "updatedAt DATETIME  DEFAULT CURRENT_TIMESTAMP,";
      columnsSQL += "deletedAt DATETIME,";
      columnsSQL += "isUpload INTEGER DEFAULT 0";

      // columnsSQL = columnsSQL.substring(0, columnsSQL.length - 1);

      String sql = "CREATE TABLE $tableName ($columnsSQL)";
      try {
        await db.execute(sql);
        getLogger(className: "DataBaseBasic").d(sql);
        return true;
      } catch (e) {
        getLogger(className: "DataBaseBasic").e(e);
        return false;
      }
    } else {
      getLogger(className: "DataBaseBasic").i("[$tableName] table exists");
    }
  }

  drop(Database db, String tableName) async {
    var result = await db
        .query('sqlite_master', where: 'name = ?', whereArgs: [tableName]);
    if (result.isNotEmpty) {
      await db.execute("DROP TABLE $tableName");
    } else {
      return false;
    }
    return true;
  }

  clear(Database db, String tableName) async {
    var result = await db
        .query('sqlite_master', where: 'name = ?', whereArgs: [tableName]);
    if (result.isNotEmpty) {
      await db.execute("DELETE * FROM TABLE $tableName");
    } else {
      return false;
    }
    return true;
  }
}
