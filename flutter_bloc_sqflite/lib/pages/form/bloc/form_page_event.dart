part of 'form_page_bloc.dart';

@immutable
abstract class FormPageEvent {}

class FormPageEventSetToEditingMode extends FormPageEvent {}

class FormPageEventSetToCreateMode extends FormPageEvent {}

class FormPageEventMemoInformationChanged extends FormPageEvent {
  final String newInformation;
  FormPageEventMemoInformationChanged({required this.newInformation});
}

class FormPageEventMemoSaveInformation extends FormPageEvent {}

class FormPageEventMemoCreateMemoComplete extends FormPageEvent {}
