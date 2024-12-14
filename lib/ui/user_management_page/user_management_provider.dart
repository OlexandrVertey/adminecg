import 'package:adminecg/common/models/user_model/user_model.dart';
import 'package:adminecg/common/repo/delete_user_repo/delete_user_repo.dart';
import 'package:adminecg/common/repo/get_all_users_repo/get_all_users_repo.dart';
import 'package:adminecg/common/repo/get_user_repo/get_user_repo.dart';
import 'package:adminecg/common/repo/set_user_repo/set_user_repo.dart';
import 'package:adminecg/common/repo/update_user_repo/update_user_repo.dart';
import 'package:adminecg/common/shared_preference/shared_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserManagementProvider extends ChangeNotifier {
  UserManagementProvider({
    required this.sharedPreference,
    required this.setUserRepo,
    required this.getUserRepo,
    required this.updateUserRepo,
    required this.getAllUsersRepo,
    required this.deleteUserRepo,
  }){
    getUserModel();
  }

  final SharedPreference sharedPreference;
  final SetUserRepo setUserRepo;
  final GetUserRepo getUserRepo;
  final UpdateUserRepo updateUserRepo;
  final GetAllUsersRepo getAllUsersRepo;
  final DeleteUserRepo deleteUserRepo;


  UserManagementState state = UserManagementState();

  void updatePage() {
    notifyListeners();
  }

  void getUserModel() async {
    try {
      state.listUserModel = await getAllUsersRepo.getAllUsers();
    } catch (e) {}
    notifyListeners();
  }

  void deleteUser({required String userUid}) async {
    try {
      await deleteUserRepo.deleteUser(userUid: userUid);
      getUserModel();
    } catch (e) {}
  }

  void updateUser({required String userUid, required String fullName, required String email}) async {
    print('---Provider updateUser 1 userUid = ${userUid}');
    print('---Provider updateUser 2 fullName = ${fullName}');
    print('---Provider updateUser 3 email = ${email}');
    try {
      await updateUserRepo.updateUser(
        userUid: userUid,
        fullName: fullName,
        email: email,
      );
      print('---Provider updateUser 4');
      getUserModel();
      print('---Provider updateUser 5');
    } catch (e) {}
    notifyListeners();
  }

}

class UserManagementState {
  List<UserModel> listUserModel = [];
}
