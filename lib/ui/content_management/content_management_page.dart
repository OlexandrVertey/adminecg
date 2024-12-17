import 'dart:typed_data';

import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/event/event_model.dart';
import 'package:adminecg/common/repo/event/event_repo.dart';
import 'package:adminecg/common/repo/learning/learning_repo.dart';
import 'package:adminecg/ui/widgets/add_event_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
    EventRepo repo = context.read<EventRepo>();
    repo.getList().then((_) {
      setEventOnScreen();
    });
  }

  void setEventOnScreen() {
    listEvent.clear();
    EventRepo repo = context.read<EventRepo>();
    for (var model in repo.list) {
      listEvent.add(
        EventItemWidget(
          model: model,
          edit: () {
            context.openEventDialog(() => setEventOnScreen(), event: model);
          },
          remove: () {
            context
                .read<EventRepo>()
                .remove(model)
                .then((_) => setEventOnScreen());
          },
        ),
      );
    }
    setState(() {});
  }

  Future<void> fetchLearning() async {
    listLearning.clear();
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
            onTap: () => context.openEventDialog(() => setState(() {})),
          ),
          Wrap(
            children: listEvent,
          ),
          AddEventWidget(
            title: 'Learning mode',
            textButton: 'Topic',
            onTap: () {},
          ),
          Wrap(
            children: listLearning,
          ),
        ],
      ),
    );
  }
}

class EventItemWidget extends StatefulWidget {
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
  State<EventItemWidget> createState() => _EventItemWidgetState();
}

class _EventItemWidgetState extends State<EventItemWidget> {

  Uint8List? image;

  @override
  void initState() {
    super.initState();
    _loadImageUrl();
  }

  Future<void> _loadImageUrl() async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child('diagnose').child(widget.model.image);
      Uint8List? downloadedImage = await ref.getData();
      if(downloadedImage != null){
        setState(() {
          image = downloadedImage;
        });
      }
    } catch (e) {
      print('Error retrieving image URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 90,
      child: Column(
        children: [
          Expanded(
            child: image != null ? Image.memory(image!) : Center(child: Text('data')),
          ),
          Row(
            children: [
              Text('data'),
              Spacer(),
              InkWell(
                onTap: widget.edit,
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
                onTap: widget.remove,
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
