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
    widget.eventRepo.getList().then((_) {
      setEventOnScreen();
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
            await widget.eventRepo.remove(model).then((_) => setEventOnScreen());
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

  // String? image;

  @override
  void initState() {
    super.initState();
    // _loadImageUrl();
  }

  // Future<void> _loadImageUrl() async {
  //   print('Load Image ${widget.model.image}');
  //
  //   try {
  //     Reference ref = FirebaseStorage.instance.ref().child('diagnose').child(widget.model.image);
  //     String? downloadedUrl = await ref.getDownloadURL();
  //     setState(() {
  //       image = downloadedUrl;
  //     });
  //   } catch (e) {
  //     print('Load Image error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 90,
      child: Column(
        children: [
          Expanded(
            child: widget.model.image != null ? CachedNetworkImage(
              width: 200,
              imageUrl: widget.model.image,
              fit: BoxFit.cover,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ) : Center(child: Text('data')),
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
