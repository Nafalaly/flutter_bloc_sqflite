part of 'memo_db_bloc.dart';

class MemoDbController {
  static MemoDbController? classdb;
  static Database? _database;
  MemoDbController.createinstance();
  factory MemoDbController() {
    classdb ??= MemoDbController.createinstance();
    return classdb!;
  }

  Future<Database> get database async {
    _database ??= await initdb();
    return _database!;
  }

  Future<Database> initdb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}my_database.db';
    var database = await openDatabase(path, version: 1, onCreate: _createdb);

    return database;
  }

  void _createdb(Database db, int newVersion) async {
    String buattabel =
        'CREATE TABLE ${Memo.tableName}(${Memo.colId} INTEGER PRIMARY KEY AUTOINCREMENT,${Memo.colMemo} TEXT)';
    await db.execute(buattabel);
  }

  Future<int> purgeAllDatas() async {
    var db = await database;
    int result = await db.rawDelete('DELETE FROM ${Memo.tableName}');
    return result;
  }

  //UPDATE
  Future<int> updateData(Memo newMemo) async {
    print(
        'Database trying to update with id ${newMemo.id}, with val ${newMemo.memo}');
    var db = await database;
    var result = await db.update(Memo.tableName, newMemo.toMap(),
        where: '${Memo.colId}=?', whereArgs: [newMemo.id]);
    return result;
  }

  //FETCH Op
  Future<List<Map<String, dynamic>>> _getDataMapList() async {
    Database db = await database;
    List<Map<String, Object?>> result;
    result =
        await db.query(Memo.tableName, orderBy: 'datetime(${Memo.colId}) DESC');
    return result;
  }

  //Insert Op
  Future<int> addData(Memo newData) async {
    Database db = await database;
    var result = await db.insert(Memo.tableName, newData.toMap());
    return result;
  }

  //Delete
  Future<int> delete(String id) async {
    var db = await database;
    int result = await db
        .rawDelete('DELETE FROM ${Memo.tableName} WHERE ${Memo.colId}="$id"');
    return result;
  }

  //get maplist
  Future<List<Memo>> getDataList() async {
    var foodmaplist = await _getDataMapList();
    int count = foodmaplist.length;
    List<Memo> foodlist = [];
    for (int i = 0; i < count; i++) {
      foodlist.add(Memo.fromDatabase(foodmaplist[i]));
    }
    return foodlist;
  }
}
