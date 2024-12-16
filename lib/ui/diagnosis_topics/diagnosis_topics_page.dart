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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Card(
            child: Column(
              children: [
                AddEventWidget(
                  title: 'Diagnosis',
                  textButton: 'Diagnos',
                  onTap: () {
                    EnterDialog.show(context, 'title', (en, he) {
                      widget.diagnosisRepo.add(en, he).then((_)=> setState(() {}));
                    });
                  },
                ),
                Expanded(
                  child: widget.diagnosisRepo.list.isEmpty ? _empty() : _diagnosisList(),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Card(
            child: Column(
              children: [
                AddEventWidget(
                  title: 'Topics',
                  textButton: 'Topic',
                  onTap: () {
                    EnterDialog.show(context, 'title', (en, he) {
                      widget.topicRepo.add(en, he).then((_)=> setState(() {}));
                    });
                  },
                ),
                Expanded(
                  child: widget.topicRepo.list.isEmpty ? _empty() : _topicList(),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }

  Widget _topicList(){
    return ListView.builder(
      itemCount: widget.topicRepo.list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(widget.topicRepo.list[index].titleEn),
        );
      },
    );
  }

  Widget _diagnosisList(){
    return ListView.builder(
      itemCount: widget.topicRepo.list.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(widget.topicRepo.list[index].titleEn),
        );
      },
    );
  }

  Widget _empty(){
    return Center(
      child: Text('Empty'),
    );
  }
}