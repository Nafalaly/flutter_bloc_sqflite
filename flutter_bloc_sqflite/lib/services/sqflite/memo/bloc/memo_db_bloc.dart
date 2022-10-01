// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_sqflite/models/models.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';

part 'memo_db_event.dart';
part 'memo_db_state.dart';
part 'db.dart';

class MemoDbBloc extends Bloc<MemoDbEvent, MemoDbState> {
  MemoDbBloc() : super(MemoDbInitial()) {
    on(mapEvent);
    add(MemoDbEventInitialDB());
  }

  late MemoDbController databaseController;

  Future<void> mapEvent(MemoDbEvent event, Emitter<MemoDbState> emit) async {
    if (event is MemoDbEventInitialDB) {
      _initial();
      emit(MemoDbMainState());
    } else if (event is MemoDbEventFetchData) {
      add(MemoDbEventFetchDataOnProgress());
      print('DB : fetch..');
      _fetchData();
      add(MemoDbEventFetchDataComplete(data: await _fetchData()));
    } else if (event is MemoDbEventFetchDataOnProgress) {
      print('DB : loading..');
      emit(
          (state as MemoDbMainState).copyWith(dbState: const DBStateLoading()));
    } else if (event is MemoDbEventFetchDataComplete) {
      print('DB : complete..');
      emit((state as MemoDbMainState)
          .copyWith(dbState: const DBStateDone(), currentMemo: event.data));
    } else if (event is MemoDbEventCreateData) {
      add(MemoDbEventEditingDataOnProgress());
      print('DB : creating new record..');
      await _createData(newData: event.newMemo);
      add(MemoDbEventEditingDataComplete());
    } else if (event is MemoDbEventEditingDataComplete) {
      print('DB : creating complete..');
      emit((state as MemoDbMainState)
          .copyWith(dbStateCreate: const DBStateDone()));
    } else if (event is MemoDbEventEditingDataOnProgress) {
      print('DB : creating in progres...');
      emit((state as MemoDbMainState)
          .copyWith(dbStateCreate: const DBStateLoading()));
    }
  }

  Future<List<Memo>> _fetchData() async {
    return await databaseController.getDataList();
  }

  Future<int> _createData({required Memo newData}) async {
    return await databaseController.addData(newData);
  }

  void _initial() {
    databaseController = MemoDbController();
  }
}
