import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/organization_model/organization_model.dart';
import 'package:adminecg/common/models/user_model/user_model.dart';
import 'package:adminecg/common/repo/delete_organization_repo/delete_organization_repo.dart';
import 'package:adminecg/common/repo/delete_user_repo/delete_user_repo.dart';
import 'package:adminecg/common/repo/get_all_organizations_repo/get_all_organizations_repo.dart';
import 'package:adminecg/common/repo/get_all_users_repo/get_all_users_repo.dart';
import 'package:adminecg/common/repo/get_user_repo/get_user_repo.dart';
import 'package:adminecg/common/repo/register_repo/register_repo.dart';
import 'package:adminecg/common/repo/removed_users_repo/removed_users_repo.dart';
import 'package:adminecg/common/repo/set_organization_repo/set_organization_repo.dart';
import 'package:adminecg/common/repo/set_user_repo/set_user_repo.dart';
import 'package:adminecg/common/repo/update_organization_repo/update_organization_repo.dart';
import 'package:adminecg/common/repo/update_user_repo/update_user_repo.dart';
import 'package:adminecg/common/shared_preference/shared_preference.dart';
import 'package:adminecg/ui/widgets/toast.dart';
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
    required this.removedUsersRepo,
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
  final RemovedUsersRepo removedUsersRepo;


  UserManagementState state = UserManagementState();

  RegExp passwordValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  RegExp emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  void updatePage() {
    notifyListeners();
  }

  void getUserModel() async {
    try {
      state.listUserModel = await getAllUsersRepo.getAllUsers();
      state.listOrganizationModel = await getAllOrganizationsRepo.getAllOrganizations();
    } catch (e) {}
    notifyListeners();
  }

  void deleteUser({
    required BuildContext context,
    required String userUid,
    required String userEmail,
    required String userName,
  }) async {
    try {
      await deleteUserRepo.deleteUser(userUid: userUid);

      await removedUsersRepo.setRemovedUser(
        userUid: userUid,
        userName: userName,
        email: userEmail,
      );

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
    required String states,
    required String duration,
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
        states: states,
        duration: duration,
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
    required String states,
    required String duration,//endPlans
    String? organisation,
  }) async {
    bool hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    bool hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    bool hasDigit = RegExp(r'\d').hasMatch(password);
    bool hasSpecialChar = RegExp(r'[!@#\$&*~]').hasMatch(password);
    try {
      if (!emailValid.hasMatch(email)) {
        Toast.show(message: 'Invalid email');
      }
      if (!passwordValid.hasMatch(password)) {
        if (!hasUppercase) {
          Toast.show(context: context, message: 'Missing a capital letter.');
        }
        if (!hasLowercase) {
          Toast.show(context: context, message: 'A small letter is missing.');
        }
        if (!hasDigit) {
          Toast.show(context: context, message: 'The number is missing.');
        }
        if (!hasSpecialChar) {
          Toast.show(context: context, message: 'A special character is missing.');
        }
        if (password.length < 8) {
          Toast.show(context: context, message: 'The password is too short.');
        }
      }
      if (userName.length < 3) {
        Toast.show(message: 'Invalid user Name');
      }


      if (emailValid.hasMatch(email) && passwordValid.hasMatch(password) && userName.length > 3) {
        print('---emailValid.hasMatch(email) && passwordValid.hasMatch(password) && userName.length > 3');
        UserCredential? userCredential = await registerRepo.registerUser(
          email: email,
          password: password,
        );


        // sendEmail(email);
        // final emailUri = Uri.parse('mailto:$email?subject=test test test');
        // await launchUrl(emailUri);

        print('---RegisterProvider register 3 userCredential = ${userCredential}');
        if (userCredential != null) {
          print('---RegisterProvider register 4');
          DateTime now = DateTime.now();
          await setUserRepo.setUser(
            userUid: userCredential.user!.uid,
            fullName: userName,
            email: email,
            password: password,
            organisation: organisation,
            registerData: now.toString(),
            states: states,
            endPlans: duration.isNotEmpty ? duration : DateTime(now.year, now.month, now.day + 7, now.minute, now.second).toString(),
          );
          print('---RegisterProvider register 5 userCredential.user!.uid = ${userCredential.user!.uid}');
          getUserModel();
        }
        // launchEmail(toEmail: email, subject: 'subject', message: 'message');
        context.backPage();
        Toast.show(message: 'User added');
      }
    } catch (e) {
      Toast.show(message: 'User not added');
      print('---MainManagementProvider registerUser catch = ${e}');
    }
  }

  ///Send Grid
  // Future launchEmail({
  //   required String toEmail,
  //   required String subject,
  //   required String message,
  // }) async {
  //   print('---launchEmail 1');
  //   final url =
  //       'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
  //   if (await canLaunch(url)) {
  //     print('---launchEmail 2');
  //     await launch(url);
  //   }
  //   print('---launchEmail 3');
  // }
  //
  // void sendEmail(String emailAddress) async {
  //   print('--- sendEmail 1');
  //   final Email email = Email(
  //     body: 'Hello World',
  //     subject: 'Testing email on flutter',
  //     recipients: [emailAddress],
  //     //cc: ['cc@example.com'],
  //     //bcc: ['bcc@example.com'],
  //     //attachmentPaths: ['/path/to/attachment.zip'],
  //     isHTML: false,
  //   );
  // }


  Future<void> registerOrganization({
    required BuildContext context,
    required String id,
    required String name,
    required String premium,
  }) async {
    try {
        await setOrganizationRepo.setOrganization(
          id: id,
          name: name,
          premium: premium,
        );
        getUserModel();
    } catch (e) {
      print('---register Organization e = ${e}');
    }
    context.backPage();
  }

  Future<void> sortUser({
    required UserSort sort,
  }) async {
    try {
      switch (sort) {
        case UserSort.name:
          if(state.userSort == UserSort.name){
            state.isUserRec = !state.isUserRec;
          } else {
            state.userSort = UserSort.name;
            state.isUserRec = false;
          }
          state.listUserModel.sort((a, b) {
            int comparison = a.fullName!.compareTo(b.fullName!);
            return state.isUserRec ? comparison : -comparison;
          });
          break;
        case UserSort.email:
          if(state.userSort == UserSort.email){
            state.isUserRec = !state.isUserRec;
          } else {
            state.userSort = UserSort.email;
            state.isUserRec = false;
          }
          state.listUserModel.sort((a, b) {
            int comparison = a.email!.compareTo(b.email!);
            return state.isUserRec ? comparison : -comparison;
          });
          break;
        case UserSort.organisation:
          if(state.userSort == UserSort.organisation){
            state.isUserRec = !state.isUserRec;
          } else {
            state.userSort = UserSort.organisation;
            state.isUserRec = false;
          }
          state.listUserModel.sort((a, b) {
            int comparison = a.organisation!.compareTo(b.organisation!);
            return state.isUserRec ? comparison : -comparison;
          });
          break;
        case UserSort.status:
          if(state.userSort == UserSort.status){
            state.isUserRec = !state.isUserRec;
          } else {
            state.userSort = UserSort.status;
            state.isUserRec = false;
          }
          state.listUserModel.sort((a, b) {
            int comparison = a.fullName!.compareTo(b.fullName!);
            return state.isUserRec ? comparison : -comparison;
          });
          break;
        case UserSort.terms:
          if(state.userSort == UserSort.terms){
            state.isUserRec = !state.isUserRec;
          } else {
            state.userSort = UserSort.terms;
            state.isUserRec = false;
          }
          state.listUserModel.sort((a, b) {
            int comparison = a.userRegisterDate!.compareTo(b.userRegisterDate!);
            return state.isUserRec ? comparison : -comparison;
          });
          break;
        default:
          break;
      }
    } catch (e) {}
    notifyListeners();
  }

  Future<void> sortOrg({
    required OrgSort sort,
  }) async {
    try {
      switch (sort) {
        case OrgSort.name:
          if(state.orgSort == OrgSort.name){
            state.isOrgRec = !state.isOrgRec;
          } else {
            state.orgSort = OrgSort.name;
            state.isOrgRec = false;
          }
          state.listOrganizationModel.sort((a, b) {
            int comparison = a.name!.compareTo(b.name!);
            return state.isOrgRec ? comparison : -comparison;
          });
          break;
        default:
          break;
      }
    } catch (e) {}
    notifyListeners();
  }

}

class UserManagementState {
  List<UserModel> listUserModel = [];
  List<OrganizationModel> listOrganizationModel = [];
  UserSort userSort = UserSort.all;
  bool isUserRec = false;
  OrgSort orgSort = OrgSort.all;
  bool isOrgRec = false;
}

enum UserSort{
  all, number, name, email, organisation, status, terms
}

enum OrgSort{
  all, number, name
}
