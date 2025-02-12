import 'package:adminecg/common/firebase_collections/firebase_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeleteUserRepo {
  DeleteUserRepo({required this.usersCollection, required this.statisticCollection});

  final UsersCollection usersCollection;
  final StatisticCollection statisticCollection;



  Future<void> deleteUser({
    required String userUid,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      if (user.user != null) {
        await FirebaseAuth.instance.currentUser!.delete();
      }
      await usersCollection.collectionReference.doc(userUid).delete();
      await statisticCollection.collectionReference.doc(userUid).delete();
    } catch (e) {
      print('---DeleteUserRepo e = ${e}');
    }
  }
}
