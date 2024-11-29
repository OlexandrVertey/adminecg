import 'package:adminecg/admin_ecg_app.dart';
import 'package:adminecg/common/di/app_dependency_provider.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runAppWithInjectedDependencies(app: const MyApp());
}
