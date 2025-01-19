import 'package:adminecg/common/extensions/lang_extension/app_localizations.dart';
import 'package:adminecg/common/theme/app_theme.dart';
import 'package:adminecg/ui/login_page/login_page.dart';
import 'package:adminecg/ui/main_app/locale_provider.dart';
import 'package:adminecg/ui/main_management_page/main_management_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, value, child) {
        final botToastBuilder = BotToastInit();
        return MaterialApp(
          title: 'ECG',
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            child = botToastBuilder(context, child);
            return child;
          },
          locale: value.appLocale,
          supportedLocales: const [
            Locale('en', ''),
            // Locale('he', ''),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          navigatorObservers: [BotToastNavigatorObserver()],
          theme: AppTheme.light(),
          home: LoginPage(),
          // home: const MainManagementPage(),

          // home: const MainManagementPage(),///TODO: need change
        );
      },
    );
  }
}
