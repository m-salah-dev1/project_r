import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_r/components/crud.dart';
import 'package:project_r/constant/linkapi.dart';
import 'package:project_r/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


final cureprovider = Provider((ref) => Crud());


// final notesProvider = FutureProvider<Map<String , dynamic>>((ref) async { 

//   final c = ref.read(cureprovider); 
//   final response = await c.postRequest(linkViewNotes, { "id" : sharedPref.getString("id") ?? " " } );


//   return response ??   {  "status" : 'fail'   ,     "data" : [] };
// });


final notesProvider = FutureProvider<List<dynamic>>((ref) async {
  final c = ref.read(cureprovider);

    final prefs = await SharedPreferences.getInstance();

  final userid = prefs.getString("id");

  if(userid == null){
    return [];
  }

  final response = await c.postRequest(
    linkViewNotes,
    {"id": sharedPref.getString("id") ?? ""},
  );

  if (response == null || response["data"] == null) {
    return [];
  }

  return response["data"];
});