import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/learning/learning_model.dart';
import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/learning/learning_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
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
    required this.parentContext,
    this.learningModel,
  });

  final DiagnosisRepo diagnosisRepo;
  final TopicRepo topicRepo;
  final LearningRepo learningRepo;
  final Function() success;
  final LearningModel? learningModel;
  final BuildContext parentContext;

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

  double maxColumnWidth = 360;

  final yourScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Scrollbar(
              thumbVisibility: true,
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  color: Colors.transparent,
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    constraints: const BoxConstraints(maxWidth: 380),
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(26.0)),
                      border: Border.all(
                          color: const Color(0xffD9D9D9), width: 1.3),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    width: 380,
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
            const Divider(),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  constraints: const BoxConstraints(maxWidth: 380),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(26.0)),
                    border:
                        Border.all(color: const Color(0xffD9D9D9), width: 1.3),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Content Preview",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: ReorderableListView(
                          onReorder: _onReorder,
                          children: contentWidget(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(25),
              constraints: const BoxConstraints(maxWidth: 380),
              margin: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(26.0)),
                border: Border.all(color: const Color(0xffD9D9D9), width: 1.3),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              width: 380,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Add Image Element",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          width: 360,
                          text: 'Get Image',
                          isActive: false,
                          onTap: () async {
                            var file = await AppImagePicker.getImage();
                            if (file != null) {
                              setState(() {
                                list.add(ElementModel(
                                    uint8list: file,
                                    type: ElementType.local));
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: SizedBox.shrink(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Add Text Element",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 370,
                    height: 150,
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyLarge,

                      controller: textController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.1),
                              width: 1.3,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.1),
                              width: 1.3,
                            ),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          hintText: 'Enter text',
                          contentPadding: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 18,
                            bottom: 18,
                          ),
                          counterText: '',
                        ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    width: 360,
                    text: 'Save and add',
                    isActive: true,
                    onTap: () {
                      if(textController.text.isNotEmpty){
                        setState(() {
                          list.add(
                            ElementModel(
                                text: textController.text,
                                type: ElementType.text),
                          );
                        });
                      }
                      textController.clear();
                    },
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    width: 360,
                    text: 'clear',
                    isActive: false,
                    onTap: () => textController.clear(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });
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
          item(Text(element.text ?? ''), '$index'),
        );
      }
      if (element.type == ElementType.local) {
        list.add(
          item(Image.memory(element.uint8list!), '$index'),
        );
      }
      if (element.type == ElementType.image) {
        list.add(
          item(Image.network(element.text!), '$index'),
        );
      }
    }
    return list;
  }

  Widget item(Widget widget, String key) {
    return Container(
      key: Key(key),
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      child: widget,
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