import 'package:adminecg/common/extensions/lang_extension/app_localizations.dart';
import 'package:flutter/material.dart';

extension ExtensionString on BuildContext {
  String s(String key) => AppLocalizations.of(this)!.translate(key)!;
}