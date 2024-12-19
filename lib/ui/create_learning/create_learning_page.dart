import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/learning/learning_model.dart';
import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/learning/learning_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
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

  late final TextEditingController titleEnController;
  late final TextEditingController titleHeController;
  late final TextEditingController descEnController;
  late final TextEditingController descHeController;

  @override
  void initState() {
    idsDiagnose = widget.diagnosisRepo.ids();
    titleEnController = TextEditingController(text: widget.learningModel?.titleEn);
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
      contentPadding: EdgeInsets.all(35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26.0),
      ),
      content: Container(
        constraints: BoxConstraints(maxWidth: 380),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
              child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Category',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 28),
                ),
                const SizedBox(height: 16),
                _dropDown(categoryId, idsTopics, (value) {
                  setState(() {
                    categoryId = value;
                  });
                }),
                const SizedBox(height: 16),
                Text(
                  'Diagnosis',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 28),
                ),
                _dropDown(categoryId, idsTopics, (value) {
                  setState(() {
                    categoryId = value;
                  });
                }),
                const SizedBox(height: 16),
                Text(
                  'Answers',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 28),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 30),
                _premium(),
                const SizedBox(height: 10),
                AppButton(
                  width: 360,
                  text: widget.learningModel != null
                      ? 'Update Question'
                      : 'Add New Question',
                  isActive: true,
                  // onTap: () => context.read<UserManagementProvider>().deleteUser(userUid: userUid),
                  onTap: () {
                  },
                  // onTap: () => done(),
                ),
                const SizedBox(height: 10),
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

  Widget _dropDown(
    String value,
    List<String> values,
    Function(String newValue) onChanged,
  ) {
    return DropdownButton(
      value: value,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: values.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(widget.diagnosisRepo.value(items, 'locale')),
        );
      }).toList(),
      onChanged: (e) {
        if (e != null) {
          onChanged(e);
        }
      },
    );
  }

  // Widget _image() {
  //   if (newImage != null) {
  //     return Image.memory(
  //       newImage!,
  //       fit: BoxFit.cover,
  //     );
  //   }
  //   return Container();
  // }
  //
  // Future<void> done() async {
  //   if (correctAnswer == '-1') {
  //     Toast.show(message: 'Select diagnosis');
  //     return;
  //   }
  //   if (answerA == '-1' ||
  //       answerB == '-1' ||
  //       answerC == '-1' ||
  //       answerD == '-1') {
  //     Toast.show(message: 'Select all answers');
  //     return;
  //   }
  //
  //   if (answerA == answerB ||
  //       answerA == answerC ||
  //       answerA == answerD ||
  //       answerB == answerC ||
  //       answerB == answerD ||
  //       answerC == answerD) {
  //     Toast.show(message: 'Answers do not must repeat');
  //     return;
  //   }
  //
  //   if (correctAnswer != answerA &&
  //       correctAnswer != answerB &&
  //       correctAnswer != answerC &&
  //       correctAnswer != answerD) {
  //     Toast.show(message: 'Answers must have correct answer');
  //     return;
  //   }
  //
  //   if (currentImage == null && newImage == null) {
  //     Toast.show(message: 'Set Image please');
  //     return;
  //   }
  //
  //   if (newImage != null) {
  //     resizeAndCompressImage(newImage!, (image) async {
  //       String name = '${DateTime.now().millisecondsSinceEpoch.toString()}.png';
  //       await context.read<AddDiagnoseToStorageRepo>().addDiagnose(
  //           name: name,
  //           callBack: (uri) {
  //             if (uri.isNotEmpty) {
  //               setModel(uri);
  //             } else {
  //               Toast.show(message: 'Image error');
  //             }
  //           },
  //           data: image);
  //     });
  //   }
  //
  //   if (currentImage != null) {
  //     setModel(currentImage!);
  //   }
  // }
  //
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
  //
  // void finish() {
  //   context.backPage();
  //   widget.success();
  //   Toast.show(message: 'Done');
  // }
}
