import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/event/event_model.dart';
import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/event/event_repo.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
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
  late List<String> ids;

  String? image;
  late final TextEditingController textController;
  String correctAnswer = '-1';
  String answerA = '-1';
  String answerB = '-1';
  String answerC = '-1';
  String answerD = '-1';
  bool isPremium = false;

  @override
  void initState() {
    ids = widget.diagnosisRepo.ids();
    textController = TextEditingController(text: widget.eventModel?.text);
    if (widget.eventModel != null) {
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
        constraints: BoxConstraints(maxWidth: 350),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'title',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 16),
            _dropDown(correctAnswer, ids, (value) {
              setState(() {
                correctAnswer = value;
              });
            }),
            const SizedBox(height: 16),
            Text(
              'Image',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 28),
            ),
            Card(
              child: SizedBox(
                width: 360,
                height: 100,
                child: Container(
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Answers',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 10),
            _dropDown(answerA, ids, (value) {
              setState(() {
                answerA = value;
              });
            }),
            const SizedBox(height: 16),
            _dropDown(answerB, ids, (value) {
              setState(() {
                answerB = value;
              });
            }),
            const SizedBox(height: 16),
            _dropDown(answerC, ids, (value) {
              setState(() {
                answerC = value;
              });
            }),
            const SizedBox(height: 16),
            _dropDown(answerD, ids, (value) {
              setState(() {
                answerD = value;
              });
            }),
            const SizedBox(height: 30),
            _premium(),
            const SizedBox(height: 10),
            AppButton(
              width: 370,
              text: widget.eventModel != null
                  ? 'Update Question'
                  : 'Add New Question',
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

  Widget _premium() {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            width: 370,
            text: 'Free',
            isActive: isPremium == false,
            onTap: () => setState(() => isPremium = false),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppButton(
            width: 370,
            text: 'Premium',
            isActive: isPremium == true,
            onTap: () => setState(() => isPremium = true),
          ),
        ),
      ],
    );
  }

  Widget _dropDown(
    String value,
    List<String> values,
    Function(String newValue) onChanged,
  ) {
    return DropdownButton(
      value: value,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: values.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(widget.diagnosisRepo.value(items, 'locale')),
        );
      }).toList(),
      onChanged: (e) {
        if (e != null) {
          onChanged(e);
        }
      },
    );
  }
}
