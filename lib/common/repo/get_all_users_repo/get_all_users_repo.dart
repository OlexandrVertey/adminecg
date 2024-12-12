import 'package:adminecg/common/firebase_collections/firebase_collections.dart';
import 'package:adminecg/common/models/user_model/user_model.dart';

class GetAllUsersRepo {
  GetAllUsersRepo({required this.usersCollection});

  final UsersCollection usersCollection;

  Future<List<UserModel>?> getAllUsers() async {
    try {
      await usersCollection.collectionReference
          // .where('countryName', isEqualTo: countryName)
          // .where('id', isNotEqualTo: userUid)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          print('---GetUserRepo 1 = ${value.docs.map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>)).first.userUid}');
          return value.docs.map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>)).toList();
          // return UserModel.fromJson(value.docs as Map<String, dynamic>);
        } else {
          print('---getAllUsers 2');
          return null;
        }
      });
    } catch (e) {
      print('---GetUserRepo 3 e = ${e}');
    }
    return null;
  }
}
