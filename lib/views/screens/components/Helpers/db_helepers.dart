import 'package:hotel_booking_app/models/db_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db_Helper {
  Db_Helper._();

  static final Db_Helper db_helper = Db_Helper._();
  static Database? db;

  Future initDB() async {
    String dbpath = await getDatabasesPath();
    String path = await join(dbpath, "databaseapp.db");
    print("==============================================");
    print("Create Database");
    print("==============================================");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE IF NOT EXISTS bugetTrecker(id INTEGER PRIMARY KEY AUTOINCREMENT,category_name TEXT,category_image BLOB);");
        await db.execute(
            "CREATE TABLE IF NOT EXISTS spending(id INTEGER PRIMARY KEY AUTOINCREMENT, spending_name TEXT, spending_amount TEXT, spending_mode TEXT, spending_type TEXT,spending_time TEXT, spending_date TEXT);");
      },
    );
  }

  Future<int?> addCategory({required DbModel dbmodel}) async {
    await initDB();
    String query =
        "INSERT INTO bugetTrecker(category_name,category_image) VALUES(?,?);";
    List arg = [dbmodel.category_name, dbmodel.category_image];
    int? response = await db?.rawInsert(query, arg);
    return response;
  }

  Future<List<DbModel>> fetchAllCategory() async {
    await initDB();
    String Query = "SELECT * FROM bugetTrecker";
    List<Map<String, dynamic>>? response = await db?.rawQuery(Query);

    List<DbModel> allData =
        response!.map((e) => DbModel.fromSQL(data: e)).toList();
    return allData;
  }

  Future<int?> DeleteCategory({required int id}) async {
    await initDB();
    String query = "DELETE FROM bugetTrecker WHERE id = ?";
    List args = [id];

    int? response = await db?.rawDelete(query, args);
    return response;
  }

  Future<int?> UpdateData({required String cat_name, required int id}) async {
    await initDB();
    String query = "UPDATE bugetTrecker SET category_name=? WHERE id=?";
    List args = [cat_name, id];
    int? response = await db?.rawUpdate(query, args);
    return response;
  }

  Future<List<DbModel>?> FetchsearchData({String data = ""}) async {
    await initDB();
    String query =
        "SELECT * FROM bugetTrecker WHERE category_name LIKE '%$data%'";

    List<Map<String, dynamic>>? res = await db?.rawQuery(query);
    List<DbModel>? searchData =
        await res?.map((e) => DbModel.fromSQL(data: e)).toList();

    return searchData;
  }
}
