part of 'form_page_bloc.dart';

@immutable
abstract class FormPageEvent {}

class FormPageEventSetToEditingMode extends FormPageEvent {
  final Memo currentMemo;
  FormPageEventSetToEditingMode({required this.currentMemo});
}

class FormPageEventSetToCreateMode extends FormPageEvent {}

class FormPageEventDeleteByActionButton extends FormPageEvent {
  final Memo currentMemo;
  FormPageEventDeleteByActionButton({required this.currentMemo});
}

class FormPageEventDeleteByActionButtonComplete extends FormPageEvent {}

class FormPageEventMemoInformationChanged extends FormPageEvent {
  final String newInformation;
  FormPageEventMemoInformationChanged({required this.newInformation});
}

class FormPageEventMemoSaveInformation extends FormPageEvent {}

class FormPageEventMemoUpdateButtonAction extends FormPageEvent {}

class FormPageEventUpdateMemoInformation extends FormPageEvent {
  final Memo updatedMemo;
  FormPageEventUpdateMemoInformation({required this.updatedMemo});
}

class FormPageEventMemoCreateMemoComplete extends FormPageEvent {}

class FormPageEventMemoEditMemoComplete extends FormPageEvent {}
