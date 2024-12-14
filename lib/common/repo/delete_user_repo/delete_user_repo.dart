import 'package:adminecg/common/firebase_collections/firebase_collections.dart';

class DeleteUserRepo {
  DeleteUserRepo({required this.usersCollection});

  final UsersCollection usersCollection;

  Future<void> deleteUser({
    required String userUid,
  }) async {
    try {
      await usersCollection.collectionReference.doc(userUid).delete();
    } catch (e) {
      print('---DeleteUserRepo e = ${e}');
    }
  }
}
