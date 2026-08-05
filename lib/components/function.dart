import 'dart:io';
import 'package:flutter/foundation.dart';



Future<bool> checkInternet() async {
  try {
    var result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  } catch (e) {
    debugPrint("Chekinternet Exception: $e ");
    return false;
  }
}
