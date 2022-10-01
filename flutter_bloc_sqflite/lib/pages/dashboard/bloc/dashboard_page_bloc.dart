// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_page_event.dart';
part 'dashboard_page_state.dart';

class DashboardPageBloc extends Bloc<DashboardPageEvent, DashboardPageState> {
  DashboardPageBloc() : super(DashboardPageInitial()) {
    on(mapEvent);
  }

  Future<void> mapEvent(
      DashboardPageEvent event, Emitter<DashboardPageState> emit) async {}
}
