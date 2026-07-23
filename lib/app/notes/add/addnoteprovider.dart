import 'package:flutter_riverpod/legacy.dart';
import 'package:project_r/app/notes/add/addnoteifier.dart';
import 'package:project_r/app/notes/add/addnotestate.dart';

final addNoteProvider =
    StateNotifierProvider<AddNoteNotifier, AddNoteState>(
  (ref) => AddNoteNotifier(),
);