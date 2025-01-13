import 'package:adminecg/common/firebase_collections/firebase_collections.dart';

class RemovedUsersRepo {
  RemovedUsersRepo({required this.removedUsersCollection});

  final RemovedUsersCollection removedUsersCollection;

  Future<void> setRemovedUser({
    required String userUid,
    required String userName,
    required String email,
  }) async {
    try {
      await removedUsersCollection.collectionReference.doc(userUid).set({
        "userUid": userUid,
        'userName': userName,
        'email': email,
      });
      print('---SetUserRepo try finish');
    } catch (e) {
      print('---RegisterRepo e = ${e}');
    }
  }
}
