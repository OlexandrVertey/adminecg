import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:adminecg/ui/diagnosis_topics/diagnosis_topics_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiagnosisTopicsModule extends StatelessWidget {
  const DiagnosisTopicsModule({super.key});

  @override
  Widget build(BuildContext context) {
    DiagnosisRepo diagnosisRepo = context.read<DiagnosisRepo>();
    TopicRepo topicRepo = context.read<TopicRepo>();
    return DiagnosisTopicsPage(
      diagnosisRepo: diagnosisRepo,
      topicRepo: topicRepo,
    );
  }
}
