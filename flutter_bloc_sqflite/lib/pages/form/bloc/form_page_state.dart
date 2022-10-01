// ignore_for_file: must_be_immutable

part of 'form_page_bloc.dart';

@immutable
abstract class FormPageState {
  String memoInformation = '';
}

class FormPageInitial extends FormPageState {}

class FormPageEditMode extends FormPageState {
  late Memo currentMemo;
}

class FormPageCreateMode extends FormPageState {
  FormPageCreateMode({String? memoInformation}) {
    if (memoInformation != null) {
      super.memoInformation = memoInformation;
    }
  }
  FormPageCreateMode copyWith({
    String? memoInformation,
  }) {
    return FormPageCreateMode(
        memoInformation: memoInformation ?? this.memoInformation);
  }
}

abstract class ActionForm {}

class ActionFormIdle extends ActionForm {}

class ActionFormComplete extends ActionForm {}

class ActionFormFailure extends ActionForm {}
