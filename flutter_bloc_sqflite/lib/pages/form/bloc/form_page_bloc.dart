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
  FormPageBloc(
      {required this.dbBloc, bool? isEditingMode = false, Memo? currentMemo})
      : super(FormPageInitial()) {
    on(mapEvent);
    if (isEditingMode!) {
      print('Editing mode set');
      add(FormPageEventSetToEditingMode(currentMemo: currentMemo!));
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
        } else if (event.dbStateEditing is DBStateDone) {
          print('DATA EDITED FROM FORM');
          add(FormPageEventMemoEditMemoComplete());
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
      print('Emiting new State Edit');
      emit(FormPageEditMode.initial(
          dbBloc: dbBloc, currentMemo: event.currentMemo));
      emit((state as FormPageEditMode).copyWith(initialState: false));
    } else if (event is FormPageEventMemoInformationChanged) {
      print('FORM : Memo changed to ${event.newInformation}');
      if (state is FormPageCreateMode) {
        emit((state as FormPageCreateMode)
            .copyWith(memoInformation: event.newInformation));
      } else {
        emit((state as FormPageEditMode)
            .copyWith(memoInformation: event.newInformation));
      }
    } else if (event is FormPageEventMemoSaveInformation) {
      createNewMemo();
      emit((state as FormPageCreateMode)
          .copyWith(actionFormState: const ActionFormInProgress()));
    } else if (event is FormPageEventMemoCreateMemoComplete) {
      emit((state as FormPageCreateMode)
          .copyWith(actionFormState: const ActionFormComplete()));
    } else if (event is FormPageEventMemoEditMemoComplete) {
      emit((state as FormPageEditMode)
          .copyWith(actionFormState: const ActionFormComplete()));
    } else if (event is FormPageEventDeleteByActionButton) {
    } else if (event is FormPageEventMemoUpdateButtonAction) {
      print(
          'Updating action with id ${(state as FormPageEditMode).currentMemo.id}');
      add(FormPageEventUpdateMemoInformation(
          updatedMemo: Memo.addnewDataWtId(
              memo: state.memoInformation,
              id: (state as FormPageEditMode).currentMemo.id)));
    } else if (event is FormPageEventUpdateMemoInformation) {
      print('sending signla to update id ${event.updatedMemo.id}');
      updateMemo(currentUpdate: event.updatedMemo);
      emit((state as FormPageEditMode)
          .copyWith(actionFormState: const ActionFormInProgress()));
    }
  }

  void updateMemo({required Memo currentUpdate}) {
    dbBloc.add(MemoDbEventUpdateData(currentUpdateMemo: currentUpdate));
  }

  void deleteMemo({required Memo currentDelete}) {
    dbBloc.add(MemoDbEventDeleteData(currentMemo: currentDelete));
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
