// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'dashboard_page_event.dart';
part 'dashboard_page_state.dart';

class DashboardPageBloc extends Bloc<DashboardPageEvent, DashboardPageState> {
  DashboardPageBloc() : super(DashboardPageState()) {
    on(mapEvent);
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
    }
  }
}
