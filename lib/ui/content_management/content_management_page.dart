import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/event/event_model.dart';
import 'package:adminecg/common/models/learning/learning_model.dart';
import 'package:adminecg/common/repo/event/event_repo.dart';
import 'package:adminecg/common/repo/learning/learning_repo.dart';
import 'package:adminecg/ui/widgets/add_event_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  List<Widget> listEvent = [];
  List<Widget> listLearning = [];

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
      listEvent.add(
        EventItemWidget(
          model: model,
          edit: () {
            context.openEventDialog(() => setEventOnScreen(), event: model);
          },
          remove: () async {
            await widget.eventRepo
                .remove(model)
                .then((_) => setEventOnScreen());
          },
        ),
      );
    }
    setState(() {});
  }

  void setLearningOnScreen() {
    listLearning.clear();
    for (var model in widget.learningRepo.list) {
      listLearning.add(
        LearningItemWidget(
          model: model,
          edit: () {
            context.openLearningDialog(() => setLearningOnScreen(), learningModel: model);
          },
          remove: () async {
            await widget.learningRepo
                .remove(model)
                .then((_) => setLearningOnScreen());
          },
        ),
      );
    }
    setState(() {});
  }

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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AddEventWidget(
            title: 'Practice Mode',
            textButton: 'Question',
            onTap: () => context.openEventDialog(() => setEventOnScreen()),
          ),
          Wrap(
            children: listEvent,
          ),
          AddEventWidget(
            title: 'Learning mode',
            textButton: 'Topic',
            onTap: () => context.openLearningDialog(() => setLearningOnScreen()),
          ),
          Wrap(
            children: listLearning,
          ),
        ],
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
    return SizedBox(
      width: 200,
      height: 90,
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              width: 200,
              imageUrl: model.image,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Row(
            children: [
              Text('data'),
              Spacer(),
              InkWell(
                onTap: edit,
                child: SvgPicture.asset(
                  width: 20,
                  height: 20,
                  "assets/images/svg/edit.svg",
                ),
              ),
              SizedBox(
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
          )
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
  });

  final LearningModel model;
  final Function() edit;
  final Function() remove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 90,
      child: Column(
        children: [
          Row(
            children: [
              Text(model.id),
              Spacer(),
              InkWell(
                onTap: edit,
                child: SvgPicture.asset(
                  width: 20,
                  height: 20,
                  "assets/images/svg/edit.svg",
                ),
              ),
              SizedBox(
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
          )
        ],
      ),
    );
  }
}
