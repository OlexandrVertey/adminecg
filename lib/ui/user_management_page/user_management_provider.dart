import 'package:adminecg/common/models/user_model/user_model.dart';
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
  }){
    getUserModel();
  }

  final SharedPreference sharedPreference;
  final SetUserRepo setUserRepo;
  final GetUserRepo getUserRepo;
  final UpdateUserRepo updateUserRepo;
  final GetAllUsersRepo getAllUsersRepo;


  UserManagementState state = UserManagementState();

  void updatePage() {
    notifyListeners();
  }

  void getUserModel() async {
    print('---UserManagementProvider getUserModel 1');
    try {
      print('---UserManagementProvider getUserModel 2');
      List<UserModel>? listUserModel = await getAllUsersRepo.getAllUsers();
      print('---UserManagementProvider getUserModel 33 = ${listUserModel?[0].userUid}');
      print('---UserManagementProvider getUserModel 34 = ${listUserModel?[1].userUid}');
      print('---UserManagementProvider getUserModel 35 = ${listUserModel?[2].userUid}');
    } catch (e) {
      print('---UserManagementProvider getUserModel catch = ${e}');
    }
    notifyListeners();
  }

}

class UserManagementState {
  // List<UserModel>? listUserModel;
}
