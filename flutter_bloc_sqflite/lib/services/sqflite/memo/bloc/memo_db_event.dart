part of 'memo_db_bloc.dart';

@immutable
abstract class MemoDbEvent {}

class MemoDbEventInitialDB extends MemoDbEvent {}

class MemoDbEventFetchData extends MemoDbEvent {}

class MemoDbEventFetchDataOnProgress extends MemoDbEvent {}

class MemoDbEventFetchDataComplete extends MemoDbEvent {
  MemoDbEventFetchDataComplete({required this.data});
  final List<Memo> data;
}

class MemoDbEventFetchDataFailure extends MemoDbEvent {}
