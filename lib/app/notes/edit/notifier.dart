import 'dart:io';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project_r/app/notes/edit/editnotestate.dart';

class EditNoteNotifier extends StateNotifier<EditNoteState> {
  EditNoteNotifier() : super(EditNoteState());

  void setImage(File file) {
    state = state.copyWith(im: file);
  }

  void setLoading(bool isl) {
    state = state.copyWith(isL: isl);
  }

  
  void reset() {
    state =  EditNoteState();
  }
}
