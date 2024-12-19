import 'package:adminecg/common/models/event/event_model.dart';
import 'package:adminecg/ui/create_event/create_event_module.dart';
import 'package:adminecg/ui/main_management_page/main_management_page.dart';
import 'package:flutter/material.dart';

extension ExtensionString on BuildContext {
  backPage() => Navigator.pop(this);

  openMainManagementPage() => Navigator.push(this, MaterialPageRoute(builder: (context) => const MainManagementPage()));
  openEventDialog(Function() success, {EventModel? event}) => showDialog(
    context: this,
    builder: (_) => CreateEventModule(
      eventModel: event,
      success: success,
    ),
  );

}
