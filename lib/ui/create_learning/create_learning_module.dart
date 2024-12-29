import 'package:adminecg/common/models/learning/learning_model.dart';
import 'package:adminecg/common/repo/add_diagnose_to_storage_repo/add_diagnose_to_storage_repo.dart';
import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/learning/learning_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:adminecg/ui/create_learning/create_learning_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateLearningModule extends StatelessWidget {
  const CreateLearningModule({
    super.key,
    required this.success,
    this.learningModel,
    required this.parentContext,
  });

  final Function() success;
  final BuildContext parentContext;
  final LearningModel? learningModel;

  @override
  Widget build(BuildContext context) {
    DiagnosisRepo diagnosisRepo = context.read<DiagnosisRepo>();
    TopicRepo topicRepo = context.read<TopicRepo>();
    LearningRepo learningRepo = context.read<LearningRepo>();
    AddDiagnoseToStorageRepo storageRepo = context.read<AddDiagnoseToStorageRepo>();
    return CreateLearningPage(
      diagnosisRepo: diagnosisRepo,
      topicRepo: topicRepo,
      learningRepo: learningRepo,
      storageRepo: storageRepo,
      success: success,
      learningModel: learningModel,
    );
  }
}
