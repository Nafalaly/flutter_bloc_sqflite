// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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
  }

  MemoDbBloc dbBloc;
  late StreamSubscription dbStream;

  Future<void> mapEvent(
      FormPageEvent event, Emitter<FormPageState> emit) async {
    if (event is FormPageEventSetToCreateMode) {
    } else if (event is FormPageEventSetToEditingMode) {}
  }
}
