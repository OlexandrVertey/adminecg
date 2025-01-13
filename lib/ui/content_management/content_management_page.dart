import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/event/event_model.dart';
import 'package:adminecg/common/models/learning/learning_model.dart';
import 'package:adminecg/common/models/topic/topic_model.dart';
import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/event/event_repo.dart';
import 'package:adminecg/common/repo/learning/learning_repo.dart';
import 'package:adminecg/common/repo/topic/topic_repo.dart';
import 'package:adminecg/ui/widgets/app_button_add.dart';
import 'package:adminecg/ui/widgets/select_dialog_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ContentManagementPage extends StatefulWidget {
  const ContentManagementPage({
    super.key,
    required this.eventRepo,
    required this.learningRepo,
    required this.topicRepo,
    required this.diagnosisRepo,
  });

  final EventRepo eventRepo;
  final LearningRepo learningRepo;
  final TopicRepo topicRepo;
  final DiagnosisRepo diagnosisRepo;

  @override
  State<ContentManagementPage> createState() => _ContentManagementPageState();
}

class _ContentManagementPageState extends State<ContentManagementPage> {
  List<Widget> listEvent = [];
  List<Widget> listLearning = [];

  bool isShowEventOnly = false;
  bool isShowLearningOnly = false;

  Future<void> fetchEvent() async {
    widget.eventRepo.getList().then((_) {
      setEventOnScreen();
    });
  }

  Future<void> fetchLearning() async {
    widget.learningRepo.getList().then((_) {
      setLearningOnScreen();
    });
  }

  void setEventOnScreen() {
    listEvent.clear();
    for (var model in widget.eventRepo.list) {
      if (selectedDiagnose == null) {
        addEvent(model);
      } else {
        if (selectedDiagnose == model.correctAnswer) {
          addEvent(model);
        }
      }
    }
    setState(() {});
  }

  void addEvent(EventModel model) {
    listEvent.add(
      EventItemWidget(
        model: model,
        edit: () {
          context.openEventDialog(() => setEventOnScreen(), event: model);
        },
        remove: () async {
          await widget.eventRepo.remove(model).then((_) => setEventOnScreen());
        },
      ),
    );
  }

  void setLearningOnScreen() {
    listLearning.clear();
    List<TopicModel> copy = List.of(widget.topicRepo.list);
    // List<TopicModel> firstThree = [];
    // if(isShowLearningOnly == true ){
    //   firstThree = copy;
    // } else {
    //   firstThree = copy.length >= 3 ? copy.sublist(0, 3) : copy;
    // }
    for (var topic in copy) {
      if (selectedTopic == null) {
        addLearning(topic);
      } else {
        if (topic.id == selectedTopic) {
          addLearning(topic);
        }
      }
    }
    setState(() {});
  }

  void addLearning(TopicModel topic) {
    print('topict start = ${topic.titleEn}');
    List<LearningModel> list = [];
    for (var learn in widget.learningRepo.list) {
      print('topict for  ${learn.categoryId} == ${topic.id}');
      if (learn.categoryId == topic.id) {
        print('topict ADD ${learn.categoryId} == ${topic.id}\n---');
        list.add(learn);
      }
    }
    if (list.isNotEmpty) {
      print('topict not Empty List = ${topic.titleEn}\n---');
      listLearning.add(Row(
        children: [
          Text(widget.topicRepo.value(topic.id, 'locale')),
          const Expanded(child: SizedBox.shrink())
        ],
      ));
      List<Widget> exList = [];
      for (var model in list) {
        exList.add(LearningItemWidget(
          diagnosisRepo: widget.diagnosisRepo,
          model: model,
          edit: () {
            context.openLearningDialog(() => setLearningOnScreen(),
                learningModel: model);
          },
          remove: () async {
            await widget.learningRepo
                .remove(model)
                .then((_) => setLearningOnScreen());
          },
        ));
      }
      listLearning.add(ExtendedWrap(
        maxLines: 1,
        children: exList,
      ));
    }
  }

  List<String> _idsTopics = [];
  List<String> _idsDiagnose = [];
  String? selectedTopic;
  String? selectedDiagnose;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchEvent();
      fetchLearning();
    });
  }

  @override
  Widget build(BuildContext context) {
    _idsTopics = widget.topicRepo.ids();
    _idsDiagnose = widget.diagnosisRepo.ids();
    return Expanded(
      child: Container(
        height: double.maxFinite,
        padding: const EdgeInsets.all(25),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if(isShowLearningOnly == false)Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 200),
                    child: SelectDialogWidget(
                      title: 'Select diagnosis',
                      items: _idsDiagnose,
                      diagnosisRepo: widget.diagnosisRepo,
                      onSelect: (selected) {
                        selectedDiagnose = selected;
                        if (selected == '-1') {
                          selectedDiagnose = null;
                        }
                        setEventOnScreen();
                      },
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    child: Text(
                      'Practice Mode',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 22),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Row(
                      children: [
                        AppButtonAdd(
                          text: 'Add New Question',
                          onTap: () =>
                              context.openEventDialog(() => setEventOnScreen()),
                        ),
                        if(isShowEventOnly == true)const SizedBox(width: 16,),
                        if(isShowEventOnly == true)AppButtonAdd(
                          text: '+',
                          onTap: () {
                            setState(() {
                              isShowEventOnly = !isShowEventOnly;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              if(isShowLearningOnly == false)const SizedBox(height: 20),
              if(isShowLearningOnly == false)Row(
                children: [
                  Expanded(
                    child: ExtendedWrap(
                      maxLines: isShowEventOnly ? listEvent.length : 1,
                      children: listEvent,
                    ),
                  ),
                  if (listEvent.isNotEmpty && isShowEventOnly == false && isShowLearningOnly == false)
                    InkWell(
                      onTap: () {
                        isShowEventOnly = !isShowEventOnly;
                        setEventOnScreen();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff99ABC6).withOpacity(0.1),
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
                        ),
                        width: 40,
                        height: 130,
                        alignment: Alignment.center,
                        child: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey,),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              if(isShowEventOnly == false)Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 200),
                    child: SelectDialogWidget(
                      title: 'Select Topic',
                      items: _idsTopics,
                      topicRepo: widget.topicRepo,
                      onSelect: (selected) {
                        selectedTopic = selected;
                        if (selected == '-1') {
                          selectedTopic = null;
                        }
                        setLearningOnScreen();
                      },
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    child: Text(
                      'Learning Mode',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 22),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppButtonAdd(
                          text: 'Add New Topic',
                          onTap: () =>
                              context.openLearningDialog(() => setLearningOnScreen()),
                        ),
                        if(isShowLearningOnly == true)const SizedBox(width: 16,),
                        if(isShowLearningOnly == true)AppButtonAdd(
                          text: '+',
                          onTap: () {
                            setState(() {
                              isShowLearningOnly = !isShowLearningOnly;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              if(isShowEventOnly == false)const SizedBox(height: 20),
              if(isShowEventOnly == false)Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ExtendedWrap(
                      maxLines: isShowLearningOnly ? listLearning.length : 6,
                      children: listLearning,
                    ),
                  ),
                  if (listLearning.isNotEmpty && isShowEventOnly == false && isShowLearningOnly == false)
                    InkWell(
                      onTap: () {
                        isShowLearningOnly = !isShowLearningOnly;
                        setLearningOnScreen();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff99ABC6).withOpacity(0.1),
                          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                          border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
                        ),
                        width: 40,
                        height: 130,
                        alignment: Alignment.center,
                        child: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey,),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventItemWidget extends StatelessWidget {
  const EventItemWidget({
    super.key,
    required this.model,
    required this.edit,
    required this.remove,
  });

  final EventModel model;
  final Function() edit;
  final Function() remove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xff99ABC6).withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
      ),
      width: 230,
      height: 130,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
              child: CachedNetworkImage(
                width: 200,
                imageUrl: model.image,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(height: 13),
          Row(
            children: [
              Text(
                context
                    .read<DiagnosisRepo>()
                    .value(model.correctAnswer, 'locale'),
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontSize: 14),
              ),
              const Spacer(),
              InkWell(
                onTap: edit,
                child: SvgPicture.asset(
                  width: 20,
                  height: 20,
                  "assets/images/svg/edit.svg",
                ),
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: remove,
                child: SvgPicture.asset(
                  width: 20,
                  height: 20,
                  "assets/images/svg/delete.svg",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LearningItemWidget extends StatelessWidget {
  const LearningItemWidget({
    super.key,
    required this.model,
    required this.edit,
    required this.remove,
    required this.diagnosisRepo,
  });

  final DiagnosisRepo diagnosisRepo;
  final LearningModel model;
  final Function() edit;
  final Function() remove;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xff99ABC6).withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
      ),
      width: 200,
      height: 120,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                diagnosisRepo.value(model.diagnoseId, 'locale'),
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 14),
              ),
              const Spacer(),
              InkWell(
                onTap: edit,
                child: SvgPicture.asset(
                  width: 20,
                  height: 20,
                  "assets/images/svg/edit.svg",
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              InkWell(
                onTap: remove,
                child: SvgPicture.asset(
                  width: 20,
                  height: 20,
                  "assets/images/svg/delete.svg",
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,'),
        ],
      ),
    );
  }
}
