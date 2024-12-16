import 'package:adminecg/common/models/event/event_model.dart';
import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/event/event_repo.dart';
import 'package:adminecg/ui/event/create_event_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEventModule extends StatelessWidget {
  const CreateEventModule({super.key, this.eventModel, required this.success});

  final Function() success;
  final EventModel? eventModel;

  @override
  Widget build(BuildContext context) {
    DiagnosisRepo diagnosisRepo = context.read<DiagnosisRepo>();
    EventRepo eventRepo = context.read<EventRepo>();
    return CreateEventPage(
      diagnosisRepo: diagnosisRepo,
      eventRepo: eventRepo,
      eventModel: eventModel,
      success: success,
    );
  }
}
