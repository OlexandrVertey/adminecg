import 'package:adminecg/common/firebase_collections/firebase_collections.dart';
import 'package:adminecg/common/models/user_model/user_model.dart';

class GetAllUsersRepo {
  GetAllUsersRepo({required this.usersCollection});

  final UsersCollection usersCollection;

  Future<List<UserModel>> getAllUsers() async {
    try {
      final users = await usersCollection.collectionReference.get();
      if (users.docs.isNotEmpty) {
        return users.docs.map((e) => UserModel.fromJson(e.data() as Map<String, dynamic>)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
