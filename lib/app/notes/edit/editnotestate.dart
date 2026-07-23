import 'dart:io';

class EditNoteState {
  final bool isLoading;
  final File? image;

  EditNoteState ({this.isLoading = false , this.image});

  EditNoteState  copyWith({ 
    bool? isL, 
    File? im,  
  }){ 
    return EditNoteState(  
      isLoading: isL ?? isLoading , 
      image: im ?? image , 
    );
  }


  EditNoteState clear() {
    return  EditNoteState();
  }

}
