import 'package:adminecg/common/extensions/lang_extension/s_extension.dart';
import 'package:adminecg/common/extensions/lang_extension/s_keys.dart';
import 'package:adminecg/ui/main_app/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});


  @override
  State<MainApp> createState() => _EcgAppState();
}

class _EcgAppState extends State<MainApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Main Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.s(appLocale),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => context.read<LocaleProvider>().setLocale(const Locale('en', '')),
                  child: Container(
                    color: Colors.green,
                    width: 200,
                    height: 100,
                    child: const Text('EN'),
                  ),
                ),
                InkWell(
                  onTap: () => context.read<LocaleProvider>().setLocale(const Locale('he', '')),
                  child: Container(
                    color: Colors.blue,
                    width: 200,
                    height: 100,
                    child: const Text('HE'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}