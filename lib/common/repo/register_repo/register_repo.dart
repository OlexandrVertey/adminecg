import 'package:firebase_auth/firebase_auth.dart';

class RegisterRepo {
  RegisterRepo({required this.auth});

  final FirebaseAuth auth;

  Future<UserCredential?> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(email: email, password: password);
      if (user.user != null) {
        return user;
      }
    }  on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          print('signUp The password provided is too weak.');
          break;
        case 'email-already-in-use':
          print('signUp The account already exists for that email.');
          break;
        default:
          print('signUp Error');
      }
    } catch (e) {
      print('---RegisterRepo e = ${e}');
    }
    return null;
  }
}
