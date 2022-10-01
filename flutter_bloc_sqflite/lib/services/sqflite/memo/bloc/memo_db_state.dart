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

class DBStateLoading extends DBState {
  const DBStateLoading();
}

class DBStateLoaded extends DBState {
  const DBStateLoaded();
}

class DBStateFailure extends DBState {
  const DBStateFailure();
}

class MemoDbMainState extends MemoDbState {
  late List<Memo> currentMemo;
  late DBState dbState;

  MemoDbMainState(
      {this.currentMemo = const [], this.dbState = const DBStateInitial()});

  MemoDbMainState copyWith({List<Memo>? currentMemo, DBState? dbState}) {
    return MemoDbMainState(
        currentMemo: currentMemo ?? this.currentMemo,
        dbState: dbState ?? this.dbState);
  }
}
