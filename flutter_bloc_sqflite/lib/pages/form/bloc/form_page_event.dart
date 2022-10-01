part of 'form_page_bloc.dart';

@immutable
abstract class FormPageEvent {}

class FormPageEventSetToEditingMode extends FormPageEvent {}

class FormPageEventSetToCreateMode extends FormPageEvent {}
