import 'package:adminecg/common/firebase_collections/firebase_collections.dart';

class SetUserRepo {
  SetUserRepo({required this.usersCollection});

  final UsersCollection usersCollection;

  Future<void> setUser({
    required String userUid,
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      print('---SetUserRepo try userUid = ${userUid}');
      print('---SetUserRepo try fullName = ${fullName}');
      print('---SetUserRepo try email = ${email}');
      print('---SetUserRepo try password = ${password}');
      await usersCollection.collectionReference.doc(userUid).set({
        "userUid": userUid,
        'fullName': fullName,
        'email': email,
        'password': password,
      });
      print('---SetUserRepo try finish');
    } catch (e) {
      print('---RegisterRepo e = ${e}');
    }
  }
}
