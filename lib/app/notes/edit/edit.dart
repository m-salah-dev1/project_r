import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:project_r/app/notes/edit/provider.dart';

import 'package:project_r/screen/home/home_provide.dart';
import 'package:project_r/components/crud.dart';
import 'package:project_r/components/customtextform.dart';
import 'package:project_r/components/valid.dart';
import 'package:project_r/constant/linkapi.dart';
import 'package:project_r/main.dart';
import 'package:project_r/model/notemodel.dart';

class EditNotes extends ConsumerStatefulWidget {
  final NoteModel notes;

  const EditNotes({
    super.key,
    required this.notes,
  });

  @override
  ConsumerState<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends ConsumerState<EditNotes> {
  final formstate = GlobalKey<FormState>();

  final title = TextEditingController();
  final content = TextEditingController();

  final Crud crud = Crud();

  @override
  void initState() {
    super.initState();

    title.text = widget.notes.notesTitle;
    content.text = widget.notes.notesContent;
  }

  @override
  void dispose() {
    title.dispose();
    content.dispose();
    super.dispose();
  }

  Future editNote() async {
    final state = ref.read(editNoteNotifier);
    final imageFile = state.image;

    if (!formstate.currentState!.validate()) return;

    ref.read(editNoteNotifier.notifier).setLoading(true);

    final noteId = widget.notes.notesId.toString();
    final token = sharedPref.getString("token");

    final data = {
      "title": title.text,
      "content": content.text,
      "id": noteId,
      "imagename": widget.notes.notesImage
      
    };

    Map<String, dynamic>? response;

    if (imageFile != null) {
      response = await crud.postRequestWithFile(
        linkEditNote,
        data,
        imageFile,
        token:token
        
      );
    } else {
      response = await crud.postRequest(
        linkEditNote,
        data,
        token: token
        
      );
    }
    debugPrint("EDIT RESPONSE = $response");

    ref.read(editNoteNotifier.notifier).setLoading(false);

    if (!mounted) return;

    if (response != null && response["status"] == "success") {
      ref.invalidate(notesProvider);

      // reset state 
      ref.read(editNoteNotifier.notifier).reset();

      Navigator.pop(context);
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: " Operation failed",
        desc: response?["message"] ?? "An unknown error occurred",
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editNoteNotifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Note")),

      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: formstate,
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [

                  CustTextForm(
                    hint: "title",
                    mycontroller: title,
                    valid: (val) => validIput(val!, 2, 50),
                  ),

                  CustTextForm(
                    hint: "content",
                    mycontroller: content,
                    valid: (val) => validIput(val!, 10, 300),
                  ),

                  const SizedBox(height: 10),

                  MaterialButton(
                    onPressed: editNote,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: const Text("Save Changes"),
                  ),

                  const SizedBox(height: 10),

                  MaterialButton(
                    color: state.image != null
                        ? Colors.green
                        : Colors.grey,
                    textColor: Colors.white,
                    child: const Text("Choose Image"),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          padding: const EdgeInsets.all(10),
                          height: 150,
                          child: Column(
                            children: [

                              const Text(
                                "Choose Image",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                ),
                              ),

                              InkWell(
                                onTap: () async {
                                  final xfile = await ImagePicker()
                                      .pickImage(
                                        source: ImageSource.gallery,
                                      );

                                  if (xfile == null) return;
                                  if (!context.mounted) return;

                                  Navigator.pop(context);

                                  ref
                                      .read(editNoteNotifier.notifier)
                                      .setImage(File(xfile.path));
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "From Gallery",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: () async {
                                  final xfile = await ImagePicker()
                                      .pickImage(
                                        source: ImageSource.camera,
                                      );

                                  if (xfile == null) return;
                                  if (!context.mounted) return;

                                  Navigator.pop(context);

                                  ref
                                      .read(editNoteNotifier.notifier)
                                      .setImage(File(xfile.path));
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    "From Camera",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}