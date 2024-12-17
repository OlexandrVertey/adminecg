import 'package:adminecg/common/firebase_collections/firebase_collections.dart';
import 'package:adminecg/common/firebase_storage/firebase_storage.dart';
import 'package:adminecg/common/repo/delete_user_repo/delete_user_repo.dart';
import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/event/event_repo.dart';
import 'package:adminecg/common/repo/get_all_users_repo/get_all_users_repo.dart';
import 'package:adminecg/common/repo/get_user_repo/get_user_repo.dart';
import 'package:adminecg/common/repo/learning/learning_repo.dart';
import 'package:adminecg/common/repo/register_repo/register_repo.dart';
import 'package:adminecg/common/repo/set_user_repo/set_user_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:adminecg/common/repo/update_user_repo/update_user_repo.dart';
import 'package:adminecg/common/shared_preference/shared_preference.dart';
import 'package:adminecg/ui/diagnosis_topics/diagnosis_topics_provider.dart';
import 'package:adminecg/ui/login_page/login_page_provider.dart';
import 'package:adminecg/ui/main_app/locale_provider.dart';
import 'package:adminecg/ui/user_management_page/user_management_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void runAppWithInjectedDependencies({required Widget app}) async {
  final sharedPreference = await SharedPreferences.getInstance();
  final FirebaseAuth auth = FirebaseAuth.instance;
  runApp(
    CollectionsDependenciesProvider(
      sharedPreference: sharedPreference,
      auth: auth,
      child: app,
    ),
  );
}

class CollectionsDependenciesProvider extends MultiProvider {
  CollectionsDependenciesProvider({
    super.key,
    required SharedPreferences sharedPreference,
    required Widget child,
    required FirebaseAuth auth,
  }) : super(providers: [
    Provider<SharedPreference>(create: (context) => SharedPreference(sharedPreference)),
    Provider<DiagnoseStorage>(create: (context) => DiagnoseStorage()),
    Provider<UsersCollection>(create: (context) => UsersCollection()),
    Provider<TopicCollection>(create: (context) => TopicCollection()),
    Provider<DiagnosisCollection>(create: (context) => DiagnosisCollection()),
    Provider<EventCollection>(create: (context) => EventCollection()),
    Provider<LearningCollection>(create: (context) => LearningCollection()),
  ],
    child: RepoDependenciesProvider(
      auth: auth,
      child: child,
    ),
  );
}

class RepoDependenciesProvider extends MultiProvider {
  RepoDependenciesProvider({
    super.key,
    required Widget child,
    required FirebaseAuth auth,
  }) : super(providers: [
    Provider<RegisterRepo>(create: (context) => RegisterRepo(auth: auth)),
    Provider<SetUserRepo>(create: (context) => SetUserRepo(usersCollection: context.read<UsersCollection>())),
    Provider<GetUserRepo>(create: (context) => GetUserRepo(usersCollection: context.read<UsersCollection>())),
    Provider<UpdateUserRepo>(create: (context) => UpdateUserRepo(usersCollection: context.read<UsersCollection>())),
    Provider<GetAllUsersRepo>(create: (context) => GetAllUsersRepo(usersCollection: context.read<UsersCollection>())),
    Provider<DeleteUserRepo>(create: (context) => DeleteUserRepo(usersCollection: context.read<UsersCollection>())),
    Provider<DiagnosisRepo>(create: (context) => DiagnosisRepo(diagnosisCollection: context.read<DiagnosisCollection>())),
    Provider<TopicRepo>(create: (context) => TopicRepo(topicCollection: context.read<TopicCollection>())),
    Provider<EventRepo>(create: (context) => EventRepo(context.read<EventCollection>())),
    Provider<LearningRepo>(create: (context) => LearningRepo(context.read<LearningCollection>())),
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
        ChangeNotifierProvider(create: (_) => DiagnosisTopicsProvider(
            diagnosisRepo: context.read<DiagnosisRepo>(),
            topicRepo: context.read<TopicRepo>(),
          ),
        ),
        ChangeNotifierProvider(create: (_) => UserManagementProvider(
            sharedPreference: context.read<SharedPreference>(),
            setUserRepo: context.read<SetUserRepo>(),
            getUserRepo: context.read<GetUserRepo>(),
            updateUserRepo: context.read<UpdateUserRepo>(),
            getAllUsersRepo: context.read<GetAllUsersRepo>(),
            deleteUserRepo: context.read<DeleteUserRepo>(),
            registerRepo: context.read<RegisterRepo>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
