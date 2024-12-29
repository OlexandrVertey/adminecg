import 'package:adminecg/common/firebase_collections/firebase_collections.dart';

class SetUserRepo {
  SetUserRepo({required this.usersCollection});

  final UsersCollection usersCollection;

  Future<void> setUser({
    required String userUid,
    required String fullName,
    required String email,
    required String password,
    String? registerData,
    String? organisation,
  }) async {
    try {
      await usersCollection.collectionReference.doc(userUid).set({
        "userUid": userUid,
        'fullName': fullName,
        'email': email,
        'password': password,
        'organisation': organisation,
        'registerData': registerData,
      });
      print('---SetUserRepo try finish');
    } catch (e) {
      print('---RegisterRepo e = ${e}');
    }
  }
}
