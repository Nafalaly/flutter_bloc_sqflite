// ignore_for_file: must_be_immutable

part of 'dashboard_page_bloc.dart';

@immutable
class DashboardPageState {
  late NavigatorTriggerStatus navigateToForm;

  DashboardPageState({
    this.navigateToForm = const NavigatorTriggerStatusIdle(),
  });

  DashboardPageState copyWith({NavigatorTriggerStatus? navigateToForm}) {
    return DashboardPageState(
        navigateToForm: navigateToForm ?? this.navigateToForm);
  }
}

abstract class NavigatorTriggerStatus {
  const NavigatorTriggerStatus();
}

class NavigatorTriggerStatusIdle extends NavigatorTriggerStatus {
  const NavigatorTriggerStatusIdle();
}

class NavigatorTriggerStatusTriggered extends NavigatorTriggerStatus {
  final String route;
  NavigatorTriggerStatusTriggered({required this.route});
}
