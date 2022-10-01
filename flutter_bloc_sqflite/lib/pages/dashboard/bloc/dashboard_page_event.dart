part of 'dashboard_page_bloc.dart';

@immutable
abstract class DashboardPageEvent {}

class DashboardPageEventNavigateToFormPageCreate extends DashboardPageEvent {}

class DashboardPageEventNavigateToIdle extends DashboardPageEvent {}
