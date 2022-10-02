part of 'models.dart';

class Memo {
  static const String tableName = 'memo_table';
  static const String colId = 'id';
  static const String colMemo = 'memo';

  //col
  String? id;
  late String memo;
  Memo();
  Memo.addnewData({required this.memo});
  Memo.addnewDataWtId({required this.id, required this.memo});

  Memo.fromDatabase(Map<String, dynamic> db) {
    id = db[colId].toString();
    memo = db[colMemo];
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{};
    if (id != null) {
      map[colId] = id;
    }
    map[colMemo] = memo;
    return map;
  }
}
