import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/learning/learning_model.dart';
import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/learning/learning_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
import 'package:adminecg/ui/widgets/category_icon_widget.dart';
import 'package:adminecg/ui/widgets/select_dialog_widget.dart';
import 'package:adminecg/ui/widgets/toast.dart';
import 'package:flutter/material.dart';

class CreateLearningPage extends StatefulWidget {
  const CreateLearningPage({
    super.key,
    required this.diagnosisRepo,
    required this.topicRepo,
    required this.learningRepo,
    required this.success,
    this.learningModel,
  });

  final DiagnosisRepo diagnosisRepo;
  final TopicRepo topicRepo;
  final LearningRepo learningRepo;
  final Function() success;
  final LearningModel? learningModel;

  @override
  State<CreateLearningPage> createState() => _CreateLearningPageState();
}

class _CreateLearningPageState extends State<CreateLearningPage> {
  late List<String> idsDiagnose;
  late List<String> idsTopics;

  String categoryId = '-1';
  String diagnoseId = '-1';
  bool isPremium = false;


  @override
  void initState() {
    idsDiagnose = widget.diagnosisRepo.ids();
    idsTopics = widget.topicRepo.ids();
    if (widget.learningModel != null) {
      categoryId = widget.learningModel!.categoryId;
      diagnoseId = widget.learningModel!.diagnoseId;
      isPremium = widget.learningModel!.isPremium;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26.0),
      ),
      content: Container(
        constraints: const BoxConstraints(maxWidth: 380),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
              child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select Category",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 14, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 12),
                SelectDialogWidget(
                  title: '',
                  items: idsTopics,
                  topicRepo: widget.topicRepo,
                  // onSelect: (item) => correctAnswer = item,
                  // currentValue: correctAnswer,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select Diagnosis",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 14, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 12),
                SelectDialogWidget(
                  title: '',
                  items: idsDiagnose,
                  diagnosisRepo: widget.diagnosisRepo,
                  // onSelect: (item) => correctAnswer = item,
                  // currentValue: correctAnswer,
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Select Icon",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 14, color: Colors.black),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: CategoryIconWidget(),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Premium/Free",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontSize: 14, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 12),
                _premium(),
                const SizedBox(height: 30),
                AppButton(
                  width: 360,
                  text: widget.learningModel != null
                      ? 'Update Lesson'
                      : 'Add New Lesson',
                  isActive: true,
                  onTap: () => done(),
                ),
                const SizedBox(height: 20),
                AppButton(
                  width: 360,
                  text: 'Back',
                  isActive: false,
                  onTap: () => context.backPage(),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget _premium() {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            width: 360,
            text: 'Free',
            isActive: isPremium == false,
            onTap: () => setState(() => isPremium = false),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppButton(
            width: 360,
            text: 'Premium',
            isActive: isPremium == true,
            onTap: () => setState(() => isPremium = true),
          ),
        ),
      ],
    );
  }

  Future<void> done() async {
    if (categoryId == '-1') {
      Toast.show(message: 'Select category');
      return;
    }

    if (diagnoseId == '-1') {
      Toast.show(message: 'Select diagnosis');
      return;
    }
  }

  // void setModel(String downloadImageUri) async {
  //   var model = EventModel(
  //     id: widget.eventModel?.id ??
  //         DateTime.now().millisecondsSinceEpoch.toString(),
  //     image: downloadImageUri,
  //     text: textController.text,
  //     correctAnswer: correctAnswer,
  //     answerA: answerA,
  //     answerB: answerB,
  //     answerC: answerC,
  //     answerD: answerD,
  //     isPremium: isPremium,
  //   );
  //   if (widget.eventModel != null) {
  //     await widget.eventRepo.edit(model).then((_) => finish());
  //   } else {
  //     await widget.eventRepo.add(model).then((_) => finish());
  //   }
  // }

  // void finish() {
  //   context.backPage();
  //   widget.success();
  //   Toast.show(message: 'Done');
  // }
}
