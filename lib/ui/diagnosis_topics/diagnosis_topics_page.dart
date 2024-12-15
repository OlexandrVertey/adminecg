import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:adminecg/ui/dialog/enter_dialog.dart';
import 'package:adminecg/ui/widgets/add_event_widget.dart';
import 'package:flutter/material.dart';

class DiagnosisTopicsPage extends StatefulWidget {
  const DiagnosisTopicsPage({
    super.key,
    required this.diagnosisRepo,
    required this.topicRepo,
  });

  final DiagnosisRepo diagnosisRepo;
  final TopicRepo topicRepo;

  @override
  State<DiagnosisTopicsPage> createState() => _DiagnosisTopicsPageState();
}

class _DiagnosisTopicsPageState extends State<DiagnosisTopicsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AddEventWidget(
            title: 'Diagnosis',
            textButton: 'Diagnos',
            onTap: () {
              EnterDialog.show(context, 'title', (value) {});
            },
          ),
          SizedBox(
            height: 100,
            child: Placeholder(),
          ),
          AddEventWidget(
            title: 'Topics',
            textButton: 'Topic',
            onTap: () {
              EnterDialog.show(context, 'title', (value) {});
            },
          ),
          SizedBox(
            height: 100,
            child: Placeholder(),
          ),
        ],
      ),
    );
  }
}
