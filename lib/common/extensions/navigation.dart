import 'package:adminecg/ui/main_management_page/main_management_page.dart';
import 'package:flutter/material.dart';

extension ExtensionString on BuildContext {
  backPage() => Navigator.pop(this);

  openMainManagementPage() => Navigator.push(this, MaterialPageRoute(builder: (context) => const MainManagementPage()));

}
