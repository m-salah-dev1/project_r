import 'package:flutter_riverpod/legacy.dart';
import 'package:project_r/app/notes/edit/editnotestate.dart';
import 'package:project_r/app/notes/edit/notifier.dart';




final editNoteNotifier = StateNotifierProvider<  EditNoteNotifier , EditNoteState >((ref){

  return  EditNoteNotifier();
});