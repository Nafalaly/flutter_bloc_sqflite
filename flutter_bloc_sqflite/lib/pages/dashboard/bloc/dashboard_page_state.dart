// ignore_for_file: must_be_immutable

part of 'dashboard_page_bloc.dart';

@immutable
class DashboardPageState {
  late NavigatorTriggerStatus navigateToForm;
  late DataState dataState;
  late List<Memo> memoData;
  DashboardPageState(
      {this.navigateToForm = const NavigatorTriggerStatusIdle(),
      this.dataState = const DataStateInitial(),
      this.memoData = const []});

  DashboardPageState copyWith(
      {NavigatorTriggerStatus? navigateToForm,
      DataState? dataState,
      List<Memo>? memoData}) {
    return DashboardPageState(
        navigateToForm: navigateToForm ?? this.navigateToForm,
        dataState: dataState ?? this.dataState,
        memoData: memoData ?? this.memoData);
  }
}

abstract class NavigatorTriggerStatus {
  const NavigatorTriggerStatus();
}

class NavigatorTriggerStatusIdle extends NavigatorTriggerStatus {
  const NavigatorTriggerStatusIdle();
}

class NavigatorTriggerStatusTriggered extends NavigatorTriggerStatus {
  Memo? currentMemo;
  final String route;
  NavigatorTriggerStatusTriggered({required this.route, this.currentMemo});
}

abstract class DataState {
  const DataState();
}

class DataStateInitial extends DataState {
  const DataStateInitial();
}

class DataStateLoading extends DataState {
  const DataStateLoading();
}

class DataStateLoaded extends DataState {
  const DataStateLoaded();
}

class DataStateFailure extends DataState {
  const DataStateFailure();
}
