// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_sqflite/services/services.dart';

part 'form_page_event.dart';
part 'form_page_state.dart';
part 'form_page_page.dart';

class FormPageBloc extends Bloc<FormPageEvent, FormPageState> {
  FormPageBloc() : super(FormPageInitial()) {
    on(mapEvent);
  }

  Future<void> mapEvent(
      FormPageEvent event, Emitter<FormPageState> emit) async {}
}
