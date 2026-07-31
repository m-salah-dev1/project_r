import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:project_r/app/notes/add/addnoteprovider.dart';
import 'package:project_r/app/notes/home/home_provide.dart';
import 'package:project_r/components/crud.dart';
import 'package:project_r/components/customtextform.dart';
import 'package:project_r/components/valid.dart';
import 'package:project_r/constant/linkapi.dart';
import 'package:project_r/main.dart';


class AddNotes extends ConsumerStatefulWidget {
  const AddNotes({super.key});

  @override
  ConsumerState<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends ConsumerState<AddNotes> {
  final formstate = GlobalKey<FormState>();

  final title = TextEditingController();
  final content = TextEditingController();

  final Crud crud = Crud();

  Future addNote() async {
    final state = ref.read(addNoteProvider);
    final imageFile = state.imageFile;

    if (imageFile == null) {
      return AwesomeDialog(
        context: context,
        title: "Alert",
        body: const Text("Please add image"),
      ).show();
    }

    if (!formstate.currentState!.validate()) return;

    ref.read(addNoteProvider.notifier).setLoading(true);

    var userId = sharedPref.getString("id");

    var response = await crud.postRequestWithFile(
      linkAddNotes,
      {
        "title": title.text,
        "content": content.text,
        "id": userId ?? "",
      },
      imageFile,
    );

    ref.read(addNoteProvider.notifier).setLoading(false);

    if (!mounted) return;

    if (response != null && response["status"] == "success") {
      ref.invalidate(notesProvider);
      Navigator.pop(context);
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: "فشل العملية",
        desc: response["message"] ?? "حدث خطأ غير معروف",
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addNoteProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Add Notes")),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: formstate,
              child: ListView(
                children: [
                  CustTextForm(
                    hint: "title",
                    mycontroller: title,
                    valid: (val) => validIput(val!, 2, 10),
                  ),
                  CustTextForm(
                    hint: "content",
                    mycontroller: content,
                    valid: (val) => validIput(val!, 10, 300),
                  ),

                  MaterialButton(
                    onPressed: addNote,
                    color: Colors.blue,
                    child: const Text("Add"),
                  ),

                  MaterialButton(
                    color: state.imageFile == null
                        ? Colors.blue
                        : Colors.green,
                    textColor: Colors.white,
                    child: const Text("Choose Image"),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          padding: const EdgeInsets.all(10),
                          height: 120,
                          child: Column(
                            children: [
                              const Text(
                                "Please Choose Image",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.blue),
                              ),

                              InkWell(
                                onTap: () async {
                                  final xfile = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.gallery);

                                  if (!context.mounted) return;
                                  if (xfile == null) return;

                                  Navigator.pop(context);

                                  ref
                                      .read(addNoteProvider.notifier)
                                      .setImage(File(xfile.path));
                                },
                                child: const SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text("From Gallery",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue)),
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: () async {
                                  final xfile = await ImagePicker()
                                      .pickImage(
                                          source: ImageSource.camera);

                                  if (!context.mounted) return;
                                  Navigator.pop(context);

                                  if (xfile == null) return;

                                  ref
                                      .read(addNoteProvider.notifier)
                                      .setImage(File(xfile.path));
                                },
                                child: const SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text("From Camera",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blue)),
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