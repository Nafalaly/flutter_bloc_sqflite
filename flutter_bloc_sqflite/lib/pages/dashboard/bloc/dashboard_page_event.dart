part of 'dashboard_page_bloc.dart';

@immutable
abstract class DashboardPageEvent {
  const DashboardPageEvent();
}

//Event for navigating to other pages
class DashboardPageEventNavigateToFormPageCreate extends DashboardPageEvent {}

class DashboardPageEventNavigateToIdle extends DashboardPageEvent {}

//DB Operation
class DashboardPageEventFetchDataFromDB extends DashboardPageEvent {}

class DashboardPageEventDBInProgress extends DashboardPageEvent {}

class DashboardPageEventOnFormCreateComplete extends DashboardPageEvent {}

class DashboardPageEventFetchDataFromDBComplete extends DashboardPageEvent {
  final List<Memo> data;
  const DashboardPageEventFetchDataFromDBComplete({required this.data});
}
