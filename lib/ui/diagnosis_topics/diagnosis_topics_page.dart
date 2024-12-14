import 'package:adminecg/ui/widgets/add_event_widget.dart';
import 'package:flutter/material.dart';

class DiagnosisTopicsPage extends StatelessWidget {
  const DiagnosisTopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AddEventWidget(
            title: 'Practice Mode',
            textButton: 'Question',
            onTap: () {},
          ),
          SizedBox(
            height: 100,
            child: Placeholder(),
          ),
          AddEventWidget(
            title: 'Learning mode',
            textButton: 'Topic',
            onTap: () {},
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
