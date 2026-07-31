import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_r/components/crud.dart';
import 'package:project_r/constant/linkapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

final cureprovider = Provider((ref) => Crud());

final notesProvider = FutureProvider.autoDispose<List<dynamic>>((ref) async {
  final c = ref.read(cureprovider);

  final prefs = await SharedPreferences.getInstance();

  final userid = prefs.getString("id");

  debugPrint("CURRENT USER ID = $userid");

  if (userid == null || userid.isEmpty) {
    return [];
  }

  final response = await c.postRequest(linkViewNotes, {"id": userid});

    debugPrint("SERVER RESPONSE = $response");


  if (response == null ||
      response["status"] != "success" ||
      response["data"] == null) {
    return [];
  }

  return response["data"];
});
