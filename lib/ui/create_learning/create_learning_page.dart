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
  final ScrollController _scrollController = ScrollController();
  late List<String> idsDiagnose;
  late List<String> idsTopics;

  String categoryId = '-1';
  String diagnoseId = '-1';
  bool isPremium = false;
  List<ElementModel> list = [];
  String selectedIcon = '-1';

  @override
  void initState() {
    idsDiagnose = widget.diagnosisRepo.ids();
    idsTopics = widget.topicRepo.ids();
    if (widget.learningModel != null) {
      categoryId = widget.learningModel!.categoryId;
      diagnoseId = widget.learningModel!.diagnoseId;
      isPremium = widget.learningModel!.isPremium;
      selectedIcon = widget.learningModel!.selectedIcon;
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
        child: Scrollbar(
          thumbVisibility: true,
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        child: IconButton(
                          onPressed: () {
                            Toast.show(message: 'In progress');
                            // EnterDialog.show(context: context, title: 'Add Text', callBack: (en, he){
                            //   setState(() {
                            //     list.add(ElementModel(he: he, en: en, type: ElementType.text));
                            //   });
                            // });
                          },
                          icon: const Icon(Icons.add_comment_rounded,
                              color: Colors.grey),
                        ),
                      ),
                      Card(
                        child: IconButton(
                          onPressed: () {
                            Toast.show(message: 'In progress');
                          },
                          icon: const Icon(
                            Icons.add_photo_alternate,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
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
                        onSelect: (item) => categoryId = item,
                        currentValue: categoryId,
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
                        onSelect: (item) => diagnoseId = item,
                        currentValue: diagnoseId,
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CategoryIconWidget( onChange: (e){selectedIcon = e;}, currentIcon: selectedIcon,),
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
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Content",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 12),
                      contentWidget(),
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
                  )
                ],
              ),
            ),
          ),
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

  Widget contentWidget() {
    List<Widget> list = [];
    this.list.forEach((e) {
      list.add(Text(e.en));
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: list,
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

    if (selectedIcon == '-1') {
      Toast.show(message: 'Select Icon');
      return;
    }
    setModel();
  }

  void setModel() async {
    var model = LearningModel(
      id: widget.learningModel?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      categoryId: categoryId,
      diagnoseId: diagnoseId,
      isPremium: isPremium,
      selectedIcon: selectedIcon,
      list: list,
    );
    if (widget.learningModel != null) {
      await widget.learningRepo.edit(model).then((_) => finish());
    } else {
      await widget.learningRepo.add(model).then((_) => finish());
    }
  }

  void finish() {
    context.backPage();
    widget.success();
    Toast.show(message: 'Done');
  }
}
