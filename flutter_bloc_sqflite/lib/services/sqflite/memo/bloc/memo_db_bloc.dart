// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_sqflite/models/models.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'dart:io' show Platform;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
      emit((state as MemoDbMainState)
          .copyWith(dbState: const DBStateIdle(), currentMemo: event.data));
    } else if (event is MemoDbEventCreateData) {
      add(MemoDbEventEditingDataOnProgress());
      print('DB : creating new record..');
      await _createData(newData: event.newMemo);
      add(MemoDbEventEditingDataComplete());
    } else if (event is MemoDbEventEditingDataComplete) {
      print('DB : creating complete..');
      emit((state as MemoDbMainState)
          .copyWith(dbStateCreate: const DBStateDone()));
      emit((state as MemoDbMainState)
          .copyWith(dbStateCreate: const DBStateIdle()));
    } else if (event is MemoDbEventEditingDataOnProgress) {
      print('DB : creating in progres...');
      emit((state as MemoDbMainState)
          .copyWith(dbStateCreate: const DBStateLoading()));
    } else if (event is MemoDbEventDeleteData) {
      emit((state as MemoDbMainState)
          .copyWith(dbStateDelete: const DBStateLoading()));
      await _deleteData(currentMemo: event.currentMemo);
      add(MemoDbEventDeleteDataComplete());
    } else if (event is MemoDbEventDeleteDataComplete) {
      emit((state as MemoDbMainState)
          .copyWith(dbStateDelete: const DBStateDone()));
      emit((state as MemoDbMainState)
          .copyWith(dbStateDelete: const DBStateIdle()));
    } else if (event is MemoDbEventUpdateData) {
      print('DB BLOC; Updatingg...');
      emit((state as MemoDbMainState)
          .copyWith(dbStateEditing: const DBStateLoading()));
      await _updateData(currentMemo: event.currentUpdateMemo);
      emit((state as MemoDbMainState)
          .copyWith(dbStateEditing: const DBStateDone()));
      emit((state as MemoDbMainState)
          .copyWith(dbStateEditing: const DBStateIdle()));
    }
  }

  Future<List<Memo>> _fetchData() async {
    return await databaseController.getDataList();
  }

  Future<int> _deleteData({required Memo currentMemo}) async {
    return await databaseController.delete(currentMemo.id!);
  }

  Future<int> _updateData({required Memo currentMemo}) async {
    return await databaseController.updateData(currentMemo);
  }

  Future<int> _createData({required Memo newData}) async {
    return await databaseController.addData(newData);
  }

  void _initial() {
    databaseController = MemoDbController();
  }
}
