import 'package:project_r/components/crud.dart';
import 'package:project_r/constant/linkapi.dart';

class AuthService {

  final Crud _crud = Crud();


  // Firebase Login
  Future<Map?> firebaseLogin(String firebaseUid,String email) async {
    return await _crud.postRequest( linkLogin,{
        "firebase_uid": firebaseUid,
        "email": email,
      },
    );
  }



  // Firebase Signup
  Future<Map?> firebaseRegister(String username,String email, String firebaseUid,) async {
    return await _crud.postRequest( linkSignUp,{
        "username": username,
        "email": email,
        "firebase_uid": firebaseUid,
      },
    );
  }
}