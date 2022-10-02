part of 'memo_db_bloc.dart';

@immutable
abstract class MemoDbEvent {}

class MemoDbEventInitialDB extends MemoDbEvent {}

class MemoDbEventFetchData extends MemoDbEvent {}

class MemoDbEventFetchDataOnProgress extends MemoDbEvent {}

class MemoDbEventEditingDataOnProgress extends MemoDbEvent {}

class MemoDbEventEditingDataComplete extends MemoDbEvent {}

class MemoDbEventDeleteData extends MemoDbEvent {
  final Memo currentMemo;
  MemoDbEventDeleteData({required this.currentMemo});
}

class MemoDbEventUpdateData extends MemoDbEvent {
  final Memo currentUpdateMemo;
  MemoDbEventUpdateData({required this.currentUpdateMemo});
}

class MemoDbEventDeleteDataOnProgress extends MemoDbEvent {}

class MemoDbEventDeleteDataComplete extends MemoDbEvent {}

class MemoDbEventFetchDataComplete extends MemoDbEvent {
  MemoDbEventFetchDataComplete({required this.data});
  final List<Memo> data;
}

class MemoDbEventFetchDataFailure extends MemoDbEvent {}

class MemoDbEventCreateData extends MemoDbEvent {
  final Memo newMemo;
  MemoDbEventCreateData({required this.newMemo});
}
