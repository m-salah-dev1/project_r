import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_r/app/notes/edit/edit.dart';
import 'package:project_r/app/notes/home/home_provide.dart';
import 'package:project_r/components/cardnote.dart';
import 'package:project_r/constant/linkapi.dart';
import 'package:project_r/model/notemodel.dart';
import 'package:project_r/main.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesProvider);
    final crud = ref.read(cureprovider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () async {
              await sharedPref.clear();
              ref.invalidate(notesProvider);
              if (!context.mounted) return;
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil("login_view", (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "add");
        },
        child: const Icon(Icons.add),
      ),
      body: notesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (snapshot) {
          final data = snapshot;

          if (data.isEmpty) {
            return const Center(
              child: Text(
                "No notes found",
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              final note = NoteModel.fromJson(data[i]);
              return Cardnote(
                m: note,
                onDelete: () async {
                  final response = await crud.postRequest(linkDeleteNote, {
                    "id": note.notesId.toString(),
                    "imagename": note.notesImage,
                    "userid": sharedPref.getString("id"),
                  });
                  if (response != null && response["status"] == "success") {
                    ref.invalidate(notesProvider);
                  }
                },
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditNotes(notes: note)),
                  );
                },
                onEdit: () {},
              );
            },
          );
        },
      ),
    );
  }
}
