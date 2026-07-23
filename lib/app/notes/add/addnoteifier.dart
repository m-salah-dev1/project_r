import 'dart:io';

import 'package:flutter_riverpod/legacy.dart';
import 'package:project_r/app/notes/add/addnotestate.dart';

class AddNoteNotifier extends StateNotifier<AddNoteState> {
  AddNoteNotifier() : super(AddNoteState());

  void setImage(File file) {
    state = state.copyWith(imageFile: file);
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }
}