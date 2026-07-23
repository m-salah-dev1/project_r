import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';





// String  _basicAuth = 'Basic' + 
// base64Encode(utf8.encode('mo:123'));

//  Map<String , String> myheaders = {
//   'authorization' : _basicAuth

//  };








class Crud {
  final Duration timeoutDuration = const Duration(seconds: 15);


  Future<dynamic> getRequest(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(timeoutDuration);

      return _handleResponse(response);
    } on SocketException {
      return _error("No internet connection");
    } on FormatException {
      return _error("Bad response format");
    } catch (e) {
      return _error("Unexpected error: $e");
    }
  }




  Future<dynamic> postRequest(String url, Map data) async {
    try {
      final response = await http.post(Uri.parse(url), body: _safeMap(data))
          .timeout(timeoutDuration);

      return _handleResponse(response);
    } on SocketException {
      return _error("No internet connection");
    } catch (e) {
      return _error("Unexpected error: $e");
    }
  }

  // =======================
  // POST REQUEST WITH FILE (ADD)
  // =======================
  Future<dynamic> postRequestWithFile(
    String url,
    Map data,
    File file,
  ) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));

      // file
      request.files.add(
        await http.MultipartFile.fromPath(
          "file",
          file.path,
          filename: basename(file.path),
        ),
      );

      // fields
      request.fields.addAll(_safeMap(data));

      var streamed = await request.send().timeout(timeoutDuration);
      var response = await http.Response.fromStream(streamed);

      return _handleResponse(response);
    } on SocketException {
      return _error("No internet connection");
    } catch (e) {
      return _error("Unexpected error: $e");
    }
  }

  // =======================
  // POST REQUEST WITH OPTIONAL FILE (EDIT)
  // =======================
 Future<dynamic> postRequestWithOptionalFile(String url, Map data, {File? file,}) async {
  
  try {
    var request = http.MultipartRequest("POST", Uri.parse(url));

    // fields
    request.fields.addAll(
      data.map((k, v) => MapEntry(k.toString(), v.toString())),
    );

    // file فقط إذا موجود
    if (file != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          "file",
          file.path,
          filename: basename(file.path),
        ),
      );
    }

    var streamed = await request.send();
    var response = await http.Response.fromStream(streamed);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return {
      "status": "fail",
      "message": "server error",
    };
  } catch (e) {
    return {
      "status": "fail",
      "message": e.toString(),
    };
  }
}

  // =======================
  // RESPONSE HANDLER
  // =======================
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return {
      "status": "fail",
      "message": "Server error (${response.statusCode})",
    };
  }

  // =======================
  // SAFE MAP CONVERTER
  // =======================
  Map<String, String> _safeMap(Map data) {
    return data.map((key, value) {
      return MapEntry(key.toString(), value?.toString() ?? "");
    });
  }

  // =======================
  // ERROR FORMAT
  // =======================
  Map<String, dynamic> _error(String msg) {
    return {
      "status": "fail",
      "message": msg,
    };
  }
}