// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sqflite/models/models.dart';
import 'package:flutter_bloc_sqflite/services/services.dart';
import 'package:flutter_bloc_sqflite/services/sqflite/memo/bloc/memo_db_bloc.dart';

part 'form_page_event.dart';
part 'form_page_state.dart';
part 'form_page_page.dart';

class FormPageBloc extends Bloc<FormPageEvent, FormPageState> {
  FormPageBloc({required this.dbBloc, bool? isEditingMode = false})
      : super(FormPageInitial()) {
    on(mapEvent);
    if (isEditingMode!) {
      add(FormPageEventSetToEditingMode());
    } else {
      add(FormPageEventSetToCreateMode());
    }
    dbStream = dbBloc.stream.listen((event) {
      if (event is MemoDbMainState) {
        if ((event.dbStateCreate is DBStateLoading)) {
          // add(DashboardPageEventDBInProgress());
        } else if ((event.dbStateCreate is DBStateDone)) {
          print('DATA CREATED FROM FORM');
          add(FormPageEventMemoCreateMemoComplete());
        }
      }
    });
  }

  MemoDbBloc dbBloc;
  late StreamSubscription dbStream;

  Future<void> mapEvent(
      FormPageEvent event, Emitter<FormPageState> emit) async {
    if (event is FormPageEventSetToCreateMode) {
      emit(FormPageCreateMode.initial(dbBloc: dbBloc));
    } else if (event is FormPageEventSetToEditingMode) {
      // emit(FormPageCreateMode.initial(dbBloc: dbBloc));
    } else if (event is FormPageEventMemoInformationChanged) {
      if (state is FormPageCreateMode) {
        print('FORM : Memo changed to ${event.newInformation}');
        emit((state as FormPageCreateMode)
            .copyWith(memoInformation: event.newInformation));
      } else {
        //Edit pending
      }
    } else if (event is FormPageEventMemoSaveInformation) {
      if (state is FormPageCreateMode) {
        createNewMemo();
        emit((state as FormPageCreateMode)
            .copyWith(actionFormState: const ActionFormInProgress()));
      } else {
        //editing save
      }
    } else if (event is FormPageEventMemoCreateMemoComplete) {
      emit((state as FormPageCreateMode)
          .copyWith(actionFormState: const ActionFormComplete()));
    }
  }

  void createNewMemo() {
    dbBloc.add(MemoDbEventCreateData(
        newMemo: Memo.addnewData(memo: state.memoInformation)));
  }

  @override
  Future<void> close() {
    dbStream.cancel();
    return super.close();
  }
}
