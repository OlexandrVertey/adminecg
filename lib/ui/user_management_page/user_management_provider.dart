import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/user_model/user_model.dart';
import 'package:adminecg/common/repo/delete_user_repo/delete_user_repo.dart';
import 'package:adminecg/common/repo/get_all_users_repo/get_all_users_repo.dart';
import 'package:adminecg/common/repo/get_user_repo/get_user_repo.dart';
import 'package:adminecg/common/repo/register_repo/register_repo.dart';
import 'package:adminecg/common/repo/set_user_repo/set_user_repo.dart';
import 'package:adminecg/common/repo/update_user_repo/update_user_repo.dart';
import 'package:adminecg/common/shared_preference/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    required this.registerRepo,
  }){
    getUserModel();
  }

  final SharedPreference sharedPreference;
  final SetUserRepo setUserRepo;
  final GetUserRepo getUserRepo;
  final UpdateUserRepo updateUserRepo;
  final GetAllUsersRepo getAllUsersRepo;
  final DeleteUserRepo deleteUserRepo;
  final RegisterRepo registerRepo;


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

  void deleteUser({required BuildContext context, required String userUid}) async {
    try {
      await deleteUserRepo.deleteUser(userUid: userUid);
      getUserModel();
    } catch (e) {}
    context.backPage();
  }

  void updateUser({
    required BuildContext context,
    required String userUid,
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      await updateUserRepo.updateUser(
        userUid: userUid,
        fullName: fullName,
        email: email,
        password: password,
      );
      getUserModel();
    } catch (e) {}
    notifyListeners();
    context.backPage();
  }

  Future<void> registerUser({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential? userCredential = await registerRepo.registerUser(
        userName: userName,
        email: email,
        password: password,
      );
      print('---RegisterProvider register 3 userCredential = ${userCredential}');
      if (userCredential != null) {
        print('---RegisterProvider register 4');
        await setUserRepo.setUser(
          userUid: userCredential.user!.uid,
          fullName: userName,
          email: email,
          password: password,
        );
        print('---RegisterProvider register 5 userCredential.user!.uid = ${userCredential.user!.uid}');
        getUserModel();
      }
    } catch (e) {
      print('---MainManagementProvider registerUser catch = ${e}');
    }
    context.backPage();
  }
}

class UserManagementState {
  List<UserModel> listUserModel = [];
}
