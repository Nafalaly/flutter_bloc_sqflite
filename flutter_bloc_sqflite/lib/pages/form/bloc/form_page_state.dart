// ignore_for_file: must_be_immutable

part of 'form_page_bloc.dart';

@immutable
abstract class FormPageState {
  MemoDbBloc dbBloc = MemoDbBloc();
  String memoInformation = '';
  ActionFormState actionFormState = const ActionFormIdle();
}

class FormPageInitial extends FormPageState {}

class FormPageEditMode extends FormPageState {
  late Memo currentMemo;
}

class FormPageCreateMode extends FormPageState {
  FormPageCreateMode.initial({required MemoDbBloc dbBloc}) {
    super.dbBloc;
  }
  FormPageCreateMode(
      {String? memoInformation, ActionFormState? actionFormState}) {
    if (memoInformation != null) {
      super.memoInformation = memoInformation;
    }
    if (actionFormState != null) {
      super.actionFormState = actionFormState;
    }
  }
  FormPageCreateMode copyWith({
    String? memoInformation,
    ActionFormState? actionFormState,
  }) {
    return FormPageCreateMode(
        memoInformation: memoInformation ?? this.memoInformation,
        actionFormState: actionFormState ?? this.actionFormState);
  }
}

abstract class ActionFormState {
  const ActionFormState();
}

class ActionFormInProgress extends ActionFormState {
  const ActionFormInProgress();
}

class ActionFormIdle extends ActionFormState {
  const ActionFormIdle();
}

class ActionFormComplete extends ActionFormState {
  const ActionFormComplete();
}

class ActionFormFailure extends ActionFormState {
  final String errorCode;
  const ActionFormFailure({required this.errorCode});
}
