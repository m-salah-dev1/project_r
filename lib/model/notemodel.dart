class NoteModel {
  int notesId;
  String notesTitle;
  String notesContent;
  String notesImage;
  int notesUsers;

  NoteModel({
    required this.notesId,
    required this.notesTitle,
    required this.notesContent,
    required this.notesImage,
    required this.notesUsers,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      notesId: int.tryParse(json['notes_id']?.toString() ?? '') ?? 0,

      notesTitle: json['notes_title']?.toString() ?? '',

      notesContent: json['notes_content']?.toString() ?? '',

      notesImage: json['notes_image']?.toString() ?? '',

      notesUsers: int.tryParse(json['notes_users']?.toString() ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notes_id': notesId,
      'notes_title': notesTitle,
      'notes_content': notesContent,
      'notes_image': notesImage,
      'notes_users': notesUsers,
    };
  }
}