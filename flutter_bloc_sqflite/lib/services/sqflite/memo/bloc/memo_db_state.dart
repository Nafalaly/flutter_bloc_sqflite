part of 'memo_db_bloc.dart';

@immutable
abstract class MemoDbState {}

class MemoDbInitial extends MemoDbState {}

class MemoDbMainState extends MemoDbState {
  final List<Memo> currentMemo = [];
}
