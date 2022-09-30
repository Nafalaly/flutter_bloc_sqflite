// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_sqflite/models/models.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';

part 'memo_db_event.dart';
part 'memo_db_state.dart';
part 'db.dart';

class MemoDbBloc extends Bloc<MemoDbEvent, MemoDbState> {
  MemoDbBloc() : super(MemoDbInitial()) {
    on(mapEvent);
    add(MemoDbEventInitialDB());
  }

  late MemoDbController databaseController;

  Future<void> mapEvent(MemoDbEvent event, Emitter<MemoDbState> emit) async {
    if (event is MemoDbEventInitialDB) {
      _initial();
    }
  }

  void _initial() {
    databaseController = MemoDbController();
  }
}
