import 'package:flutter/material.dart';
import 'package:project_r/constant/linkapi.dart';
import 'package:project_r/model/notemodel.dart';


class Cardnote extends StatelessWidget {
  final void Function()? ontap;
  final void Function()? onDelete;
  final void Function()? onEdit;
  final NoteModel m;

  const Cardnote({
    super.key,
    required this.ontap,
    required this.onDelete,
    required this.onEdit,
    required this.m,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                "$linkImageRoot/${m.notesImage}",
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text(m.notesTitle),
                subtitle: Text(m.notesContent),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: onEdit,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}