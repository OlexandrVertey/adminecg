import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/learning/learning_model.dart';
import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/learning/learning_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:adminecg/ui/create_learning/content_widget.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
import 'package:adminecg/ui/widgets/category_icon_widget.dart';
import 'package:adminecg/ui/widgets/image_picker.dart';
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
  late final TextEditingController textController = TextEditingController();
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

  double _getSize() {
    if (list.isNotEmpty) {
      return _isEnterTextOpen ? (maxColumnWidth * 3) : (maxColumnWidth * 2);
    } else {
      return _isEnterTextOpen ? (maxColumnWidth * 2) : (maxColumnWidth * 1);
    }
  }

  bool _isEnterTextOpen = false;
  double maxColumnWidth = 360;

  final yourScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
          ),
          Scrollbar(
            thumbVisibility: true,
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.topCenter,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 380),
                  margin: const EdgeInsets.only(right: 20),
                  width: 380,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Card(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isEnterTextOpen = !_isEnterTextOpen;
                                });
                              },
                              icon: const Icon(Icons.add_comment_rounded,
                                  color: Colors.grey),
                            ),
                          ),
                          Card(
                            child: IconButton(
                              onPressed: () async {
                                var file = await AppImagePicker.getImage();
                                if (file != null) {
                                  setState(() {
                                    list.add(ElementModel(
                                        uint8list: file,
                                        type: ElementType.local));
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.add_photo_alternate,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                        child: CategoryIconWidget(
                          onChange: (e) {
                            selectedIcon = e;
                          },
                          currentIcon: selectedIcon,
                        ),
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
                ),
              ),
            ),
          ),
          // Expanded(
          //   child: Container(
          //       child: Container(
          //     color: Colors.red,
          //     child: Column(
          //       children: [
          //         const Text('Content'),
          //         Expanded(
          //           child: ReorderableListView(
          //             // scrollController: scrollController,
          //             // shrinkWrap: true,
          //             onReorder: _onReorder,
          //             children: [
          //               for (int index = 0; index < list.length; index++)
          //                 Card(
          //                   key: Key('value$index'),
          //                   child: Container(
          //                     margin: const EdgeInsets.symmetric(
          //                         horizontal: 32, vertical: 12),
          //                     key: Key('value$index'),
          //                     height: 20,
          //                     child: list[index],
          //                   ),
          //                 ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   )),
          // ),
        ],
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

  List<Widget> contentWidget() {
    List<Widget> list = [];
    for (int index = 0; index < this.list.length; index++) {
      var element = this.list[index];
      if (element.type == ElementType.text) {
        list.add(
          Text(element.text ?? ''),
        );
      }
      if (element.type == ElementType.local) {
        list.add(
          Image.memory(element.uint8list!),
        );
      }
      if (element.type == ElementType.image) {
        list.add(
          Image.network(element.text!),
        );
      }
    }
    return list;
  }

  // Widget ms(Widget widget){}

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
