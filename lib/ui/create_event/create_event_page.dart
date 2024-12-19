import 'dart:typed_data';

import 'package:adminecg/admin_ecg_app.dart';
import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/event/event_model.dart';
import 'package:adminecg/common/repo/add_diagnose_to_storage_repo/add_diagnose_to_storage_repo.dart';
import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/event/event_repo.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
import 'package:adminecg/ui/widgets/image_compressor.dart';
import 'package:adminecg/ui/widgets/image_picker.dart';
import 'package:adminecg/ui/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  String? currentImage;
  Uint8List? newImage;
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
      contentPadding: EdgeInsets.all(35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26.0),
      ),
      content: Container(
        constraints: BoxConstraints(maxWidth: 380),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
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
                  InkWell(
                    onTap: () async {
                      var a = await AppImagePicker.getImage();
                      if(a != null){
                        setState(() {
                          newImage = a;
                        });
                      }
                    },
                    child: Card(
                      child: SizedBox(
                        width: 360,
                        height: 150,
                        child: _image(),
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
                    width: 360,
                    text: widget.eventModel != null
                        ? 'Update Question'
                        : 'Add New Question',
                    isActive: true,
                    // onTap: () => context.read<UserManagementProvider>().deleteUser(userUid: userUid),
                    onTap: () => done(),
                  ),
                  const SizedBox(height: 10),
                  AppButton(
                    width: 360,
                    text: 'Back',
                    isActive: false,
                    onTap: () => context.backPage(),
                  ),
                ],
              ),
            )
          ),
        ),
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

  Widget _image(){
    if(newImage != null){
      return Image.memory(newImage!, fit: BoxFit.cover,);
    }
    return Container();
  }

  Future<void> done() async {
    if (correctAnswer == '-1') {
      Toast.show(message: 'Select diagnosis');
      return;
    }
    if (answerA == '-1' ||
        answerB == '-1' ||
        answerC == '-1' ||
        answerD == '-1') {
      Toast.show(message: 'Select all answers');
      return;
    }

    if (answerA == answerB ||
        answerA == answerC ||
        answerA == answerD ||
        answerB == answerC ||
        answerB == answerD ||
        answerC == answerD) {
      Toast.show(message: 'Answers do not must repeat');
      return;
    }

    if (correctAnswer != answerA &&
        correctAnswer != answerB &&
        correctAnswer != answerC &&
        correctAnswer != answerD) {
      Toast.show(message: 'Answers must have correct answer');
      return;
    }

    if (currentImage == null && newImage == null) {
      Toast.show(message: 'Set Image please');
      return;
    }

    if(newImage != null){
      resizeAndCompressImage(newImage!, (image) async{
        String name = '${DateTime.now().millisecondsSinceEpoch.toString()}.png';
        await context.read<AddDiagnoseToStorageRepo>().addDiagnose(name: name, callBack: (uri){
          if(uri.isNotEmpty){
            setModel(uri);
          } else {
            Toast.show(message: 'Image error');
          }
        }, data: image);
      });
    }

    if(currentImage != null){
      setModel(currentImage!);
    }
  }

  void setModel(String downloadImageUri) async{
    var model = EventModel(
      id: widget.eventModel?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      image: downloadImageUri,
      text: textController.text,
      correctAnswer: correctAnswer,
      answerA: answerA,
      answerB: answerB,
      answerC: answerC,
      answerD: answerD,
      isPremium: isPremium,
    );
    if(widget.eventModel != null){
      await widget.eventRepo.edit(model).then((_) => finish());
    } else {
      await widget.eventRepo.add(model).then((_) => finish());
    }
  }

  void finish(){
    context.backPage();
    widget.success();
    Toast.show(message: 'Done');
  }
}
