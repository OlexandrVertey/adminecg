import 'package:adminecg/common/firebase_collections/firebase_collections.dart';
import 'package:adminecg/common/repo/delete_user_repo/delete_user_repo.dart';
import 'package:adminecg/common/repo/get_all_users_repo/get_all_users_repo.dart';
import 'package:adminecg/common/repo/get_user_repo/get_user_repo.dart';
import 'package:adminecg/common/repo/set_user_repo/set_user_repo.dart';
import 'package:adminecg/common/repo/update_user_repo/update_user_repo.dart';
import 'package:adminecg/common/shared_preference/shared_preference.dart';
import 'package:adminecg/ui/login_page/login_page_provider.dart';
import 'package:adminecg/ui/main_app/locale_provider.dart';
import 'package:adminecg/ui/user_management_page/user_management_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void runAppWithInjectedDependencies({required Widget app}) async {
  final sharedPreference = await SharedPreferences.getInstance();
  runApp(
    CollectionsDependenciesProvider(
      sharedPreference: sharedPreference,
      child: app,
    ),
  );
}

class CollectionsDependenciesProvider extends MultiProvider {
  CollectionsDependenciesProvider({
    super.key,
    required SharedPreferences sharedPreference,
    required Widget child,
  }) : super(providers: [
    Provider<SharedPreference>(create: (context) => SharedPreference(sharedPreference)),
    Provider<UsersCollection>(create: (context) => UsersCollection()),
  ],
    child: RepoDependenciesProvider(
      child: child,
    ),
  );
}

class RepoDependenciesProvider extends MultiProvider {
  RepoDependenciesProvider({
    super.key,
    required Widget child,
  }) : super(providers: [
    Provider<SetUserRepo>(create: (context) => SetUserRepo(usersCollection: context.read<UsersCollection>())),
    Provider<GetUserRepo>(create: (context) => GetUserRepo(usersCollection: context.read<UsersCollection>())),
    Provider<UpdateUserRepo>(create: (context) => UpdateUserRepo(usersCollection: context.read<UsersCollection>())),
    Provider<GetAllUsersRepo>(create: (context) => GetAllUsersRepo(usersCollection: context.read<UsersCollection>())),
    Provider<DeleteUserRepo>(create: (context) => DeleteUserRepo(usersCollection: context.read<UsersCollection>())),
  ],
    child: BlocDependenciesProvider(child: child),
  );
}

class BlocDependenciesProvider extends StatelessWidget {
  const BlocDependenciesProvider({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => LoginPageProvider(sharedPreference: context.read<SharedPreference>())),
        ChangeNotifierProvider(create: (_) => UserManagementProvider(
            sharedPreference: context.read<SharedPreference>(),
            setUserRepo: context.read<SetUserRepo>(),
            getUserRepo: context.read<GetUserRepo>(),
            updateUserRepo: context.read<UpdateUserRepo>(),
            getAllUsersRepo: context.read<GetAllUsersRepo>(),
            deleteUserRepo: context.read<DeleteUserRepo>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
