import 'package:adminecg/ui/main_app/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void runAppWithInjectedDependencies({required Widget app}) async {
  // final sharedPreference = await SharedPreferences.getInstance();
  runApp(
      BlocDependenciesProvider(
    // BaseDependenciesProvider(
      // sharedPreference: sharedPreference,
      child: app,
    ),
  );
}

// class BaseDependenciesProvider extends MultiProvider {
//   BaseDependenciesProvider({
//     super.key,
//     // required SharedPreferences sharedPreference,
//     required Widget child,
//   }) : super(providers: [
//       // Provider<SharedPreferences>.value(value: sharedPreference),
//       // Provider<DioClient>(create: (context) => DioClient()),
//     ],
//     child: DataDependenciesProvider(
//       // sharedPreference: sharedPreference,
//       child: child,
//     ),
//   );
// }

// class DataDependenciesProvider extends MultiProvider {
//   DataDependenciesProvider({
//     super.key,
//     // required SharedPreferences sharedPreference,
//     required Widget child,
//   }) : super(providers: [
//       // Provider<SharedPreference>(create: (context) => SharedPreference(sharedPreference)),
//       // Provider<LoginApi>(create: (context) => LoginApiImpl(dioClient: context.read<DioClient>())),
//     ],
//     child: BlocDependenciesProvider(child: child),
//   );
// }

class BlocDependenciesProvider extends StatelessWidget {
  const BlocDependenciesProvider({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: child,
    );
  }
}
