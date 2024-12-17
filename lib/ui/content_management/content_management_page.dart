import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/event/event_model.dart';
import 'package:adminecg/common/repo/event/event_repo.dart';
import 'package:adminecg/common/repo/learning/learning_repo.dart';
import 'package:adminecg/ui/widgets/add_event_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
              imageUrl: model.image,
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
