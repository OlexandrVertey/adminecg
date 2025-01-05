import 'dart:typed_data';
import 'package:adminecg/common/extensions/navigation.dart';
import 'package:adminecg/common/models/event/event_model.dart';
import 'package:adminecg/common/repo/add_diagnose_to_storage_repo/add_diagnose_to_storage_repo.dart';
import 'package:adminecg/common/repo/diagnosis/diagnosis_repo.dart';
import 'package:adminecg/common/repo/event/event_repo.dart';
import 'package:adminecg/common/theme/app_theme.dart';
import 'package:adminecg/ui/widgets/app_button.dart';
import 'package:adminecg/ui/widgets/image_compressor.dart';
import 'package:adminecg/ui/widgets/image_picker.dart';
import 'package:adminecg/ui/widgets/select_dialog_widget.dart';
import 'package:adminecg/ui/widgets/text_field_widget.dart';
import 'package:adminecg/ui/widgets/toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  final ScrollController _scrollController = ScrollController();
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
      isPremium = widget.eventModel!.isPremium;
      _downloadImage(widget.eventModel!.image);
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
        constraints: const BoxConstraints(maxWidth: 380),
        child: Scrollbar(
          thumbVisibility: true,
          controller: _scrollController,
          child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Correct Diagnosis",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontSize: 14, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SelectDialogWidget(
                      title: '',
                      items: ids,
                      diagnosisRepo: widget.diagnosisRepo,
                      onSelect: (item) => correctAnswer = item,
                      currentValue: correctAnswer,
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "ECG image",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontSize: 14, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0)),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.1), width: 1.3),
                          ),
                          width: 360,
                          height: 150,
                          child: _image(),
                        ),
                        Positioned(
                          bottom: 15,
                          right: 15,
                          child: InkWell(
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              var a = await AppImagePicker.getImage(size: 100);
                              if (a != null) {
                                setState(() {
                                  newImage = a;
                                });
                              }
                            },
                            child: SvgPicture.asset("assets/images/svg/plus.svg"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          "4 Answers",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontSize: 14, color: Colors.black),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: (){
                            if(correctAnswer == '-1'){
                              Toast.show(message: 'Select diagnosis');
                            } else {
                              List<String> copy = List.of(ids);
                              copy.remove(correctAnswer);
                              copy.shuffle();
                              List<String> result =  copy.take(3).toList();
                              result.add(correctAnswer);
                              result.shuffle();
                              setState(() {
                                answerA = result[0];
                                answerB = result[1];
                                answerC = result[2];
                                answerD = result[3];
                              });
                            }
                          },
                          child: Text(
                            "Random",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(fontSize: 14, color: AppTheme.actionColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SelectDialogWidget(
                      title: 'A.',
                      items: ids,
                      diagnosisRepo: widget.diagnosisRepo,
                      onSelect: (item) => answerA = item,
                      currentValue: answerA,
                    ),
                    const SizedBox(height: 12),
                    SelectDialogWidget(
                      title: 'B.',
                      items: ids,
                      diagnosisRepo: widget.diagnosisRepo,
                      onSelect: (item) => answerB = item,
                      currentValue: answerB,
                    ),
                    const SizedBox(height: 12),
                    SelectDialogWidget(
                      title: 'C.',
                      items: ids,
                      diagnosisRepo: widget.diagnosisRepo,
                      onSelect: (item) => answerC = item,
                      currentValue: answerC,
                    ),
                    const SizedBox(height: 12),
                    SelectDialogWidget(
                      title: 'D.',
                      items: ids,
                      diagnosisRepo: widget.diagnosisRepo,
                      onSelect: (item) => answerD = item,
                      currentValue: answerD,
                    ),
                    const SizedBox(height: 36),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Explain Text",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontSize: 14, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 370,
                      height: 150,
                      child: TextFieldWidget(
                        controllerText: textController,
                        hintTextField: '',
                        textInputType: TextInputType.text,
                        maxLines: 20,
                        callBackTextField: (text) {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Choose the type of question",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontSize: 14, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _premium(),
                    const SizedBox(height: 30),
                    AppButton(
                      width: 360,
                      text: widget.eventModel != null
                          ? 'Update Question'
                          : 'Add New Question',
                      isActive: true,
                      // onTap: () => context.read<UserManagementProvider>().deleteUser(userUid: userUid),
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
              )),
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

  Widget _image() {
    if (newImage != null) {
      return Image.memory(
        newImage!,
        fit: BoxFit.cover,
      );
    }
    return SvgPicture.asset("assets/images/svg/image.svg");
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

    if (newImage != null) {
      String name = '${DateTime.now().millisecondsSinceEpoch.toString()}.png';
      await context.read<AddDiagnoseToStorageRepo>().addDiagnose(
        name: name,
        callBack: (uri) {
          if (uri.isNotEmpty) {
            setModel(uri);
          } else {
            Toast.show(message: 'Image error');
          }
        },
        data: newImage!,
      );
      // resizeAndCompressImage(newImage!, (image) async {});
    }

    if (currentImage != null) {
      setModel(currentImage!);
    }
  }

  void setModel(String downloadImageUri) async {
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
    if (widget.eventModel != null) {
      await widget.eventRepo.edit(model).then((_) => finish());
    } else {

      await widget.eventRepo.add(model).then((_) => finish());

    }
  }

  void finish() {
    context.backPage();
    widget.success();
    Toast.show(message: 'Done');
  }

  Future<void> _downloadImage(String imagePath) async {
    try {
      final storageRef = FirebaseStorage.instance.ref(imagePath);
      const int maxSize =
          1024 * 1024 * 1; // Задайте максимальный размер (например, 10 MB)
      Uint8List? fileData = await storageRef.getData(maxSize);
      if (fileData != null) {
        setState(() {
          newImage = fileData;
        });
      }
    } catch (e) {
      print('Error image download: $e');
    }
  }
}
