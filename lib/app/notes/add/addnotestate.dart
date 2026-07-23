import 'dart:io';

class AddNoteState {
  final bool isLoading;
  final File? imageFile;

  AddNoteState({
    this.isLoading = false,
    this.imageFile,
  });

  AddNoteState copyWith({
    bool? isLoading,
    File? imageFile,
  }) {
    return AddNoteState(
      isLoading: isLoading ?? this.isLoading,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}