// ignore_for_file: must_be_immutable

part of 'memo_db_bloc.dart';

@immutable
abstract class MemoDbState {}

class MemoDbInitial extends MemoDbState {}

abstract class DBState {
  const DBState();
}

class DBStateInitial extends DBState {
  const DBStateInitial();
}

class DBStateIdle extends DBState {
  const DBStateIdle();
}

class DBStateLoading extends DBState {
  const DBStateLoading();
}

class DBStateDone extends DBState {
  const DBStateDone();
}

class DBStateFailure extends DBState {
  const DBStateFailure();
}

class MemoDbMainState extends MemoDbState {
  late List<Memo> currentMemo;
  late DBState dbState;
  late DBState dbStateEditing;
  late DBState dbStateCreate;
  late DBState dbStateDelete;

  MemoDbMainState({
    this.currentMemo = const [],
    this.dbState = const DBStateInitial(),
    this.dbStateEditing = const DBStateInitial(),
    this.dbStateCreate = const DBStateInitial(),
    this.dbStateDelete = const DBStateInitial(),
  });

  MemoDbMainState copyWith({
    List<Memo>? currentMemo,
    DBState? dbState,
    DBState? dbStateEditing,
    DBState? dbStateCreate,
    DBState? dbStateDelete,
  }) {
    return MemoDbMainState(
      currentMemo: currentMemo ?? this.currentMemo,
      dbState: dbState ?? this.dbState,
      dbStateCreate: dbStateCreate ?? this.dbStateCreate,
      dbStateDelete: dbStateDelete ?? this.dbStateDelete,
      dbStateEditing: dbStateEditing ?? this.dbStateEditing,
    );
  }
}
