// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'memo_db_controller_state.dart';

class MemoDbControllerCubit extends Cubit<MemoDbControllerState> {
  MemoDbControllerCubit() : super(MemoDbControllerInitial());
}
