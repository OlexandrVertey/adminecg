import 'package:adminecg/common/firebase_collections/firebase_collections.dart';

class DeleteUserRepo {
  DeleteUserRepo({required this.usersCollection, required this.statisticCollection});

  final UsersCollection usersCollection;
  final StatisticCollection statisticCollection;



  Future<void> deleteUser({
    required String userUid,
  }) async {
    try {
      await usersCollection.collectionReference.doc(userUid).delete();
      await statisticCollection.collectionReference.doc(userUid).delete();
    } catch (e) {
      print('---DeleteUserRepo e = ${e}');
    }
  }
}
