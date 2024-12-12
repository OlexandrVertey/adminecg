import 'package:adminecg/common/firebase_collections/firebase_collections.dart';
import 'package:adminecg/common/models/user_model/user_model.dart';

class GetUserRepo {
  GetUserRepo({required this.usersCollection});

  final UsersCollection usersCollection;

  Future<UserModel?> getUser({
    required String userUid,
  }) async {
    try {
      print('---GetUserRepo try userUid = ${userUid}');
      var userModel = await usersCollection.collectionReference.doc(userUid).get();
      print('---GetUserRepo try userModel = ${userModel.data()}');
      return UserModel.fromJson(userModel.data() as Map<String, dynamic>);
    } catch (e) {
      print('---GetUserRepo e = ${e}');
    }
    return null;
  }
}
