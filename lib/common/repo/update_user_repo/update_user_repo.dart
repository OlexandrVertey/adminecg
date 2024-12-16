import 'package:adminecg/common/firebase_collections/firebase_collections.dart';

class UpdateUserRepo {
  UpdateUserRepo({required this.usersCollection});

  final UsersCollection usersCollection;

  Future<void> updateUser({
    required String userUid,
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      print('---UpdateUserRepo try userUid = ${userUid}');
      await usersCollection.collectionReference.doc(userUid).update({
        'fullName': fullName,
        'email': email,
        'password': password,
      });
    } catch (e) {
      print('---UpdateUserRepo e = ${e}');
    }
  }
}
