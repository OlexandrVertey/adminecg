import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/event/event_repo.dart';
import 'package:adminecg/common/repo/learning/learning_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:adminecg/ui/content_management/content_management_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentManagementModule extends StatelessWidget {
  const ContentManagementModule({super.key});

  @override
  Widget build(BuildContext context) {
    EventRepo eventRepo = context.read<EventRepo>();
    LearningRepo learningRepo = context.read<LearningRepo>();
    TopicRepo topicRepo = context.read<TopicRepo>();
    DiagnosisRepo diagnosisRepo = context.read<DiagnosisRepo>();
    return ContentManagementPage(
      learningRepo: learningRepo,
      eventRepo: eventRepo,
      topicRepo: topicRepo,
      diagnosisRepo: diagnosisRepo,
    );
  }
}
