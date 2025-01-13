import 'package:adminecg/common/models/event/event_model.dart';
import 'package:adminecg/common/models/learning/learning_model.dart';
import 'package:adminecg/ui/create_event/create_event_module.dart';
import 'package:adminecg/ui/create_learning/create_learning_module.dart';
import 'package:adminecg/ui/main_management_page/main_management_page.dart';
import 'package:flutter/material.dart';

extension ExtensionString on BuildContext {
  backPage() => Navigator.pop(this);

  openMainManagementPage() => Navigator.push(this,
      MaterialPageRoute(builder: (context) => const MainManagementPage()));

  openEventDialog(Function() success, {EventModel? event}) => showDialog(
        context: this,
        builder: (_) => CreateEventModule(
          eventModel: event,
          success: success,
        ),
      );

  // openLearningDialog(Function() success, {LearningModel? learningModel}) => Navigator.push(this, MaterialPageRoute(builder: (context) =>  CreateLearningModule(
  //   learningModel: learningModel,
  //   success: success,
  //   parentContext: this,
  // )));

  openLearningDialog(Function() success, {LearningModel? learningModel}) =>
      Navigator.push(
        this,
        PageRouteBuilder(
          opaque: false, // set to false
          pageBuilder: (_, __, ___) => CreateLearningModule(
            learningModel: learningModel,
            success: success,
            parentContext: this,
          ),
        ),
      );
}
