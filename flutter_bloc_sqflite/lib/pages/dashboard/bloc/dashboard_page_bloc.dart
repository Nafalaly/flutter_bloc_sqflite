// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_sqflite/models/models.dart';
import 'package:flutter_bloc_sqflite/services/sqflite/memo/bloc/memo_db_bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_page_event.dart';
part 'dashboard_page_state.dart';

class DashboardPageBloc extends Bloc<DashboardPageEvent, DashboardPageState> {
  MemoDbBloc dbBloc;
  late StreamSubscription dbStream;
  DashboardPageBloc({required this.dbBloc}) : super(DashboardPageState()) {
    dbStream = dbBloc.stream.listen((event) {
      if (event is MemoDbMainState) {
        if ((event.dbState is DBStateLoading)) {
          add(DashboardPageEventDBInProgress());
        } else if ((event.dbState is DBStateLoaded)) {
          print('DATA LOADED FROM PAGE');
          add(DashboardPageEventFetchDataFromDBComplete(
              data: (event.currentMemo)));
        }
      }
    });
    on(mapEvent);
    add(DashboardPageEventFetchDataFromDB());
  }

  Future<void> mapEvent(
      DashboardPageEvent event, Emitter<DashboardPageState> emit) async {
    if (event is DashboardPageEventNavigateToFormPageCreate) {
      emit((state).copyWith(
          navigateToForm:
              NavigatorTriggerStatusTriggered(route: 'form_create')));
      add(DashboardPageEventNavigateToIdle());
    } else if (event is DashboardPageEventNavigateToIdle) {
      emit(
          (state).copyWith(navigateToForm: const NavigatorTriggerStatusIdle()));
    } else if (event is DashboardPageEventFetchDataFromDB) {
      fetchDB();
    } else if (event is DashboardPageEventFetchDataFromDBComplete) {
      emit(state.copyWith(
          dataState: const DataStateLoaded(), memoData: event.data));
    } else if (event is DashboardPageEventDBInProgress) {
      emit(state.copyWith(dataState: const DataStateLoading()));
    }
  }

  void fetchDB() {
    print('DATA FETCT....');
    dbBloc.add(MemoDbEventFetchData());
  }

  @override
  Future<void> close() {
    dbStream.cancel();
    return super.close();
  }
}
