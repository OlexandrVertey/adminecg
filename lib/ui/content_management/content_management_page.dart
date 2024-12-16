import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/repo/event/event_repo.dart';
import 'package:adminecg/common/repo/learning/learning_repo.dart';
import 'package:adminecg/ui/widgets/add_event_widget.dart';
import 'package:flutter/material.dart';

class ContentManagementPage extends StatefulWidget {
  const ContentManagementPage({
    super.key,
    required this.eventRepo,
    required this.learningRepo,
  });

  final EventRepo eventRepo;
  final LearningRepo learningRepo;

  @override
  State<ContentManagementPage> createState() => _ContentManagementPageState();
}

class _ContentManagementPageState extends State<ContentManagementPage> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          // AddEventWidget(
          //   title: 'Practice Mode',
          //   textButton: 'Question',
          //   onTap: () => context.openEventDialog(() => setState(() {})),
          // ),
          SizedBox(
            height: 100,
            child: Placeholder(),
          ),
          // AddEventWidget(
          //   title: 'Learning mode',
          //   textButton: 'Topic',
          //   onTap: () {},
          // ),
          SizedBox(
            height: 100,
            child: Placeholder(),
          ),
        ],
      ),
    );
  }
}
