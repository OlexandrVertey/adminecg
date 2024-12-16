import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/event/event_model.dart';
import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/event/event_repo.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
import 'package:adminecg/ui/widgets/select_dialog_widget.dart';
import 'package:flutter/material.dart';

class CreateEventPage extends StatefulWidget {
  const CreateEventPage({
    super.key,
    required this.diagnosisRepo,
    required this.eventRepo,
    required this.success,
    this.eventModel,
  });

  final DiagnosisRepo diagnosisRepo;
  final EventRepo eventRepo;
  final Function() success;
  final EventModel? eventModel;

  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {

  String? image;
  late final TextEditingController textController;
  String? correctAnswer;
  String? answerA;
  String? answerB;
  String? answerC;
  String? answerD;
  bool isPremium = false;

  @override
  void initState() {
    textController = TextEditingController(text: widget.eventModel?.text);
    if(widget.eventModel != null){
      correctAnswer = widget.eventModel!.correctAnswer;
      answerA = widget.eventModel!.answerA;
      answerB = widget.eventModel!.answerB;
      answerC = widget.eventModel!.answerC;
      answerD = widget.eventModel!.answerD;
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
        constraints: BoxConstraints(
          maxWidth: 350
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'title',
              // textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Name",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontSize: 14, color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Email",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontSize: 14, color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Password",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontSize: 14, color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Organization",
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontSize: 14, color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            const SelectDialogWidget(),
            const SizedBox(height: 30),
            _premium(),
            const SizedBox(height: 10),
            AppButton(
              width: 370,
              text: widget.eventModel != null ? 'Update Question' : 'Add New Question',
              isActive: true,
              // onTap: () => context.read<UserManagementProvider>().deleteUser(userUid: userUid),
              onTap: () {},
            ),
            const SizedBox(height: 10),
            AppButton(
              width: 370,
              text: 'Back',
              isActive: false,
              onTap: () => context.backPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _premium(){
    return Row(
      children: [
        Expanded(
          child: AppButton(
            width: 370,
            text: 'Free',
            isActive: true,
            // onTap: () => context.read<UserManagementProvider>().deleteUser(userUid: userUid),
            onTap: () {},
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppButton(
            width: 370,
            text: 'Premium',
            isActive: false,
            onTap: () => context.backPage(),
          ),
        ),
      ],
    );
  }
}