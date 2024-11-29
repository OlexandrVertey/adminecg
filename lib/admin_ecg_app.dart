import 'package:adminecg/common/extensions/lang_extension/app_localizations.dart';
import 'package:adminecg/ui/main_app/locale_provider.dart';
import 'package:adminecg/ui/main_app/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          title: 'ECG',
          locale: value.appLocale,
          supportedLocales: const [
            Locale('en', ''),
            Locale('he', ''),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MainApp(),
        );
      },
    );
  }
}