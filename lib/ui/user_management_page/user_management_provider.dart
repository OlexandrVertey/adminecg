import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/organization_model/organization_model.dart';
import 'package:adminecg/common/models/user_model/user_model.dart';
import 'package:adminecg/common/repo/delete_organization_repo/delete_organization_repo.dart';
import 'package:adminecg/common/repo/delete_user_repo/delete_user_repo.dart';
import 'package:adminecg/common/repo/get_all_organizations_repo/get_all_organizations_repo.dart';
import 'package:adminecg/common/repo/get_all_users_repo/get_all_users_repo.dart';
import 'package:adminecg/common/repo/get_user_repo/get_user_repo.dart';
import 'package:adminecg/common/repo/register_repo/register_repo.dart';
import 'package:adminecg/common/repo/set_organization_repo/set_organization_repo.dart';
import 'package:adminecg/common/repo/set_user_repo/set_user_repo.dart';
import 'package:adminecg/common/repo/update_organization_repo/update_organization_repo.dart';
import 'package:adminecg/common/repo/update_user_repo/update_user_repo.dart';
import 'package:adminecg/common/shared_preference/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserManagementProvider extends ChangeNotifier {
  UserManagementProvider({
    required this.sharedPreference,
    required this.setUserRepo,
    required this.setOrganizationRepo,
    required this.getUserRepo,
    required this.updateUserRepo,
    required this.updateOrganizationRepo,
    required this.getAllUsersRepo,
    required this.getAllOrganizationsRepo,
    required this.deleteUserRepo,
    required this.deleteOrganizationRepo,
    required this.registerRepo,
  }){
    getUserModel();
  }

  final SharedPreference sharedPreference;
  final SetUserRepo setUserRepo;
  final SetOrganizationRepo setOrganizationRepo;
  final GetUserRepo getUserRepo;
  final UpdateUserRepo updateUserRepo;
  final UpdateOrganizationRepo updateOrganizationRepo;
  final GetAllUsersRepo getAllUsersRepo;
  final GetAllOrganizationsRepo getAllOrganizationsRepo;
  final DeleteUserRepo deleteUserRepo;
  final DeleteOrganizationRepo deleteOrganizationRepo;
  final RegisterRepo registerRepo;


  UserManagementState state = UserManagementState();

  void updatePage() {
    notifyListeners();
  }

  void getUserModel() async {
    print('---getUserModel 1');
    try {
      state.listUserModel = await getAllUsersRepo.getAllUsers();
      state.listOrganizationModel = await getAllOrganizationsRepo.getAllOrganizations();
      print('---getUserModel 2 = ${state.listOrganizationModel.length}');
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

  void deleteOrganization({required BuildContext context, required String id}) async {
    try {
      await deleteOrganizationRepo.deleteOrganization(id: id);
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
    String? organisation,
  }) async {
    print('organisation $organisation');
    try {
      await updateUserRepo.updateUser(
        userUid: userUid,
        fullName: fullName,
        email: email,
        password: password,
        organisation: organisation,
      );
      getUserModel();
    } catch (e) {}
    notifyListeners();
    context.backPage();
  }

  void updateOrganization({
    required BuildContext context,
    required String id,
    required String name,
    required String premium,
  }) async {
    try {
      print('---updateOrganization 1');
      await updateOrganizationRepo.updateOrganization(
        id: id,
        name: name,
        premium: premium,
      );
      print('---updateOrganization 2');
      getUserModel();
    } catch (e) {
      print('---updateOrganization 3 = ${e}');
    }
    notifyListeners();
    context.backPage();
  }

  Future<void> registerUser({
    required BuildContext context,
    required String userName,
    required String email,
    required String password,
    String? organisation,
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
          organisation: organisation,
          registerData: DateTime.now().toString(),
        );
        print('---RegisterProvider register 5 userCredential.user!.uid = ${userCredential.user!.uid}');
        getUserModel();
      }
    } catch (e) {
      print('---MainManagementProvider registerUser catch = ${e}');
    }
    context.backPage();
  }

  Future<void> registerOrganization({
    required BuildContext context,
    required String id,
    required String name,
    required String premium,
  }) async {
    try {
      print('---registerOrganization register 1');

        print('---registerOrganization register 2');
        await setOrganizationRepo.setOrganization(
          id: id,
          name: name,
          premium: premium,
        );
        print('---registerOrganization 3');
        getUserModel();
    } catch (e) {
      print('---registerOrganization catch = ${e}');
    }
    context.backPage();
  }
}

class UserManagementState {
  List<UserModel> listUserModel = [];
  List<OrganizationModel> listOrganizationModel = [];
}
